#!/bin/sh
# run-opencode.sh — Launch OpenCode against agent-runtime shared resources.
set -eu
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR/../opencode"
bash "$SCRIPT_DIR/sync-skills.sh" opencode
exec opencode "$@"
