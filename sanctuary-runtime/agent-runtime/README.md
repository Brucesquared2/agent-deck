# Agent Runtime

A monorepo scaffold for running multiple AI coding agents (OpenCode, Aider, Pi, Agent Deck) against a shared memory and skills layer.

## Structure

```
agent-runtime/
├── README.md               ← this file
├── shared/                 ← runtime-agnostic shared layer
│   ├── agents/             ← agent identity contracts
│   ├── memory/             ← layered memory store
│   ├── skills/             ← reusable skill definitions
│   └── mcp/                ← MCP server configurations
├── opencode/               ← OpenCode adapter
├── aider/                  ← Aider adapter
├── pi/                     ← Pi (Principal Investigator) adapter
├── agent-deck/             ← Agent Deck adapter
└── scripts/                ← utility scripts
```

## Quick Start

```sh
# Sync shared skills into all adapter directories
bash scripts/sync-skills.sh

# Launch a specific runtime
bash scripts/run-opencode.sh
bash scripts/run-aider.sh
bash scripts/run-pi.sh
bash scripts/run-agent-deck.sh

# Launch all runtimes
bash scripts/run-all.sh
```

## Memory Layout

Memory lives in `shared/memory/` and is organized by tier:

| Tier | Path | Purpose |
|------|------|---------|
| 00 | `00-core/` | Identity, manifesto, global rules |
| 10 | `10-ops/` | Daily ops, priorities, blockers |
| 20 | `20-projects/` | Per-project context |
| 30 | `30-sessions/` | Session logs |
| 40 | `40-knowledge/` | Research, references |
| 50 | `50-maps/` | Indexes, entity map, decision log |
| 60 | `60-signals/` | Signal-Lang events and schemas |
| 90 | `90-archive/` | Historical records |

See `shared/memory/README.md` for the full memory protocol.

## Skills

Skills are defined in `shared/skills/` and synced into each adapter via `scripts/sync-skills.sh`.

See `shared/skills/README.md` for the skill format and category list.

## MCP Servers

Server configs live in `shared/mcp/`. See `shared/mcp/README.md` for registration details.
