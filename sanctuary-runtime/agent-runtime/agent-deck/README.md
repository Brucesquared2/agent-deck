# Agent Deck Adapter

Adapter configuration for running Agent Deck as part of the agent-runtime.

## Purpose

Agent Deck is the TUI session manager (Lane 1–5). In the agent-runtime context it acts as:

- The operator control plane for launching and monitoring other runtimes.
- A conductor host for routing tasks between OpenCode, Aider, and Pi.
- The primary interface for human-in-the-loop review steps.

## Setup

1. Build agent-deck: `go build ./cmd/agent-deck/` from the repository root.
2. Copy or review `config.toml` and adjust paths for your environment.
3. Run `bash ../scripts/sync-skills.sh agent-deck` to populate the skills directory.
4. Launch: `bash ../scripts/run-agent-deck.sh`

## Configuration

See `config.toml` for the agent-deck–specific settings used in agent-runtime.

## Conductors

Conductor definitions live in `conductors/`. See `conductors/README.md` for how to define
a conductor that routes work across runtimes.

## Memory Integration

| Direction | Paths |
|-----------|-------|
| Read  | `../shared/memory/10-ops/`, `../shared/memory/50-maps/INDEX.md` |
| Write | `../shared/memory/30-sessions/` (session logs) |
| Emit  | `../shared/memory/60-signals/` (user-action signals) |
