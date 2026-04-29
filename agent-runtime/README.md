# agent-runtime

Monorepo for the four-agent system (Planner / Implementer / Reviewer / PI) with adapters for OpenCode, Aider, and Pi — managed by the Agent Deck cockpit.

## Architecture

```
agent-runtime/
  shared/
    agents/       Canonical agent prompts (Planner, Implementer, Reviewer, PI)
    skills/       Reusable capability modules
    memory/       Shared memory system (see below)
  opencode/       OpenCode runtime adapter
  aider/          Aider runtime adapter
  pi/             Pi coding agent adapter
  agent-deck/     Agent Deck cockpit config
  scripts/        Operational scripts
```

## Quick Start

```sh
# 1. Install Agent Deck
curl -fsSL https://raw.githubusercontent.com/asheshgoplani/agent-deck/main/install.sh | bash

# 2. Start a new session
cd agent-runtime
sh scripts/memory-new-session.sh

# 3. Launch all runtimes via Agent Deck
sh scripts/launch-deck.sh

# 4. Or launch individual runtimes:
sh scripts/run-opencode.sh
sh scripts/run-aider.sh
sh scripts/run-pi.sh
```

## Memory System

The shared memory layer is at `shared/memory/`. It is the canonical brain for all agents.

See `shared/memory/README.md` for the full taxonomy and runbook.

### Eight Memory Zones

| Zone | Purpose |
|------|---------|
| `core/` | Stable identity, mission, principles |
| `ops/` | Runbooks, task queues, checklists |
| `projects/` | Per-project memory packs |
| `sessions/` | Per-session logs and summaries |
| `knowledge/` | Durable facts and references |
| `maps/` | Indexes, decision log, tag/entity maps |
| `signals/` | Signal-lang directives and events |
| `scratch/` | Ephemeral whiteboard (cleaned regularly) |

## Agents

| Agent | Prompt | Primary Zone |
|-------|--------|-------------|
| Planner | `shared/agents/planner.md` | `ops/`, `maps/` |
| Implementer | `shared/agents/implementer.md` | `sessions/`, `scratch/` |
| Reviewer | `shared/agents/reviewer.md` | `sessions/`, `knowledge/` |
| PI | `shared/agents/pi.md` | `knowledge/`, `maps/` |

## Signal-Lang

Short structured messages between agents. See `shared/memory/signals/README.md`.

## Scripts

| Script | Purpose |
|--------|---------|
| `scripts/memory-new-session.sh` | Create a new session folder with templates |
| `scripts/memory-summarize-session.sh` | Summarize a session and update INDEX.md |
| `scripts/memory-tag-refresh.sh` | Regenerate TAG_INDEX and ENTITY_INDEX |
| `scripts/sync-skills.sh` | Copy shared skills to all adapter runtimes |
| `scripts/lint-prompts.sh` | Lint agent prompt files |
| `scripts/run-opencode.sh` | Launch OpenCode |
| `scripts/run-aider.sh` | Launch Aider |
| `scripts/run-pi.sh` | Launch Pi |
| `scripts/launch-deck.sh` | Launch Agent Deck cockpit |
| `scripts/run-all.sh` | Launch everything via Agent Deck |

## Maintenance

See `shared/memory/ops/maintenance-checklist.md`.
