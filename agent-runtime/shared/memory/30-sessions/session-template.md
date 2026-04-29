# Session Template

> **Usage:** Run `scripts/new-session.sh <project-slug>` to create a populated copy of this file.
> Fill in the Header block immediately; complete the Summary block at the end.

---

```yaml
---
author: <agent-id>
date: <YYYY-MM-DD>
session: <session-id>
project: <project-slug>
tags: [session, <domain>]
agents: [planner, implementer, reviewer, pi]
---
```

## Header (fill at start)

| Field | Value |
|-------|-------|
| **Session ID** | |
| **Date / time** | |
| **Primary agent** | |
| **Project** | |
| **Goal this session** | |

---

## Context Loaded

_What memory was read at session start._

- `00-core/policies.md`
- `50-maps/MEMORY_MAP.md`
- `20-projects/<slug>/project-pack.md` (if applicable)

---

## Work Log

_Append entries chronologically as the session progresses._

### <HH:MM> — <Action taken>

- **Agent:** 
- **Result:** 
- **Files changed:** 

---

## Signals Emitted

_Copy signal blocks emitted during this session here for the record._

_(Paste signal YAML blocks below.)_

---

## Decisions Made

_Link to any ADR entries added to `50-maps/DECISION_LOG.md` during this session._

| ADR ID | Summary |
|--------|---------|
| | |

---

## Summary (fill at end)

**Accomplished:**
- 

**Left open:**
- 

**Knowledge gained** (add to `40-knowledge/` if reusable):
- 

**Next session should start with:**
- 
