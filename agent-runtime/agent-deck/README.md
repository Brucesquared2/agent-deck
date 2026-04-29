# Agent Deck Config

This directory contains the Agent Deck cockpit configuration for the agent-runtime
system. Agent Deck is the mission-control layer that sits above all runtime adapters.

## Files

| File | Purpose |
|------|---------|
| `README.md` | This file |
| `config.toml` | Agent Deck configuration |
| `worktree-setup.sh` | Sets up git worktrees so agents can work in parallel |
| `conductors/README.md` | Documentation for persistent conductor agents |

## Setup

1. Install Agent Deck:
   ```sh
   curl -fsSL https://raw.githubusercontent.com/asheshgoplani/agent-deck/main/install.sh | bash
   ```
2. Edit `config.toml` to match your environment.
3. (Optional) Run `worktree-setup.sh` to create per-agent git worktrees:
   ```sh
   bash worktree-setup.sh
   ```
4. Launch Agent Deck:
   ```sh
   bash ../scripts/launch-deck.sh
   # or simply:
   agent-deck
   ```

## Adding sessions via Agent Deck CLI

```sh
cd agent-runtime

# Add each runtime as an Agent Deck session
agent-deck add opencode -c opencode
agent-deck add aider    -c aider
agent-deck add pi       -c "sh pi/scripts/pi-run.sh"
```

## Conductors

See `conductors/README.md` for how to set up persistent supervisor agents.

## Notes

- `config.toml` is a placeholder. Adapt it to the Agent Deck config schema for your
  installed version (run `agent-deck config --help` for options).
- The `.env` file at `agent-runtime/` root (if present) is loaded automatically by
  the launch script; it is never committed.
