#!/usr/bin/env python3
"""
vram_teleport.py — Precision loader stub for VRAM-aware model teleportation.

Queries Prometheus for VRAM usage and GPU temperature, then decides whether
it is safe to load/teleport a model.  This is a stub — fill in the
MODEL_LOAD_COMMAND and PROMETHEUS_URL for your environment.

Usage:
    python3 vram_teleport.py [--prometheus-url URL] [--dry-run]

Exit codes:
    0  — safe to teleport
    1  — VRAM or temperature threshold exceeded; teleport blocked
    2  — Prometheus unreachable or query error (fail-open by default; see --fail-closed)

Requirements:
    Python 3.7+, urllib (stdlib only — no pip dependencies).

TODO:
    - Set PROMETHEUS_URL to your hub address
    - Set MODEL_LOAD_COMMAND to the command that actually loads the model
    - Adjust VRAM_BLOCK_PCT and TEMP_BLOCK_C thresholds as needed
"""

import argparse
import json
import sys
import urllib.error
import urllib.parse
import urllib.request

# ── Configuration ────────────────────────────────────────────────────────────
PROMETHEUS_URL = "http://localhost:9090"  # TODO: set to your Prometheus hub URL
VRAM_BLOCK_PCT = 80.0   # Block teleport above this VRAM%
VRAM_WARN_PCT  = 85.0   # Also advise pause render lane above this
TEMP_WARN_C    = 80.0   # GPU throttle warning above this temperature (°C)

# Prometheus metric names (adjust if your DCGM exporters use different labels)
QUERY_VRAM_USED  = 'DCGM_FI_DEV_FB_USED'
QUERY_VRAM_FREE  = 'DCGM_FI_DEV_FB_FREE'
QUERY_TEMP       = 'DCGM_FI_DEV_GPU_TEMP'

# TODO: replace with the actual model-load command for your environment
MODEL_LOAD_COMMAND = "echo 'TODO: replace with actual model load command'"
# ─────────────────────────────────────────────────────────────────────────────


def query_prometheus(base_url: str, promql: str) -> list:
    """Return the 'result' list from a Prometheus instant query, or raise."""
    params = urllib.parse.urlencode({"query": promql})
    url = f"{base_url.rstrip('/')}/api/v1/query?{params}"
    req = urllib.request.Request(url, headers={"Accept": "application/json"})
    with urllib.request.urlopen(req, timeout=10) as resp:
        data = json.loads(resp.read().decode())
    if data.get("status") != "success":
        raise RuntimeError(f"Prometheus query failed: {data}")
    return data["data"]["result"]


def first_value(results: list) -> float | None:
    """Return the first scalar value from a Prometheus result list."""
    if not results:
        return None
    # result[i] = {"metric": {...}, "value": [timestamp, "value_str"]}
    return float(results[0]["value"][1])


def compute_vram_pct(base_url: str) -> float | None:
    """Return VRAM usage as a percentage, or None if unavailable."""
    used_results = query_prometheus(base_url, QUERY_VRAM_USED)
    free_results = query_prometheus(base_url, QUERY_VRAM_FREE)
    used = first_value(used_results)
    free = first_value(free_results)
    if used is None or free is None:
        return None
    total = used + free
    if total == 0:
        return None
    return (used / total) * 100.0


def main(argv=None):
    parser = argparse.ArgumentParser(description="VRAM-aware model teleport gate")
    parser.add_argument("--prometheus-url", default=PROMETHEUS_URL,
                        help="Prometheus base URL (default: %(default)s)")
    parser.add_argument("--dry-run", action="store_true",
                        help="Print decision without executing load command")
    parser.add_argument("--fail-closed", action="store_true",
                        help="Exit 2 (block) if Prometheus is unreachable instead of fail-open")
    args = parser.parse_args(argv)

    try:
        vram_pct = compute_vram_pct(args.prometheus_url)
        temp_results = query_prometheus(args.prometheus_url, QUERY_TEMP)
        temp_c = first_value(temp_results)
    except (urllib.error.URLError, OSError, RuntimeError, KeyError) as exc:
        print(f"[vram_teleport] WARNING: Cannot reach Prometheus: {exc}", file=sys.stderr)
        if args.fail_closed:
            print("[vram_teleport] BLOCKED (fail-closed mode).", file=sys.stderr)
            sys.exit(2)
        else:
            print("[vram_teleport] Proceeding fail-open (use --fail-closed to block instead).",
                  file=sys.stderr)
            sys.exit(0)

    blocked = False

    if vram_pct is not None:
        print(f"[vram_teleport] VRAM usage: {vram_pct:.1f}%")
        if vram_pct > VRAM_WARN_PCT:
            print(f"[vram_teleport] ADVISORY: VRAM > {VRAM_WARN_PCT}% — advise pause render lane.",
                  file=sys.stderr)
            blocked = True
        if vram_pct > VRAM_BLOCK_PCT:
            print(f"[vram_teleport] BLOCKED: VRAM > {VRAM_BLOCK_PCT}% — teleport not safe.",
                  file=sys.stderr)
            blocked = True
    else:
        print("[vram_teleport] WARNING: VRAM metrics unavailable.", file=sys.stderr)

    if temp_c is not None:
        print(f"[vram_teleport] GPU temp: {temp_c:.1f}°C")
        if temp_c > TEMP_WARN_C:
            print(f"[vram_teleport] WARNING: GPU temp > {TEMP_WARN_C}°C — throttle warning.",
                  file=sys.stderr)

    if blocked:
        sys.exit(1)

    if args.dry_run:
        print(f"[vram_teleport] DRY RUN: would execute: {MODEL_LOAD_COMMAND}")
    else:
        import subprocess  # noqa: PLC0415
        print(f"[vram_teleport] Executing: {MODEL_LOAD_COMMAND}")
        result = subprocess.run(MODEL_LOAD_COMMAND, shell=True)  # noqa: S602
        sys.exit(result.returncode)


if __name__ == "__main__":
    main()
