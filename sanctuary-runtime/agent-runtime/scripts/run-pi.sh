#!/bin/sh
# run-pi.sh — Launch Pi against agent-runtime shared resources.
set -eu
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR/../pi"
bash "$SCRIPT_DIR/sync-skills.sh" pi
exec pi "$@"
