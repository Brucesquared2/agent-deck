#!/bin/sh
# run-all.sh — sync shared assets and launch all three runtime adapters in the
# background, then launch Agent Deck in the foreground.
#
# Usage: sh scripts/run-all.sh
# Stop with Ctrl-C (Agent Deck will exit; background adapters must be stopped
# manually or via Agent Deck's session manager).
set -eu

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
RUNTIME_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

# Load .env if present (never committed)
if [ -f "$RUNTIME_DIR/.env" ]; then
  # shellcheck disable=SC1091
  . "$RUNTIME_DIR/.env"
fi

echo "==> Syncing shared assets"
sh "$SCRIPT_DIR/sync-skills.sh"

echo ""
echo "==> Starting runtime adapters in the background"

# OpenCode (background)
if command -v opencode > /dev/null 2>&1; then
  cd "$RUNTIME_DIR/opencode"
  opencode &
  OPENCODE_PID=$!
  echo "    OpenCode started (PID $OPENCODE_PID)"
else
  echo "    [skip] opencode not found on PATH"
fi

# Aider (background)
if command -v aider > /dev/null 2>&1; then
  cd "$RUNTIME_DIR/aider"
  aider --config aider.conf.yml &
  AIDER_PID=$!
  echo "    Aider started (PID $AIDER_PID)"
else
  echo "    [skip] aider not found on PATH"
fi

# Pi (background)
if command -v pi > /dev/null 2>&1; then
  cd "$RUNTIME_DIR/pi"
  pi --agents AGENTS.md &
  PI_PID=$!
  echo "    Pi started (PID $PI_PID)"
else
  echo "    [skip] pi not found on PATH"
fi

echo ""
echo "==> Launching Agent Deck (foreground)"
cd "$RUNTIME_DIR"

if command -v agent-deck > /dev/null 2>&1; then
  exec agent-deck --config agent-deck/config.toml
else
  echo "ERROR: agent-deck not found." >&2
  echo "Install with:" >&2
  echo "  curl -fsSL https://raw.githubusercontent.com/asheshgoplani/agent-deck/main/install.sh | bash" >&2
  exit 1
fi
