#!/bin/sh
# run-aider.sh — launch the Aider runtime adapter
# Usage: sh scripts/run-aider.sh [aider args...]
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

# Check Aider is installed
if ! command -v aider > /dev/null 2>&1; then
  echo "ERROR: aider not found. Install with: pip install aider-chat" >&2
  exit 1
fi

cd "$RUNTIME_DIR/aider"
echo "==> Starting Aider from $RUNTIME_DIR/aider"
exec aider --config aider.conf.yml "$@"
