#!/bin/sh
# Set up git worktrees for Agent Deck sessions
# Each runtime gets its own worktree so agents don't conflict
# Usage: ./worktree-setup.sh <repo-path> <base-branch>

set -eu

REPO="${1:?Usage: $0 <repo-path> <base-branch>}"
BASE="${2:-main}"
WORKTREE_ROOT="$(cd "$(dirname "$0")" && pwd)/worktrees"

mkdir -p "$WORKTREE_ROOT"

for agent in opencode aider pi; do
  branch="agent-deck/$agent"
  worktree="$WORKTREE_ROOT/$agent"

  if [ -d "$worktree" ]; then
    echo "Worktree already exists: $worktree"
    continue
  fi

  echo "Creating worktree for $agent at $worktree ..."
  git -C "$REPO" worktree add "$worktree" -b "$branch" "$BASE"
  echo "Done: $worktree"
done

echo ""
echo "Worktrees created in: $WORKTREE_ROOT"
echo "Start Agent Deck sessions with: agent-deck"
