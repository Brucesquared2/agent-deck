# Entity Index

Canonical registry of people, tools, repositories, and components referenced
across the memory system.

## Format
Each entry: `<Entity Name>` — `<type>` — description — links

## Agents

| Entity | Type | Description | Links |
|--------|------|-------------|-------|
| Planner | agent | Analyzes requests, emits task.plan signals | `shared/agents/planner.md` |
| Implementer | agent | Executes plans (OpenCode/Aider) | `shared/agents/implementer.md` |
| Reviewer | agent | Quality gate, VRAM check | `shared/agents/reviewer.md` |
| PI | agent | Principal Investigator, research | `shared/agents/pi.md` |

## Tools / Runtimes

| Entity | Type | Description | Links |
|--------|------|-------------|-------|
| OpenCode | runtime | Multi-file architectural agent | `agent-runtime/opencode/` |
| Aider | runtime | Fast surgical code editor | `agent-runtime/aider/` |
| Pi | runtime | Research / PI agent | `agent-runtime/pi/` |
| Agent Deck | cockpit | TUI mission control | repo root |
| DCGM | telemetry | NVIDIA Data Center GPU Manager | `sanctuary-runtime/telemetry/` |
| Prometheus | telemetry | Metrics scraping and alerting | `sanctuary-runtime/telemetry/` |

## Repositories

| Entity | Type | URL | Notes |
|--------|------|-----|-------|
| agent-deck | repo | https://github.com/Brucesquared2/agent-deck | This repo |

## Adding an Entity
1. Determine type: `agent` \| `tool` \| `repo` \| `component` \| `person` \| `service`
2. Add a row to the appropriate table above.
3. Run `scripts/refresh-indexes.sh` after adding.

## Last Refreshed
<!-- Updated automatically by refresh-indexes.sh -->
_Not yet refreshed._
