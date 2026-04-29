#!/bin/sh
# Launch the Pi coding agent with agent-runtime adapter config
# Usage: PI_AGENT=reviewer ./run-pi.sh

set -eu

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

exec sh "$ROOT/pi/scripts/pi-run.sh" "$@"
