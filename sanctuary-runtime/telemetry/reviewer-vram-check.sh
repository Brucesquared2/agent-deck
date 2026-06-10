#!/bin/sh
# reviewer-vram-check.sh — Query Prometheus and enforce VRAM / temp policies.
#
# Policies:
#   VRAM > 80%    → block teleport (exit 1)
#   VRAM > 85%    → additionally advise pause render lane (exit 1)
#   GPU temp > 80°C → throttle warning (printed, does not block alone)
#
# Usage:
#   reviewer-vram-check.sh [--prometheus-url URL]
#
# Dependencies:
#   - curl (preferred) or wget
#   - jq (preferred) or python3 (fallback JSON parser)
#
# If neither jq nor python3 is available, the script prints instructions and
# exits 0 (fail-open) to avoid blocking when monitoring is unavailable.
#
# POSIX sh.

set -eu

PROMETHEUS_URL="${SANCTUARY_PROMETHEUS_URL:-http://localhost:9090}"
VRAM_BLOCK_PCT=80
VRAM_WARN_PCT=85
TEMP_WARN_C=80

# Parse optional --prometheus-url argument
while [ $# -gt 0 ]; do
    case "$1" in
        --prometheus-url)
            PROMETHEUS_URL="$2"
            shift 2
            ;;
        --prometheus-url=*)
            PROMETHEUS_URL="${1#*=}"
            shift
            ;;
        *)
            echo "Unknown argument: $1" >&2
            echo "Usage: $0 [--prometheus-url URL]" >&2
            exit 1
            ;;
    esac
done

# ── HTTP helper ──────────────────────────────────────────────────────────────
http_get() {
    _url="$1"
    if command -v curl > /dev/null 2>&1; then
        curl -sf "$_url"
    elif command -v wget > /dev/null 2>&1; then
        wget -qO- "$_url"
    else
        echo "[vram-check] ERROR: neither curl nor wget found. Cannot query Prometheus." >&2
        return 1
    fi
}

# ── JSON parser ──────────────────────────────────────────────────────────────
# Extract the first result value from a Prometheus JSON response.
# Uses jq if available, otherwise python3, otherwise prints an error.
extract_first_value() {
    _json="$1"
    if command -v jq > /dev/null 2>&1; then
        echo "$_json" | jq -r '.data.result[0].value[1] // "null"'
    elif command -v python3 > /dev/null 2>&1; then
        echo "$_json" | python3 -c "
import sys, json
data = json.load(sys.stdin)
results = data.get('data', {}).get('result', [])
if results:
    print(results[0]['value'][1])
else:
    print('null')
"
    else
        echo "null"
    fi
}

# ── Prometheus query helper ──────────────────────────────────────────────────
prom_query() {
    _promql="$1"
    _encoded="$(printf '%s' "$_promql" | sed 's/ /%20/g; s/{/%7B/g; s/}/%7D/g; s|/|%2F|g; s|(|%28/g; s|)|%29|g; s|\*|%2A|g; s|+|%2B|g')"
    http_get "${PROMETHEUS_URL}/api/v1/query?query=${_encoded}"
}

# ── Dependency check ─────────────────────────────────────────────────────────
has_parser() {
    command -v jq > /dev/null 2>&1 || command -v python3 > /dev/null 2>&1
}

has_http() {
    command -v curl > /dev/null 2>&1 || command -v wget > /dev/null 2>&1
}

if ! has_http; then
    echo "[vram-check] WARNING: curl/wget not found. Cannot check VRAM. Proceeding fail-open." >&2
    echo "[vram-check] Install curl: apt-get install -y curl" >&2
    exit 0
fi

if ! has_parser; then
    echo "[vram-check] WARNING: jq/python3 not found. Cannot parse Prometheus response." >&2
    echo "[vram-check] Install jq: apt-get install -y jq  OR  ensure python3 is in PATH." >&2
    echo "[vram-check] Proceeding fail-open." >&2
    exit 0
fi

# ── Query VRAM ────────────────────────────────────────────────────────────────
echo "[vram-check] Querying Prometheus at $PROMETHEUS_URL ..."

vram_used_json="$(prom_query 'DCGM_FI_DEV_FB_USED' 2>/dev/null || echo '{}')"
vram_free_json="$(prom_query 'DCGM_FI_DEV_FB_FREE' 2>/dev/null || echo '{}')"
temp_json="$(prom_query 'DCGM_FI_DEV_GPU_TEMP' 2>/dev/null || echo '{}')"

vram_used="$(extract_first_value "$vram_used_json")"
vram_free="$(extract_first_value "$vram_free_json")"
temp_c="$(extract_first_value "$temp_json")"

if [ "$vram_used" = "null" ] || [ "$vram_free" = "null" ]; then
    echo "[vram-check] WARNING: VRAM metrics unavailable (no GPU data in Prometheus). Proceeding fail-open." >&2
    exit 0
fi

# Compute VRAM percentage using python3 (POSIX sh has no float arithmetic)
vram_pct="$(python3 -c "
used = float('$vram_used')
free = float('$vram_free')
total = used + free
if total == 0:
    print('0')
else:
    print('{:.1f}'.format(used / total * 100))
" 2>/dev/null || echo "0")"

echo "[vram-check] VRAM usage: ${vram_pct}%"

# ── GPU temperature check ─────────────────────────────────────────────────────
if [ "$temp_c" != "null" ]; then
    echo "[vram-check] GPU temp: ${temp_c}°C"
    temp_exceeded="$(python3 -c "print('yes' if float('$temp_c') > $TEMP_WARN_C else 'no')" 2>/dev/null || echo "no")"
    if [ "$temp_exceeded" = "yes" ]; then
        echo "[vram-check] WARNING: GPU temp ${temp_c}°C > ${TEMP_WARN_C}°C — throttle warning active." >&2
    fi
fi

# ── VRAM policy enforcement ───────────────────────────────────────────────────
vram_over_warn="$(python3 -c "print('yes' if float('$vram_pct') > $VRAM_WARN_PCT else 'no')" 2>/dev/null || echo "no")"
vram_over_block="$(python3 -c "print('yes' if float('$vram_pct') > $VRAM_BLOCK_PCT else 'no')" 2>/dev/null || echo "no")"

if [ "$vram_over_warn" = "yes" ]; then
    echo "[vram-check] ADVISORY: VRAM ${vram_pct}% > ${VRAM_WARN_PCT}% — advise pause render lane." >&2
fi

if [ "$vram_over_block" = "yes" ]; then
    echo "[vram-check] BLOCKED: VRAM ${vram_pct}% > ${VRAM_BLOCK_PCT}% — teleport blocked." >&2
    exit 1
fi

echo "[vram-check] OK: VRAM within safe limits."
exit 0
