# Human Index

> A hand-curated index of all notable memory files.
> Auto-generated indexes are in TAG_INDEX.md and ENTITY_INDEX.md.
> Add an entry here when you create a new file that others should know about.

---

## 00 · Core

| File | Description |
|------|-------------|
| `00-core/north-star.md` | Guiding principles and system architecture |
| `00-core/policies.md` | Memory write/read and signal emission rules |

## 10 · Ops

| File | Description |
|------|-------------|
| `10-ops/runbook-template.md` | Blank runbook template |

## 20 · Projects

| File | Description |
|------|-------------|
| `20-projects/project-pack-template.md` | Blank project pack template |

## 30 · Sessions

| File | Description |
|------|-------------|
| `30-sessions/session-template.md` | Blank session log template |

## 40 · Knowledge

| File | Description |
|------|-------------|
| `40-knowledge/README.md` | Knowledge index format and instructions |

## 50 · Maps

| File | Description |
|------|-------------|
| `50-maps/MEMORY_MAP.md` | Top-level navigation guide |
| `50-maps/INDEX.md` | This file |
| `50-maps/TAG_INDEX.md` | Tag → file mapping (auto-generated) |
| `50-maps/ENTITY_INDEX.md` | Entity → file mapping (auto-generated) |
| `50-maps/DECISION_LOG.md` | ADR-lite decision log |

## 60 · Signals

| File | Description |
|------|-------------|
| `60-signals/signal-lang.md` | Signal-lang specification |
| `60-signals/examples.md` | Signal-lang worked examples |
| `60-signals/signal-schema.json` | JSON Schema for signal blocks |

## 90 · Archive

| File | Description |
|------|-------------|
| `90-archive/README.md` | Archive structure and rules |

## Agent Prompts

| File | Description |
|------|-------------|
| `shared/agents/planner.md` | Planner agent system prompt |
| `shared/agents/implementer.md` | Implementer agent system prompt |
| `shared/agents/reviewer.md` | Reviewer agent system prompt |
| `shared/agents/pi.md` | PI (Principal Investigator) agent system prompt |

## Scripts

| Script | Description |
|--------|-------------|
| `scripts/new-session.sh` | Creates a new session file from the template |
| `scripts/refresh-indexes.sh` | Regenerates TAG_INDEX and ENTITY_INDEX |
| `scripts/reviewer-vram-check.sh` | Optional VRAM gate for Reviewer workflows |
| `scripts/run-all.sh` | Entry point: runs all verification scripts |
