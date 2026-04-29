#!/bin/sh
# sync-skills.sh — copy shared/agents and shared/skills into each adapter folder
#
# This script performs a plain file copy (no symlinks) so it works cross-platform
# on Linux, macOS, and Windows (WSL/Git Bash).
#
# Usage: sh scripts/sync-skills.sh
set -eu

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
RUNTIME_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

SHARED_AGENTS="$RUNTIME_DIR/shared/agents"
SHARED_SKILLS="$RUNTIME_DIR/shared/skills"

# Adapters that receive copies of shared agents and skills
ADAPTERS="opencode aider pi"

echo "==> Syncing shared assets into adapter folders"
echo "    Source agents : $SHARED_AGENTS"
echo "    Source skills : $SHARED_SKILLS"
echo ""

for ADAPTER in $ADAPTERS; do
  DEST="$RUNTIME_DIR/$ADAPTER"

  if [ ! -d "$DEST" ]; then
    echo "  [skip] adapter directory not found: $DEST"
    continue
  fi

  # Sync agents
  DEST_AGENTS="$DEST/agents"
  mkdir -p "$DEST_AGENTS"
  cp -r "$SHARED_AGENTS/." "$DEST_AGENTS/"
  echo "  [sync] $ADAPTER/agents/ ← shared/agents/"

  # Sync skills
  DEST_SKILLS="$DEST/skills"
  mkdir -p "$DEST_SKILLS"
  cp -r "$SHARED_SKILLS/." "$DEST_SKILLS/"
  echo "  [sync] $ADAPTER/skills/ ← shared/skills/"
done

echo ""
echo "==> Sync complete."
