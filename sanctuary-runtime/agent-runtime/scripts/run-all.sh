#!/bin/sh
# run-all.sh — Sync skills and launch all runtimes in separate tmux windows.
#
# Requires tmux. Creates a new tmux session named "agent-runtime" with one
# window per adapter.
set -eu
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

SESSION="agent-runtime"

if ! command -v tmux > /dev/null 2>&1; then
  echo "[run-all] tmux is required. Install it and retry." >&2
  exit 1
fi

# Sync first
bash "$SCRIPT_DIR/sync-skills.sh" all

if tmux has-session -t "$SESSION" 2>/dev/null; then
  echo "[run-all] Session '$SESSION' already exists. Attaching..." >&2
  exec tmux attach-session -t "$SESSION"
fi

tmux new-session  -d -s "$SESSION" -n "opencode"   "bash $SCRIPT_DIR/run-opencode.sh;   bash"
tmux new-window   -t "$SESSION"    -n "aider"       "bash $SCRIPT_DIR/run-aider.sh;      bash"
tmux new-window   -t "$SESSION"    -n "pi"           "bash $SCRIPT_DIR/run-pi.sh;          bash"
tmux new-window   -t "$SESSION"    -n "agent-deck"  "bash $SCRIPT_DIR/run-agent-deck.sh; bash"

echo "[run-all] Session '$SESSION' created. Attaching..."
exec tmux attach-session -t "$SESSION"
