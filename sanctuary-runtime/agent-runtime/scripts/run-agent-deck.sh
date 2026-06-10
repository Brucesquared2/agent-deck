#!/bin/sh
# run-agent-deck.sh — Launch Agent Deck against agent-runtime shared resources.
set -eu
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR/../agent-deck"
bash "$SCRIPT_DIR/sync-skills.sh" agent-deck
exec agent-deck "$@"
