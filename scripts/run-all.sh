#!/bin/sh
# run-all.sh — run all agent-runtime verification and maintenance scripts.
#
# This is the single entry point for CI and manual maintenance.
# Each script is invoked in dependency order; failure stops the chain.
#
# Environment variables forwarded to sub-scripts:
#   AGENT_DECK_REVIEWER_VRAM_CHECK   — set to 1 to enable VRAM gate
#   AGENT_DECK_REVIEWER_VRAM_MIN_GB  — minimum required VRAM in GB (default 8)
#
# POSIX sh; no GNU-only flags.

set -eu

SCRIPTS_DIR="$(cd "$(dirname "$0")" && pwd)"

log()  { printf '[run-all] %s\n' "$*"; }
ok()   { printf '[run-all] OK: %s\n' "$*"; }
fail() { printf '[run-all] FAIL: %s\n' "$*" >&2; exit 1; }

run() {
  script="$1"
  shift
  log "Running ${script} $*"
  if "${SCRIPTS_DIR}/${script}" "$@"; then
    ok "${script}"
  else
    fail "${script} exited non-zero"
  fi
}

# 1. Regenerate memory indexes
run refresh-indexes.sh

# 2. Optional VRAM gate (no-op by default)
run reviewer-vram-check.sh

log "All checks passed."
