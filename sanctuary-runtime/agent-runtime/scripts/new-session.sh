#!/bin/sh
# new-session.sh — Create a new dated session folder under shared/memory/30-sessions/.
#
# Usage:
#   new-session.sh <slug>
#
# Creates:
#   shared/memory/30-sessions/YYYY/MM/YYYY-MM-DD_HHMMZ_<slug>/
#   ├── raw.md
#   └── summary.md
#
# POSIX sh. No external dependencies.

set -eu

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SESSIONS_DIR="$SCRIPT_DIR/../shared/memory/30-sessions"

if [ -z "${1:-}" ]; then
    echo "Usage: $0 <slug>" >&2
    echo "Example: $0 add-vram-gate" >&2
    exit 1
fi

slug="$1"

# Build timestamp components
year="$(date -u '+%Y')"
month="$(date -u '+%m')"
datestamp="$(date -u '+%Y-%m-%d')"
timestamp="$(date -u '+%H%MZ')"
folder="${datestamp}_${timestamp}_${slug}"
full_path="$SESSIONS_DIR/$year/$month/$folder"

mkdir -p "$full_path"

# Create raw.md
cat > "$full_path/raw.md" <<EOF
# Session: $slug

**Started**: $(date -u '+%Y-%m-%dT%H:%M:%SZ')  
**Lane**: <!-- TODO: fill in lane -->  
**Agent**: <!-- TODO: planner | implementer | reviewer | pi -->  

---

<!-- Raw session log — write-once, never edit after session ends -->
EOF

# Create summary.md
cat > "$full_path/summary.md" <<EOF
# Session Summary: $slug

**Date**: $datestamp  
**Lane**: <!-- TODO -->  
**Outcome**: <!-- TODO: success | partial | blocked -->  

## Goal
<!-- TODO: one-sentence goal -->

## What Happened
<!-- TODO: brief narrative -->

## Artifacts Produced
<!-- TODO: list files/commits -->

## Promoted to Knowledge
<!-- TODO: list any items moved to 40-knowledge/ -->

## Next Actions
<!-- TODO: list next steps with assignee -->

## Tags
<!-- TODO: add tags from TAG_INDEX.md -->
EOF

echo "[new-session] Created: $full_path"
