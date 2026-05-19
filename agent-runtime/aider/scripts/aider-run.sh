#!/bin/sh
# Run aider with the agent-runtime adapter config
# Usage: ./aider-run.sh [--agent planner|implementer|reviewer|pi]

set -eu

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
AIDER_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
SHARED_DIR="$(cd "$AIDER_DIR/../shared" && pwd)"

AGENT="${AIDER_AGENT:-implementer}"
SYSTEM_PROMPT="$SHARED_DIR/agents/$AGENT.md"

if [ ! -f "$SYSTEM_PROMPT" ]; then
  echo "ERROR: Agent prompt not found: $SYSTEM_PROMPT" >&2
  exit 1
fi

exec aider \
  --config "$AIDER_DIR/aider.conf.yml" \
  --system-prompt "$SYSTEM_PROMPT" \
  "$@"
