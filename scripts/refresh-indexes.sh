#!/bin/sh
# refresh-indexes.sh — regenerate TAG_INDEX.md and ENTITY_INDEX.md
# from simple grep heuristics over agent-runtime/shared/memory/.
#
# POSIX sh; no GNU-only flags.
# Safe to run at any time; output is deterministic.

set -eu

MEMORY_ROOT="$(cd "$(dirname "$0")/../agent-runtime/shared/memory" 2>/dev/null && pwd)"
MAPS_DIR="${MEMORY_ROOT}/50-maps"
TAG_INDEX="${MAPS_DIR}/TAG_INDEX.md"
ENTITY_INDEX="${MAPS_DIR}/ENTITY_INDEX.md"

TIMESTAMP="$(date -u '+%Y-%m-%dT%H:%M:%SZ')"

die() { printf 'ERROR: %s\n' "$*" >&2; exit 1; }

[ -d "${MEMORY_ROOT}" ] || die "Memory root not found: ${MEMORY_ROOT}"
[ -d "${MAPS_DIR}" ]    || die "Maps dir not found: ${MAPS_DIR}"

# ---------- TAG INDEX ----------

printf 'Refreshing TAG_INDEX...\n'

# Collect all unique tags from YAML front-matter lines matching "tags: [...]"
# and from inline "tags: [...]" in signal blocks.
TAGS_TMPFILE="$(mktemp /tmp/agent-deck-tags.XXXXXX)"

find "${MEMORY_ROOT}" -name '*.md' | sort | while IFS= read -r f; do
  # Match lines of the form: tags: [foo, bar, baz]
  grep -h 'tags:' "${f}" 2>/dev/null | \
    sed 's/tags:[ ]*\[//;s/\]//;s/"//g' | \
    tr ',' '\n' | \
    sed 's/^[ \t]*//;s/[ \t]*$//' | \
    grep -v '^$' | \
    while IFS= read -r tag; do
      # Normalise: lowercase, replace spaces with hyphens
      norm_tag="$(printf '%s' "${tag}" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')"
      rel_path="${f#${MEMORY_ROOT}/}"
      # Skip placeholder tags (e.g. <domain>, <tag>, ...)
      case "${norm_tag}" in
        \<*\>|\.\.\.|\.) continue ;;
      esac
      [ -z "${norm_tag}" ] && continue
      printf '%s\t%s\n' "${norm_tag}" "${rel_path}"
    done
done > "${TAGS_TMPFILE}"

# Build the index block
TAG_BLOCK="$(sort "${TAGS_TMPFILE}" | awk -F'\t' '
BEGIN { prev = "" }
{
  tag = $1; file = $2
  if (tag != prev) {
    if (prev != "") printf "\n"
    printf "### %s\n", tag
    prev = tag
  }
  printf "- %s\n", file
}
')"

rm -f "${TAGS_TMPFILE}"

# Splice into TAG_INDEX.md between sentinel comments
TMP_TAG="$(mktemp /tmp/agent-deck-tagidx.XXXXXX)"
awk -v block="${TAG_BLOCK}" -v ts="${TIMESTAMP}" '
/<!-- TAG_INDEX_START -->/ {
  print
  print "<!-- Last refresh: " ts " -->"
  print ""
  print block
  skip = 1
  next
}
/<!-- TAG_INDEX_END -->/ { skip = 0 }
skip { next }
{ print }
' "${TAG_INDEX}" > "${TMP_TAG}"
mv "${TMP_TAG}" "${TAG_INDEX}"
printf '  Done: %s\n' "${TAG_INDEX}"

# ---------- ENTITY INDEX ----------

printf 'Refreshing ENTITY_INDEX...\n'

ENTITIES_TMPFILE="$(mktemp /tmp/agent-deck-entities.XXXXXX)"

find "${MEMORY_ROOT}" -name '*.md' | sort | while IFS= read -r f; do
  rel_path="${f#${MEMORY_ROOT}/}"
  # Detect agent references
  grep -hoi '\b\(planner\|implementer\|reviewer\|pi\)\b' "${f}" 2>/dev/null | \
    tr '[:upper:]' '[:lower:]' | sort -u | \
    while IFS= read -r entity; do
      printf 'agent\t%s\t%s\n' "${entity}" "${rel_path}"
    done
  # Detect system/tool references (opencode, aider, pi adapter, agent-deck)
  grep -hoi '\b\(opencode\|aider\|agent-deck\|agent\.deck\|tmux\|mcp\)\b' "${f}" 2>/dev/null | \
    tr '[:upper:]' '[:lower:]' | sed 's/agent\.deck/agent-deck/g' | sort -u | \
    while IFS= read -r entity; do
      printf 'system\t%s\t%s\n' "${entity}" "${rel_path}"
    done
done > "${ENTITIES_TMPFILE}"

ENTITY_BLOCK="$(sort "${ENTITIES_TMPFILE}" | awk -F'\t' '
BEGIN { prev_cat = ""; prev_ent = "" }
{
  cat = $1; ent = $2; file = $3
  if (cat != prev_cat) {
    if (prev_cat != "") printf "\n"
    printf "## %s\n\n", toupper(cat)
    prev_cat = cat; prev_ent = ""
  }
  if (ent != prev_ent) {
    printf "\n### %s\n", ent
    prev_ent = ent
  }
  printf "- %s\n", file
}
')"

rm -f "${ENTITIES_TMPFILE}"

TMP_ENT="$(mktemp /tmp/agent-deck-entidx.XXXXXX)"
awk -v block="${ENTITY_BLOCK}" -v ts="${TIMESTAMP}" '
/<!-- ENTITY_INDEX_START -->/ {
  print
  print "<!-- Last refresh: " ts " -->"
  print ""
  print block
  skip = 1
  next
}
/<!-- ENTITY_INDEX_END -->/ { skip = 0 }
skip { next }
{ print }
' "${ENTITY_INDEX}" > "${TMP_ENT}"
mv "${TMP_ENT}" "${ENTITY_INDEX}"
printf '  Done: %s\n' "${ENTITY_INDEX}"

printf 'Index refresh complete.\n'
