#!/bin/sh
# Launch OpenCode with agent-runtime adapter config
# Usage: ./run-opencode.sh [--agent planner|implementer|reviewer|pi]

set -eu

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

exec opencode --config "$ROOT/opencode/opencode.config.json" "$@"
