#!/bin/sh
# Launch Aider with agent-runtime adapter config
# Usage: AIDER_AGENT=planner ./run-aider.sh

set -eu

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

exec sh "$ROOT/aider/scripts/aider-run.sh" "$@"
