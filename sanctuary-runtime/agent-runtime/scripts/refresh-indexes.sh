#!/bin/sh
# refresh-indexes.sh — Regenerate TAG_INDEX and ENTITY_INDEX from memory files.
#
# This script scans shared/memory/ for:
#   - Tags (#tag-name) in any .md file
#   - Entities listed in ENTITY_INDEX.md
# and updates the "Last Refreshed" timestamp in TAG_INDEX.md and INDEX.md.
#
# Full regeneration of the full index bodies is intentionally left for agents
# (this script only refreshes timestamps and prints a summary of found tags).
#
# POSIX sh. No external dependencies beyond standard Unix tools.

set -eu

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
MEMORY_DIR="$SCRIPT_DIR/../shared/memory"
TAG_INDEX="$MEMORY_DIR/50-maps/TAG_INDEX.md"
INDEX_MD="$MEMORY_DIR/50-maps/INDEX.md"

timestamp="$(date -u '+%Y-%m-%dT%H:%M:%SZ')"

echo "[refresh-indexes] Scanning $MEMORY_DIR ..."

# Count .md files
md_count="$(find "$MEMORY_DIR" -name '*.md' | wc -l | tr -d ' ')"
echo "[refresh-indexes] Found $md_count markdown files."

# Collect all #tags found (simple grep, unique, sorted)
echo "[refresh-indexes] Tags found in memory:"
grep -roh '#[a-z][a-z0-9_-]*' "$MEMORY_DIR" --include='*.md' \
    | sed 's/.*://' \
    | sort -u \
    | while read -r tag; do
        echo "  $tag"
    done

# Update "Last Refreshed" line in TAG_INDEX.md
if [ -f "$TAG_INDEX" ]; then
    # Use sed in-place (portable: write to tmp then move)
    tmp="$(mktemp)"
    sed "s|_Not yet refreshed\\._|_Refreshed: $timestamp_|g" "$TAG_INDEX" > "$tmp"
    mv "$tmp" "$TAG_INDEX"
    echo "[refresh-indexes] Updated TAG_INDEX.md timestamp."
fi

# Update "Last Refreshed" line in INDEX.md
if [ -f "$INDEX_MD" ]; then
    tmp="$(mktemp)"
    sed "s|_Not yet refreshed\\._|_Refreshed: $timestamp_|g" "$INDEX_MD" > "$tmp"
    mv "$tmp" "$INDEX_MD"
    echo "[refresh-indexes] Updated INDEX.md timestamp."
fi

echo "[refresh-indexes] Done. Timestamp: $timestamp"
echo ""
echo "NOTE: Full index regeneration (adding new rows to TAG_INDEX / ENTITY_INDEX)"
echo "      should be done by the Planner or PI agent using memory context."
