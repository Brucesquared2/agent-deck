---
id: memory/write-session-log
description: Append a structured entry to the current session log
inputs:
  - session_id: string (e.g. "2026-04-29-001")
  - summary: string (what was done)
  - facts: list of strings (new facts discovered)
  - next: string (next recommended action)
outputs:
  - updated: bool
---

# Skill: write-session-log

## Prompt

Append the following entry to `memory/sessions/{session_id}/log.md`:

```
## {timestamp}

### Summary
{summary}

### New Facts
{facts as bullet list}

### Next Action
{next}
```

Create the file if it does not exist, using the template at `memory/sessions/_template/log.md`.

## Example

```
@skill memory/write-session-log
session_id: 2026-04-29-001
summary: Implemented OAuth2 token refresh flow
facts:
  - Token TTL is 3600s (from API docs)
  - Refresh endpoint is POST /auth/refresh
next: Write tests for the refresh flow
```
