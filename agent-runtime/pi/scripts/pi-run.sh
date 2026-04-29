#!/bin/sh
# Run the Pi coding agent with agent-runtime adapter config
# Usage: ./pi-run.sh [--agent planner|implementer|reviewer|pi]

set -eu

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PI_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
SHARED_DIR="$(cd "$PI_DIR/../shared" && pwd)"

AGENT="${PI_AGENT:-implementer}"
SYSTEM_PROMPT="$SHARED_DIR/agents/$AGENT.md"

if [ ! -f "$SYSTEM_PROMPT" ]; then
  echo "ERROR: Agent prompt not found: $SYSTEM_PROMPT" >&2
  exit 1
fi

# Adjust the command below to match your Pi installation
exec pi \
  --system "$SYSTEM_PROMPT" \
  --context "$SHARED_DIR/memory/maps/INDEX.md" \
  --context "$SHARED_DIR/memory/core/MISSION.md" \
  --context "$SHARED_DIR/memory/core/PRINCIPLES.md" \
  "$@"
