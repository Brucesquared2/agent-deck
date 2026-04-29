# North Star

> This document defines the guiding principles for the `agent-runtime/` system.
> It is written once and amended only via a ratified decision in `DECISION_LOG.md`.

---

## Purpose

Build a professional "Agentic Operating System" that is:

- **Deterministic** — the same inputs always produce the same agent actions.
- **Mappable** — every piece of knowledge has a canonical location.
- **Indexed** — agents and humans can navigate the memory layer without guessing.

---

## Core Values

| Value | Meaning |
|-------|---------|
| Minimal surface | Prefer fewer, well-understood primitives over many specialised ones. |
| Additive only | Never delete shared state; archive instead. |
| Cross-runtime | All artefacts work in OpenCode, Aider, and Pi adapters. |
| Human-readable | Prefer Markdown + YAML; avoid binary formats in memory. |
| Scriptable | Every maintenance task can be run by a shell script with no external deps. |

---

## System Components

```
Agent Deck (cockpit)
  └── agent-runtime/ (this layer)
        ├── shared/          canonical agents, skills, memory
        ├── opencode/        OpenCode adapter
        ├── aider/           Aider adapter
        └── pi/              Pi adapter
```

---

## Four-Agent Team

| Agent | Role |
|-------|------|
| Planner | Decides tasks, scope, and sequencing; owns `00-core/` |
| Implementer | Writes code and artefacts; owns session entries in `30-sessions/` |
| Reviewer | Reviews, validates, and documents risks; runs optional VRAM gate |
| PI | Principal Investigator; owns `40-knowledge/` accumulation |
