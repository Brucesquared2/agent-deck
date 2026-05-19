#!/bin/sh
# Basic lint check for agent prompt files
# Verifies each prompt has required sections
# Usage: ./lint-prompts.sh

set -eu

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
AGENTS_DIR="$ROOT/shared/agents"

ERRORS=0

for f in "$AGENTS_DIR"/*.md; do
  name="$(basename "$f")"

  if ! grep -q "^## Role" "$f"; then
    echo "FAIL [$name]: missing '## Role' section" >&2
    ERRORS=$((ERRORS + 1))
  fi

  if ! grep -q "^## Responsibilities" "$f"; then
    echo "FAIL [$name]: missing '## Responsibilities' section" >&2
    ERRORS=$((ERRORS + 1))
  fi

  if ! grep -q "^## Memory Access Pattern" "$f"; then
    echo "FAIL [$name]: missing '## Memory Access Pattern' section" >&2
    ERRORS=$((ERRORS + 1))
  fi

  if [ "$ERRORS" -eq 0 ]; then
    echo "OK  [$name]"
  fi
done

if [ "$ERRORS" -gt 0 ]; then
  echo ""
  echo "$ERRORS lint error(s) found." >&2
  exit 1
fi

echo "All prompts passed lint."
