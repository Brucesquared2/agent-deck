#!/bin/sh
# aider-run.sh — launch Aider with the agent-runtime config
# Usage: sh aider/scripts/aider-run.sh [aider args...]
set -eu

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
AIDER_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
RUNTIME_DIR="$(cd "$AIDER_DIR/.." && pwd)"

# Sync shared assets before launching
sh "$RUNTIME_DIR/scripts/sync-skills.sh"

# Check Aider is installed
if ! command -v aider > /dev/null 2>&1; then
  echo "ERROR: aider not found. Install with: pip install aider-chat" >&2
  exit 1
fi

cd "$AIDER_DIR"

echo "==> Starting Aider from $AIDER_DIR"
exec aider --config aider.conf.yml "$@"
