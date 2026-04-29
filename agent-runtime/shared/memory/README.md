# Agent Memory System

This directory is the **canonical memory layer** for the Planner / Implementer / Reviewer / PI agent team.

## Taxonomy

```
memory/
  core/          Stable identity, principles, mission (rarely changed)
  ops/           Runbooks, checklists, task queues, incident notes
  projects/      Per-project memory packs
  sessions/      Per-session logs and summaries
  knowledge/     Facts, references, curated research notes
  maps/          Indexes, link maps, decision log, tag/entity indexes
  signals/       Signal-lang directives and events
  scratch/       Ephemeral notes (safe to delete after a session)
```

## How to Use

### Reading Memory

Start every session by reading:
1. `core/MISSION.md` — why we exist and what matters
2. `core/PRINCIPLES.md` — how we work
3. `maps/INDEX.md` — what is currently in memory
4. `sessions/<latest>/summary.md` — what happened last time

### Writing Memory

| What you're storing | Where |
|---------------------|-------|
| Stable fact or reference | `knowledge/` |
| Project-specific context | `projects/<project>/` |
| In-session progress note | `sessions/<session>/log.md` |
| Decision made | `maps/DECISION_LOG.md` |
| Task or directive | `ops/task-queue.md` |
| Short agent signal | `signals/` |
| Temporary scratch | `scratch/` |

### Hygiene

- Promote a `scratch/` note → `knowledge/` after it proves useful.
- Archive sessions older than 30 days → `sessions/archive/`.
- Run `scripts/memory-tag-refresh.sh` weekly.
- Run `scripts/memory-new-session.sh` at the start of every new working session.

## Runbook: How Agents Read/Write Memory

See `ops/MEMORY_RUNBOOK.md`.

## Backward Compatibility

If you find `scratchpad.md`, `decisions.md`, or `glossary.md` in this directory:
- `scratchpad.md` → content moved to `scratch/`; file now redirects
- `decisions.md` → content moved to `maps/DECISION_LOG.md`; file now redirects
- `glossary.md` → content moved to `knowledge/glossary.md`; file now redirects
