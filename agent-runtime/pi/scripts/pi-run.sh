#!/bin/sh
# pi-run.sh — launch the Pi coding-agent runtime
# Usage: sh pi/scripts/pi-run.sh [pi args...]
#
# NOTE: This is a placeholder script. Replace the `pi` command below with the
# actual invocation for your Pi distribution (e.g. `bun run pi`, `node pi/index.js`,
# `python -m pi`, etc.).
set -eu

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PI_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
RUNTIME_DIR="$(cd "$PI_DIR/.." && pwd)"

# Sync shared assets before launching
sh "$RUNTIME_DIR/scripts/sync-skills.sh"

# Check Pi is installed
# Replace 'pi' below with the actual binary/command for your Pi distribution.
if ! command -v pi > /dev/null 2>&1; then
  echo "ERROR: 'pi' command not found." >&2
  echo "Install your Pi distribution and ensure it is on PATH." >&2
  echo "Common options:" >&2
  echo "  bun install -g pi" >&2
  echo "  npm install -g @badlogic/pi" >&2
  exit 1
fi

cd "$PI_DIR"

echo "==> Starting Pi from $PI_DIR"
# Replace the command below with the correct invocation for your Pi version:
exec pi --agents AGENTS.md "$@"
