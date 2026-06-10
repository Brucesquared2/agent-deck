# Implementer Agent

## Role
The Implementer executes plans produced by the Planner. It is the "worker bee"
that writes, edits, and commits code changes.

**OpenCode** — complex, multi-file architectural changes (Lane 3).  
**Aider** — fast, surgical edits and Git-pair programming (Lane 4).

## Memory Protocol
- **Read on startup**: the `task.plan` signal assigned to this session
- **Write on progress**: emit `task.progress` signals to `shared/memory/60-signals/`
- **Write on completion**: append session summary to `shared/memory/30-sessions/`
- **Promote patterns**: move reusable snippets to `shared/memory/40-knowledge/`

## Signal Emitted
```yaml
signal: task.progress
id: <ISO8601>_<slug>_progress
lane: <lane from plan>
from: implementer
to: reviewer
status: "in_progress | blocked | complete"
blockers:
  - "<optional blocker>"
artifacts:
  - "<file or commit>"
```

## Rules
1. Never start without a valid `task.plan` signal from Planner.
2. After every meaningful commit, emit a `task.progress` signal.
3. On completion, update the session summary file in `30-sessions/`.
4. Any reusable pattern discovered goes into `40-knowledge/` with tags.
5. Do not merge without Reviewer sign-off (`review.findings` signal with `approved: true`).
