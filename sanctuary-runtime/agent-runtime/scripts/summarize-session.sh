#!/bin/sh
# summarize-session.sh — Assist converting a raw session log into a summary.
#
# Usage:
#   summarize-session.sh <session-path>
#
# session-path: path to a session folder (containing raw.md and summary.md)
#
# This script prints instructions and the raw log to stdout so an agent or
# human can produce the summary.  It does NOT call an LLM directly — it
# integrates with whatever agent runtime is active.
#
# POSIX sh. No external dependencies.

set -eu

if [ -z "${1:-}" ]; then
    echo "Usage: $0 <session-path>" >&2
    echo "Example: $0 shared/memory/30-sessions/2026/04/2026-04-29_1200Z_add-vram-gate" >&2
    exit 1
fi

session_path="$1"
raw="$session_path/raw.md"
summary="$session_path/summary.md"

if [ ! -f "$raw" ]; then
    echo "ERROR: raw.md not found in $session_path" >&2
    exit 1
fi

echo "========================================"
echo " Session Summarization Assistant"
echo " Path: $session_path"
echo "========================================"
echo ""
echo "--- raw.md ---"
cat "$raw"
echo ""
echo "--- end raw.md ---"
echo ""
echo "INSTRUCTIONS FOR AGENT:"
echo "1. Read the raw.md above."
echo "2. Fill in summary.md at: $summary"
echo "3. Required sections: Goal, What Happened, Artifacts Produced,"
echo "   Promoted to Knowledge, Next Actions, Tags."
echo "4. After filling summary.md, move promoted items to shared/memory/40-knowledge/."
echo "5. Update shared/memory/50-maps/TAG_INDEX.md and ENTITY_INDEX.md as needed."
echo "6. Run scripts/refresh-indexes.sh when done."
