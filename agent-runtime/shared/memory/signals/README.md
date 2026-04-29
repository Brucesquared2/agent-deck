# Signal-Lang

Signal-lang is a lightweight, human-writable, agent-parseable format for structured directives and events.

## Why Signal-Lang?

Agents need to:
- Announce what they're starting
- Declare what they've completed
- Hand off work to another agent
- Emit constraints or blockers
- Request research from the PI

Plain prose is too noisy. JSON is unfriendly to humans. Signal-lang is the middle ground.

## File Format

Signals are `.signal` files with a YAML front-matter block followed by an optional Markdown body.

```
---
signal: <SIGNAL_TYPE>
id: <unique-id>
from: <agent>        # planner | implementer | reviewer | pi
to: <agent>          # planner | implementer | reviewer | pi | all
date: YYYY-MM-DD
session: <session-id>
priority: P0 | P1 | P2 | P3
tags: [tag1, tag2]
---

# Optional Markdown body

Free-form detail, context, or instructions follow the front matter.
Any markdown is valid here.
```

## Signal Types

| Type | Meaning | From → To |
|------|---------|-----------|
| `TASK_BATCH` | Planner emitting a new batch of tasks | Planner → Implementer |
| `TASK_START` | Implementer starting a task | Implementer → All |
| `TASK_DONE` | Implementer completed a task | Implementer → Planner |
| `TASK_BLOCKED` | Task is blocked; needs resolution | Implementer → Planner |
| `REVIEW_REQUEST` | Requesting a review of output | Implementer → Reviewer |
| `REVIEW_PASS` | Review passed; LGTM | Reviewer → Planner |
| `REVIEW_FAIL` | Review failed; issues found | Reviewer → Implementer |
| `RESEARCH_REQUEST` | Asking PI to investigate something | Planner → PI |
| `RESEARCH_DONE` | PI completed research | PI → Planner |
| `HANDOFF` | Passing control to another agent | Any → Any |
| `CONSTRAINT` | Declaring a constraint or hard limit | Any → All |
| `INCIDENT` | Reporting an unexpected problem | Any → All |

## Naming Convention

```
signals/<SIGNAL_TYPE>_<YYYY-MM-DD>_<NNN>.signal
```

Examples:
- `signals/TASK_BATCH_2026-04-29_001.signal`
- `signals/REVIEW_PASS_2026-04-29_001.signal`
- `signals/RESEARCH_REQUEST_2026-04-29_001.signal`

## Parsing Rules (for agents)

1. Read the YAML front matter for structured fields.
2. Read the Markdown body for free-form context.
3. Act on `to: <your-agent-name>` or `to: all` signals.
4. Ignore signals where `to` does not match your agent name.
5. After acting, emit a response signal (e.g., `TASK_START` in response to `TASK_BATCH`).

## Human Writing Guide

You don't need to write all fields. Minimum valid signal:

```
---
signal: TASK_DONE
from: implementer
to: planner
date: 2026-04-29
---

Completed T-001: scaffolded agent-runtime directory structure.
```

## Example Signals

See:
- `TASK_BATCH_2026-04-29_001.signal` — Planner assigning the initial task batch
- `RESEARCH_REQUEST_2026-04-29_001.signal` — Planner asking PI to investigate
- `HANDOFF_2026-04-29_001.signal` — Implementer handing off to Reviewer
