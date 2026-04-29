#!/bin/sh
# Summarize the current session and update maps/INDEX.md
# Usage: ./memory-summarize-session.sh <session-id>
#
# This script guides the user/agent through filling in the session summary
# and then updates INDEX.md to mark the session as completed.

set -eu

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
SESSIONS_DIR="$ROOT/shared/memory/sessions"
INDEX="$ROOT/shared/memory/maps/INDEX.md"

SESSION_ID="${1:-}"
if [ -z "$SESSION_ID" ]; then
  # Try to find the most recent active session
  SESSION_ID="$(ls -1 "$SESSIONS_DIR" | grep -E '^[0-9]{4}-[0-9]{2}-[0-9]{2}-[0-9]{3}$' | sort | tail -1)"
fi

if [ -z "$SESSION_ID" ]; then
  echo "ERROR: No session ID provided and no sessions found." >&2
  echo "Usage: $0 <session-id>" >&2
  exit 1
fi

SESSION_DIR="$SESSIONS_DIR/$SESSION_ID"
SUMMARY="$SESSION_DIR/summary.md"

if [ ! -d "$SESSION_DIR" ]; then
  echo "ERROR: Session directory not found: $SESSION_DIR" >&2
  exit 1
fi

echo "=== Session Summarization: $SESSION_ID ==="
echo ""
echo "Summary file: $SUMMARY"
echo ""
echo "Please fill in the summary at:"
echo "  $SUMMARY"
echo ""
echo "Sections to complete:"
echo "  - What Was Accomplished"
echo "  - Key Decisions (link to DECISION_LOG.md)"
echo "  - New Knowledge Filed"
echo "  - Outstanding Items"
echo "  - Next Session Start"
echo ""

# Wait for user/agent to confirm they've filled the summary
printf "Press ENTER when the summary is complete (or Ctrl+C to cancel)..."
read -r _dummy || true

echo ""

# Mark session as Completed in INDEX.md
if [ -f "$INDEX" ]; then
  TMPFILE="$(mktemp)"
  sed "s/| $SESSION_ID .*Active.*|/| $SESSION_ID | $(date +%Y-%m-%d) | Completed | See summary.md |/" \
    "$INDEX" > "$TMPFILE"
  mv "$TMPFILE" "$INDEX"
  echo "Updated INDEX.md: $SESSION_ID marked as Completed."
fi

echo ""
echo "Session $SESSION_ID summarized."
echo ""
echo "Next steps:"
echo "  1. Archive any scratch/ items worth keeping → knowledge/"
echo "  2. Delete remaining scratch/ items"
echo "  3. Run memory-tag-refresh.sh to update indexes"
