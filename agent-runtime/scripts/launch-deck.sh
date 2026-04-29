#!/bin/sh
# launch-deck.sh — launch Agent Deck cockpit pointed at this runtime
# Usage: sh scripts/launch-deck.sh [agent-deck args...]
set -eu

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
RUNTIME_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

# Load .env if present (never committed)
if [ -f "$RUNTIME_DIR/.env" ]; then
  # shellcheck disable=SC1091
  . "$RUNTIME_DIR/.env"
fi

# Check Agent Deck is installed
if ! command -v agent-deck > /dev/null 2>&1; then
  echo "ERROR: agent-deck not found." >&2
  echo "Install with:" >&2
  echo "  curl -fsSL https://raw.githubusercontent.com/asheshgoplani/agent-deck/main/install.sh | bash" >&2
  exit 1
fi

cd "$RUNTIME_DIR"
echo "==> Launching Agent Deck from $RUNTIME_DIR"
echo "    Config: agent-deck/config.toml"
exec agent-deck --config agent-deck/config.toml "$@"
