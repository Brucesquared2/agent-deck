#!/bin/sh
# run-pi.sh — launch the Pi coding-agent runtime adapter
# Usage: sh scripts/run-pi.sh [pi args...]
#
# NOTE: Replace the `pi` invocation below with the correct command for your
# Pi distribution (e.g. `bun run pi`, `node pi/index.js`, etc.).
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

# Check Pi is installed
# Replace 'pi' with the actual command for your Pi distribution.
if ! command -v pi > /dev/null 2>&1; then
  echo "ERROR: 'pi' command not found." >&2
  echo "Install your Pi distribution and ensure it is on PATH." >&2
  exit 1
fi

cd "$RUNTIME_DIR/pi"
echo "==> Starting Pi from $RUNTIME_DIR/pi"
exec pi --agents AGENTS.md "$@"
