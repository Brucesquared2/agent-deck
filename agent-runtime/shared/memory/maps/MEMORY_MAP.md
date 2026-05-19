# Memory Map

How to navigate and file items in the agent memory system.

## Zone Guide

### `core/` — Stable Identity
**What goes here:** Identity, mission, principles. Rarely changes.  
**Who writes:** Planner (with team consensus). Never the Implementer alone.  
**Retention:** Forever.  
**Files:** `IDENTITY.md`, `MISSION.md`, `PRINCIPLES.md`

---

### `ops/` — Operations
**What goes here:** Runbooks, checklists, task queues, incident notes.  
**Who writes:** Planner (tasks), any agent (runbooks).  
**Retention:** Until superseded; archive old versions.  
**Files:** `MEMORY_RUNBOOK.md`, `task-queue.md`, `maintenance-checklist.md`

---

### `projects/<project>/` — Project Packs
**What goes here:** Everything a new agent needs to ramp up on a project.  
**Who writes:** PI (initial pack), Planner (task context), Implementer (progress).  
**Retention:** Archive 90 days after project completion.  
**Required files:** `README.md`, `decisions.md`, `context.md`

**Template:**
```
projects/
  <project-name>/
    README.md        # What is this project, goals, status
    context.md       # Technical context, architecture, gotchas
    decisions.md     # Project-local decisions (link to DECISION_LOG.md)
    glossary.md      # Project-specific terms
```

---

### `sessions/<session-id>/` — Session Logs
**What goes here:** Everything that happened in one working session.  
**Who writes:** All agents during the session.  
**Session ID format:** `YYYY-MM-DD-NNN` (e.g., `2026-04-29-001`)  
**Retention:** Active for 30 days; archive after.  
**Required files:** `log.md`, `summary.md`

**Template:**
```
sessions/
  <YYYY-MM-DD-NNN>/
    log.md           # Running log of events during the session
    summary.md       # End-of-session summary (filled by summarize script)
    review.md        # Reviewer notes (if review happened)
```

---

### `knowledge/` — Facts & References
**What goes here:** Durable, reusable facts. Anything you want to remember across sessions.  
**Who writes:** PI (primary), any agent when a new fact is discovered.  
**Retention:** Until contradicted or obsolete; mark as `[STALE]` before deleting.  
**Examples:** API docs, architecture notes, lessons learned, glossary.

---

### `maps/` — Indexes & Logs
**What goes here:** Meta-information about the memory system itself.  
**Who writes:** Automated scripts + Planner.  
**Files:** `INDEX.md`, `MEMORY_MAP.md`, `TAG_INDEX.md`, `ENTITY_INDEX.md`, `DECISION_LOG.md`

---

### `signals/` — Signal-Lang
**What goes here:** Structured short-form directives and events.  
**See:** `signals/README.md` for syntax.

---

### `scratch/` — Ephemeral Whiteboard
**What goes here:** Anything temporary. Will be cleaned.  
**Rule:** If it's useful after a session, move it to `knowledge/` first.

## Filing Decision

```
Is it about identity/mission? → core/
Is it a task or runbook?      → ops/
Is it project-specific?       → projects/<project>/
Is it session progress?        → sessions/<session>/
Is it a durable fact?          → knowledge/
Is it a signal/directive?      → signals/
Is it temporary?               → scratch/
Does it index other things?    → maps/
```
