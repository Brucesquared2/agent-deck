#!/bin/sh
# sync-skills.sh — Copy shared/skills/ into one or all adapter directories.
#
# Usage:
#   sync-skills.sh [adapter]
#
# adapter: opencode | aider | pi | all (default: all)
#
# POSIX sh. No external dependencies.

set -eu

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SKILLS_SRC="$SCRIPT_DIR/../shared/skills"
ADAPTERS_DIR="$SCRIPT_DIR/.."

adapter="${1:-all}"

sync_adapter() {
    _adapter="$1"
    _dst="$ADAPTERS_DIR/$_adapter/skills"

    if [ ! -d "$ADAPTERS_DIR/$_adapter" ]; then
        echo "[sync-skills] WARNING: adapter directory not found: $ADAPTERS_DIR/$_adapter" >&2
        return 1
    fi

    mkdir -p "$_dst"
    cp -r "$SKILLS_SRC/." "$_dst/"
    echo "[sync-skills] Synced shared/skills -> $_adapter/skills"
}

case "$adapter" in
    opencode|aider|pi)
        sync_adapter "$adapter"
        ;;
    all)
        for a in opencode aider pi; do
            sync_adapter "$a" || true
        done
        ;;
    *)
        echo "Usage: $0 [opencode|aider|pi|all]" >&2
        exit 1
        ;;
esac

echo "[sync-skills] Done."
