#!/bin/sh
# Launch Agent Deck with agent-runtime config
# Usage: ./launch-deck.sh

set -eu

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
CONFIG="$ROOT/agent-deck/config.toml"

if ! command -v agent-deck >/dev/null 2>&1; then
  echo "ERROR: agent-deck not found. Install it:" >&2
  echo "  curl -fsSL https://raw.githubusercontent.com/asheshgoplani/agent-deck/main/install.sh | bash" >&2
  exit 1
fi

exec agent-deck --config "$CONFIG" "$@"
