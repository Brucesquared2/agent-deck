#!/bin/sh
# run-aider.sh — Launch Aider against agent-runtime shared resources.
set -eu
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR/../aider"
bash "$SCRIPT_DIR/sync-skills.sh" aider
exec aider \
  --read ../shared/memory/50-maps/INDEX.md \
  --read ../shared/memory/50-maps/MEMORY_MAP.md \
  "$@"
