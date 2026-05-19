# Memory Runbook

How each agent reads and writes memory during normal operations.

---

## Session Start (all agents)

1. Run `scripts/memory-new-session.sh` to create `sessions/<date>-<seq>/`
2. Read `maps/INDEX.md` — get oriented
3. Read `sessions/<previous>/summary.md` — pick up where we left off
4. Read `core/MISSION.md` and `core/PRINCIPLES.md` — re-anchor

---

## Planner Workflow

### Creating Tasks
1. Read `projects/<project>/README.md` for context
2. Write ordered task list to `ops/task-queue.md`
3. Emit a `TASK_BATCH` signal: `signals/TASK_BATCH_<date>.signal`
4. Update `maps/INDEX.md` with new tasks

### Recording Decisions
1. Add entry to `maps/DECISION_LOG.md` (use template below)
2. If decision affects a project, update `projects/<project>/decisions.md`

**Decision template:**
```
## DECISION-<NNN>: <title>
Date: YYYY-MM-DD
Made by: Planner
Context: <why this decision was needed>
Decision: <what was decided>
Alternatives: <what was rejected and why>
Impact: <what this changes>
```

---

## Implementer Workflow

### Starting a Task
1. Pick top item from `ops/task-queue.md`
2. Emit `TASK_START` signal
3. Write intent to `sessions/<session>/log.md`

### During Work
- Append progress notes to `sessions/<session>/log.md`
- File new facts in `knowledge/` immediately (don't wait)
- Use `scratch/` for in-flight calculations

### Completing a Task
1. Update `ops/task-queue.md` (mark done)
2. Emit `TASK_DONE` signal
3. Write final log entry

---

## Reviewer Workflow

### Reviewing Output
1. Read `sessions/<session>/log.md` for context
2. Read `core/PRINCIPLES.md` to anchor review
3. Write findings to `sessions/<session>/review.md`
4. If LGTM: emit `REVIEW_PASS` signal
5. If issues: emit `REVIEW_FAIL` signal with details

### Recording Lessons
- Write reusable lesson to `knowledge/lessons-learned.md`

---

## PI Workflow

### Research Request
1. Receive research signal or Planner task
2. Emit `RESEARCH_START` signal
3. Investigate; write findings to `knowledge/<topic>.md`
4. Update `maps/ENTITY_INDEX.md` if new entities found
5. Emit `RESEARCH_DONE` signal

---

## Session End (all agents)

1. Run `scripts/memory-summarize-session.sh` (interactive; you fill the summary)
2. Archive any `scratch/` items worth keeping → `knowledge/`
3. Delete remaining `scratch/` items
4. Update `maps/INDEX.md`
