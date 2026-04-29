#!/bin/sh
# new-session.sh — create a new session file from the template
# Usage: scripts/new-session.sh <project-slug> [session-id]
#
# Creates:
#   agent-runtime/shared/memory/30-sessions/YYYY-MM-DD-<session-id>.md
#
# POSIX sh; no GNU-only flags.

set -eu

MEMORY_ROOT="$(cd "$(dirname "$0")/../agent-runtime/shared/memory" 2>/dev/null && pwd)"
SESSIONS_DIR="${MEMORY_ROOT}/30-sessions"
TEMPLATE="${SESSIONS_DIR}/session-template.md"

# ---------- helpers ----------

die() { printf 'ERROR: %s\n' "$*" >&2; exit 1; }

usage() {
  printf 'Usage: %s <project-slug> [session-id]\n' "$0"
  printf '  project-slug  short name for the project (e.g. memory-layer)\n'
  printf '  session-id    optional; defaults to YYYY-MM-DD-<project-slug>\n'
  exit 1
}

# ---------- args ----------

[ "$#" -lt 1 ] && usage

PROJECT_SLUG="$1"
DATE="$(date -u '+%Y-%m-%d')"
TIMESTAMP="$(date -u '+%Y-%m-%dT%H:%M:%SZ')"

if [ "$#" -ge 2 ]; then
  SESSION_ID="$2"
else
  SESSION_ID="${DATE}-${PROJECT_SLUG}"
fi

OUTPUT="${SESSIONS_DIR}/${SESSION_ID}.md"

# ---------- checks ----------

[ -f "${TEMPLATE}" ] || die "Template not found: ${TEMPLATE}"
[ -f "${OUTPUT}" ]   && die "Session file already exists: ${OUTPUT}"

# ---------- create ----------

sed \
  -e "s/<YYYY-MM-DD>/${DATE}/g" \
  -e "s/<session-id>/${SESSION_ID}/g" \
  -e "s/<project-slug>/${PROJECT_SLUG}/g" \
  -e "s/<ISO-8601>/${TIMESTAMP}/g" \
  "${TEMPLATE}" > "${OUTPUT}"

printf 'Created session file: %s\n' "${OUTPUT}"
