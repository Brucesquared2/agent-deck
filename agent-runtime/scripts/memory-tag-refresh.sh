#!/bin/sh
# Regenerate TAG_INDEX and ENTITY_INDEX from memory files
# Usage: ./memory-tag-refresh.sh
#
# Implementation:
#   - Scans all .md files under shared/memory/ for #tag patterns
#   - Builds a tag → file mapping
#   - Replaces the TAG_MAP section in maps/TAG_INDEX.md
#   - Scans ENTITY_INDEX.md for "Last updated:" entries and reports stale ones

set -eu

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
MEMORY_DIR="$ROOT/shared/memory"
TAG_INDEX="$MEMORY_DIR/maps/TAG_INDEX.md"

echo "=== Memory Tag Refresh ==="
echo ""
echo "Scanning $MEMORY_DIR ..."
echo ""

# Build tag map using grep
TMPMAP="$(mktemp)"

find "$MEMORY_DIR" -name "*.md" -not -path "*/_template/*" | sort | while read -r file; do
  relpath="${file#$MEMORY_DIR/}"
  # Extract all #tags from the file (word boundary: #word-with-hyphens)
  tags="$(grep -oE '#[a-z][a-z0-9-]*' "$file" 2>/dev/null | sort -u || true)"
  for tag in $tags; do
    printf '%s\t%s\n' "$tag" "$relpath"
  done
done | sort > "$TMPMAP"

# Group by tag and write to a temp markdown section
TMPMD="$(mktemp)"
printf '<!-- TAG_MAP_START -->\n' > "$TMPMD"
printf '| Tag | Files |\n|-----|-------|\n' >> "$TMPMD"

current_tag=""
files_str=""
while IFS="	" read -r tag file; do
  if [ "$tag" != "$current_tag" ]; then
    if [ -n "$current_tag" ]; then
      printf '| `%s` | %s |\n' "$current_tag" "$files_str" >> "$TMPMD"
    fi
    current_tag="$tag"
    files_str="$file"
  else
    files_str="$files_str, $file"
  fi
done < "$TMPMAP"
if [ -n "$current_tag" ]; then
  printf '| `%s` | %s |\n' "$current_tag" "$files_str" >> "$TMPMD"
fi
printf '<!-- TAG_MAP_END -->\n' >> "$TMPMD"

# Replace TAG_MAP section in TAG_INDEX.md
TMPINDEX="$(mktemp)"
awk '
  /<!-- TAG_MAP_START -->/ { skip=1; next }
  /<!-- TAG_MAP_END -->/   { skip=0; next }
  !skip { print }
' "$TAG_INDEX" > "$TMPINDEX"

# Append new tag map at the end of the file
cat "$TMPINDEX" "$TMPMD" > "$TAG_INDEX"

rm -f "$TMPMAP" "$TMPMD" "$TMPINDEX"

echo "TAG_INDEX.md updated."

# Report stale entity entries (last updated > 90 days ago)
ENTITY_INDEX="$MEMORY_DIR/maps/ENTITY_INDEX.md"
echo ""
echo "Checking ENTITY_INDEX.md for stale entries (>90 days)..."
CUTOFF="$(date -d '90 days ago' +%Y-%m-%d 2>/dev/null || date -v-90d +%Y-%m-%d 2>/dev/null || date +%Y-%m-%d)"
grep "Last updated:" "$ENTITY_INDEX" | while read -r line; do
  entry_date="$(echo "$line" | grep -oE '[0-9]{4}-[0-9]{2}-[0-9]{2}')"
  if [ -n "$entry_date" ] && [ "$entry_date" \< "$CUTOFF" ]; then
    echo "  STALE (last updated $entry_date): $line"
  fi
done || true

echo ""
echo "Tag refresh complete."
echo "Updated: $TAG_INDEX"
