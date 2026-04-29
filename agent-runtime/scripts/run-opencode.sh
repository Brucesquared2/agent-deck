#!/bin/sh
# run-opencode.sh — launch the OpenCode runtime adapter
# Usage: sh scripts/run-opencode.sh [opencode args...]
set -eu

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
RUNTIME_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

# Load .env if present (never committed)
if [ -f "$RUNTIME_DIR/.env" ]; then
  # shellcheck disable=SC1091
  . "$RUNTIME_DIR/.env"
fi

# Sync shared assets
sh "$SCRIPT_DIR/sync-skills.sh"

# Check OpenCode is installed
if ! command -v opencode > /dev/null 2>&1; then
  echo "ERROR: opencode not found. See https://opencode.ai for installation." >&2
  exit 1
fi

cd "$RUNTIME_DIR/opencode"
echo "==> Starting OpenCode from $RUNTIME_DIR/opencode"
exec opencode "$@"
