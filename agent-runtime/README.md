# agent-runtime

> The shared "Agentic Operating System" layer for Agent Deck.

`agent-runtime/` is a monorepo sub-tree that provides a single canonical brain (agents, skills, and memory) that is adapted into three concrete runtimes: **OpenCode**, **Aider**, and **Pi**.

---

## Architecture

```
Agent Deck (cockpit)
  └── agent-runtime/
        ├── shared/          ← canonical agents, skills, memory (source of truth)
        │   ├── agents/      ← Planner, Implementer, Reviewer, PI prompts
        │   ├── skills/      ← shared skill definitions
        │   └── memory/      ← structured memory layer (see below)
        ├── opencode/        ← OpenCode adapter
        ├── aider/           ← Aider adapter
        └── pi/              ← Pi adapter
```

---

## Memory Layer

The memory layer under `shared/memory/` is a **deterministic, mappable, indexed** knowledge store for all agents.

### Taxonomy

| Layer | Folder | Purpose |
|-------|--------|---------|
| 00 · Core | `shared/memory/00-core/` | Principles, north star, policies |
| 10 · Ops | `shared/memory/10-ops/` | Runbooks, checklists, incident notes |
| 20 · Projects | `shared/memory/20-projects/` | Per-project packs |
| 30 · Sessions | `shared/memory/30-sessions/` | Per-session logs and summaries |
| 40 · Knowledge | `shared/memory/40-knowledge/` | Facts, references, learned patterns |
| 50 · Maps | `shared/memory/50-maps/` | Indexes and navigation maps |
| 60 · Signals | `shared/memory/60-signals/` | Signal-lang spec + examples |
| 90 · Archive | `shared/memory/90-archive/` | Retired entries |

### Navigation

Start with **`shared/memory/50-maps/MEMORY_MAP.md`** — it explains every layer and links to every key file.

### Memory write rules

Read **`shared/memory/00-core/policies.md`** before writing anything. The short version:

- **Planner** owns `00-core/`.
- **Any agent** may write to `10-ops/`, `30-sessions/`, `40-knowledge/`, `60-signals/`.
- **`50-maps/` indexes are auto-generated** — never hand-edit `TAG_INDEX.md` or `ENTITY_INDEX.md`.
- Entries in `40-knowledge/` and `00-core/` are **append-only**; archive instead of deleting.

---

## Signal-Lang

`signal-lang` is a lightweight YAML-in-Markdown interchange format for agent-to-agent communication.

- **Spec:** `shared/memory/60-signals/signal-lang.md`
- **Examples:** `shared/memory/60-signals/examples.md`
- **JSON Schema:** `shared/memory/60-signals/signal-schema.json`

### Signal types

| Type | Use case |
|------|----------|
| `task-request` | Planner delegates a task to another agent |
| `handoff` | Agent signals it has finished and another should continue |
| `constraint` | Hard limit on a task, project, or global scope |
| `memory-write` | Intent declaration before writing to shared memory |
| `review-request` | Implementer requests a Reviewer pass |

### Quick example

```yaml signal
version: "1.0"
type: "handoff"
id: "20260429-implementer-scaffold-done"
from: "implementer"
to: "reviewer"
session: "2026-04-29-bootstrap"
timestamp: "2026-04-29T05:30:00Z"
payload:
  summary: "Memory layer scaffold complete."
  next_action: "Review scripts for POSIX compatibility."
  artefacts:
    - "scripts/new-session.sh"
    - "scripts/refresh-indexes.sh"
tags: ["bootstrap", "handoff"]
```

---

## Agents

| Agent | Prompt | Role |
|-------|--------|------|
| Planner | `shared/agents/planner.md` | Task planning, ADR recording, team delegation |
| Implementer | `shared/agents/implementer.md` | Code and artefact creation |
| Reviewer | `shared/agents/reviewer.md` | Code review, risk assessment, VRAM gate |
| PI | `shared/agents/pi.md` | Research, knowledge curation |

---

## Scripts

| Script | Description |
|--------|-------------|
| `scripts/new-session.sh <slug>` | Creates a session file from the template in `30-sessions/` |
| `scripts/refresh-indexes.sh` | Regenerates `TAG_INDEX.md` and `ENTITY_INDEX.md` |
| `scripts/reviewer-vram-check.sh` | Optional VRAM gate (off by default; set `AGENT_DECK_REVIEWER_VRAM_CHECK=1`) |
| `scripts/run-all.sh` | Runs all maintenance scripts in order |

### Quick start

```sh
# Create a new session
scripts/new-session.sh my-project

# Refresh indexes after writing to memory
scripts/refresh-indexes.sh

# Enable VRAM gate for a Reviewer run
AGENT_DECK_REVIEWER_VRAM_CHECK=1 AGENT_DECK_REVIEWER_VRAM_MIN_GB=16 \
  scripts/reviewer-vram-check.sh
```

---

## Compatibility

| Runtime | Config |
|---------|--------|
| OpenCode | `agent-runtime/opencode/opencode.config.json` |
| Aider | `agent-runtime/aider/aider.conf.yml` |
| Pi | `agent-runtime/pi/AGENTS.md` |
| Agent Deck | `agent-runtime/agent-deck/config.toml` |

Shared agents and memory are designed to work with OpenCode Skills, Aider prompt injection, and Pi AGENTS.md conventions.

---

## Decision Log

Architectural decisions are recorded in `shared/memory/50-maps/DECISION_LOG.md` as ADR-lite entries. Key decisions:

- **ADR-001** — YAML-in-Markdown as the signal-lang format.
- **ADR-002** — Reviewer VRAM gate is opt-in (default off).
- **ADR-003** — Memory indexes are script-generated, not hand-edited.
