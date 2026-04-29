# Memory Policies

> **Scope:** All agents operating inside the `agent-runtime/` layer.
> **Authority:** Planner agent is the canonical writer for `00-core/`; all other agents are readers unless a policy explicitly grants write access.

---

## 1. Memory Write Rules

| Layer | Who may write | When |
|-------|--------------|------|
| `00-core/` | Planner only | After a design decision is ratified |
| `10-ops/` | Any agent | When executing a runbook or incident response |
| `20-projects/` | Planner + Implementer | On project start, scope change, or closure |
| `30-sessions/` | Any agent | At session start (header) and session end (summary) |
| `40-knowledge/` | Any agent | When a reusable fact or pattern is learned |
| `50-maps/` | Refresh script only | Via `scripts/refresh-indexes.sh` (do not hand-edit indexes) |
| `60-signals/` | Any agent | Signal blocks ONLY; spec files are read-only |
| `90-archive/` | Planner only | When retiring an entry from another layer |

### 1.1 Write format

Every write to a memory file MUST begin with a front-matter block:

```yaml
---
author: <agent-id>       # e.g. planner, implementer, reviewer, pi
date: <ISO-8601>         # e.g. 2026-04-29
session: <session-id>    # from 30-sessions/ filename
tags: [<tag>, ...]
---
```

### 1.2 Append-only rule

Existing entries in `00-core/`, `40-knowledge/`, and `50-maps/` are **append-only**.
To correct an entry, append a `## Correction` section with a new dated block; do not delete the original.

---

## 2. Memory Read Rules

- Any agent may read any layer at any time.
- Before starting a task, agents MUST read:
  1. `00-core/policies.md` (this file)
  2. `50-maps/MEMORY_MAP.md` (navigation)
  3. The relevant project pack in `20-projects/` (if one exists)
  4. The current session header in `30-sessions/` (if one exists)

---

## 3. Decision Recording

All decisions that affect architecture, tooling, or agent behaviour MUST be recorded in `50-maps/DECISION_LOG.md` using the ADR-lite format defined there.

---

## 4. Signal Emission Rules

When an agent completes a significant action or needs to hand off to another agent, it MUST emit a Signal block using the schema in `60-signals/signal-lang.md`.

Signals are appended to the current session file in `30-sessions/`.

---

## 5. Archiving

Entries older than 90 days with no active references should be moved to `90-archive/` by the Planner agent using the following naming convention:

```
90-archive/<original-layer>/<original-filename>
```

---

## 6. Index Freshness

Run `scripts/refresh-indexes.sh` after any batch of writes to keep `50-maps/TAG_INDEX.md` and `50-maps/ENTITY_INDEX.md` current.
The script is idempotent and safe to run at any time.
