#!/bin/sh
# Sync shared skills to each adapter runtime
# Usage: ./sync-skills.sh

set -eu

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
SHARED_SKILLS="$ROOT/shared/skills"

for runtime in opencode aider pi; do
  dest="$ROOT/$runtime/skills"
  echo "Syncing skills → $dest ..."
  mkdir -p "$dest"
  cp -r "$SHARED_SKILLS/." "$dest/"
  echo "  Done."
done

echo "Skill sync complete."
