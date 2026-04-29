#!/bin/sh
# Launch all three runtimes and Agent Deck
# Usage: ./run-all.sh
#
# NOTE: This starts each runtime in the background and Agent Deck in the foreground.
# Kill the agent-deck process to stop all sessions.

set -eu

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Starting agent-runtime sessions..."

# Sync skills to all adapters first
sh "$SCRIPT_DIR/sync-skills.sh"

# Launch Agent Deck (manages OpenCode/Aider/Pi sessions)
exec sh "$SCRIPT_DIR/launch-deck.sh" "$@"
