#!/bin/sh
# Create a new session folder with timestamp and templates
# Usage: ./memory-new-session.sh [session-label]
#
# Creates: agent-runtime/shared/memory/sessions/YYYY-MM-DD-NNN/
#   with log.md and summary.md from templates

set -eu

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
SESSIONS_DIR="$ROOT/shared/memory/sessions"
TEMPLATE_DIR="$SESSIONS_DIR/_template"

TODAY="$(date +%Y-%m-%d)"

# Find the next sequence number for today
NNN=1
while [ -d "$SESSIONS_DIR/${TODAY}-$(printf '%03d' $NNN)" ]; do
  NNN=$((NNN + 1))
done

SESSION_ID="${TODAY}-$(printf '%03d' $NNN)"
SESSION_DIR="$SESSIONS_DIR/$SESSION_ID"

echo "Creating session: $SESSION_ID"
mkdir -p "$SESSION_DIR"

# Copy templates and substitute session ID
for tmpl in log.md summary.md; do
  if [ -f "$TEMPLATE_DIR/$tmpl" ]; then
    sed "s/<SESSION_ID>/$SESSION_ID/g; s/YYYY-MM-DD/$TODAY/g" \
      "$TEMPLATE_DIR/$tmpl" > "$SESSION_DIR/$tmpl"
    echo "  Created: $SESSION_DIR/$tmpl"
  fi
done

# Update INDEX.md
INDEX="$ROOT/shared/memory/maps/INDEX.md"
if [ -f "$INDEX" ]; then
  # Append new session row to the Active Sessions table if not already present
  if ! grep -q "$SESSION_ID" "$INDEX"; then
    # Use a temp file to insert before the blank line after the table header
    TMPFILE="$(mktemp)"
    awk -v sid="$SESSION_ID" -v today="$TODAY" '
      /^\| Session ID/ { found=1 }
      found && /^\s*$/ && !inserted {
        print "| " sid " | " today " | Active | (in progress) |"
        inserted=1
      }
      { print }
    ' "$INDEX" > "$TMPFILE"
    mv "$TMPFILE" "$INDEX"
    echo "  Updated: $INDEX"
  fi
fi

echo ""
echo "Session started: $SESSION_ID"
echo "Log:     $SESSION_DIR/log.md"
echo "Summary: $SESSION_DIR/summary.md"
echo ""
echo "Next steps:"
echo "  1. Read memory/maps/INDEX.md"
echo "  2. Read memory/sessions/<previous>/summary.md"
echo "  3. Read memory/core/MISSION.md"
