#!/bin/sh
# reviewer-vram-check.sh — optional VRAM gate for Reviewer workflows.
#
# Default behaviour: exits 0 (no-op) so pipelines without a GPU are not blocked.
#
# To enable the actual check, set:
#   AGENT_DECK_REVIEWER_VRAM_CHECK=1
#   AGENT_DECK_REVIEWER_VRAM_MIN_GB=<minimum required GB>  (default: 8)
#
# The check queries nvidia-smi; if nvidia-smi is absent the script exits 0
# with a warning, so non-NVIDIA hosts are also unaffected.
#
# POSIX sh; no GNU-only flags.

set -eu

VRAM_CHECK="${AGENT_DECK_REVIEWER_VRAM_CHECK:-0}"
VRAM_MIN_GB="${AGENT_DECK_REVIEWER_VRAM_MIN_GB:-8}"

# No-op path (default)
if [ "${VRAM_CHECK}" != "1" ]; then
  printf '[reviewer-vram-check] VRAM gate disabled (set AGENT_DECK_REVIEWER_VRAM_CHECK=1 to enable).\n'
  exit 0
fi

# Check for nvidia-smi
if ! command -v nvidia-smi >/dev/null 2>&1; then
  printf '[reviewer-vram-check] WARN: nvidia-smi not found; skipping VRAM check.\n'
  exit 0
fi

# Query free VRAM in MiB on GPU 0
FREE_MIB="$(nvidia-smi --query-gpu=memory.free --format=csv,noheader,nounits 2>/dev/null | head -1 | tr -d ' ')"

if [ -z "${FREE_MIB}" ]; then
  printf '[reviewer-vram-check] WARN: could not read VRAM info from nvidia-smi; skipping check.\n'
  exit 0
fi

# Convert minimum GB to MiB for comparison (integer arithmetic)
VRAM_MIN_MIB="$((VRAM_MIN_GB * 1024))"

if [ "${FREE_MIB}" -lt "${VRAM_MIN_MIB}" ]; then
  printf '[reviewer-vram-check] FAIL: free VRAM %s MiB < required %s MiB (%s GB).\n' \
    "${FREE_MIB}" "${VRAM_MIN_MIB}" "${VRAM_MIN_GB}" >&2
  exit 1
fi

printf '[reviewer-vram-check] PASS: free VRAM %s MiB >= required %s MiB (%s GB).\n' \
  "${FREE_MIB}" "${VRAM_MIN_MIB}" "${VRAM_MIN_GB}"
exit 0
