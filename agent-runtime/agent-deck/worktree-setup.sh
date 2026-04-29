#!/bin/sh
# worktree-setup.sh — create git worktrees for each agent session
# Allows Planner, Implementer, Reviewer, and PI to work in parallel on separate
# branches without interfering with each other.
#
# Usage: sh agent-deck/worktree-setup.sh [base-branch]
# Default base branch: main
set -eu

BASE_BRANCH="${1:-main}"
REPO_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
WORKTREE_DIR="$REPO_ROOT/.worktrees"

echo "==> Setting up agent worktrees under $WORKTREE_DIR"
echo "    Base branch: $BASE_BRANCH"

# Ensure the worktree directory exists
mkdir -p "$WORKTREE_DIR"

# List of agent worktrees to create
AGENTS="planner implementer reviewer pi"

for AGENT in $AGENTS; do
  BRANCH="agent/$AGENT"
  TARGET="$WORKTREE_DIR/$AGENT"

  if [ -d "$TARGET" ]; then
    echo "  [skip] worktree '$AGENT' already exists at $TARGET"
    continue
  fi

  # Create the branch if it doesn't exist
  cd "$REPO_ROOT"
  if ! git show-ref --verify --quiet "refs/heads/$BRANCH"; then
    echo "  [create] branch $BRANCH from $BASE_BRANCH"
    git branch "$BRANCH" "$BASE_BRANCH"
  fi

  echo "  [create] worktree $TARGET on branch $BRANCH"
  git worktree add "$TARGET" "$BRANCH"
done

echo ""
echo "==> Worktrees created:"
git worktree list
echo ""
echo "Tip: each agent should cd into its worktree before making changes."
echo "  Planner:     $WORKTREE_DIR/planner"
echo "  Implementer: $WORKTREE_DIR/implementer"
echo "  Reviewer:    $WORKTREE_DIR/reviewer"
echo "  PI:          $WORKTREE_DIR/pi"
