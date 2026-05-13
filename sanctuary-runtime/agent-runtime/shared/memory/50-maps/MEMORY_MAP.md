# Memory Map

Rules for what belongs where and how items flow through the system.

## The Lifecycle

```
Capture (session raw log)
    ↓
Summarize (session summary)
    ↓
Promote (40-knowledge / 20-projects)
    ↓
Index (50-maps: TAG_INDEX, ENTITY_INDEX)
    ↓
Archive (90-archive)
```

## Placement Rules

### 00-core
- Operating principles that change less than once a quarter
- System-wide security/privacy/conduct policies
- Agent role charters

### 10-ops
- Step-by-step runbooks (must be executable, POSIX-safe)
- Incident post-mortems (INC-YYYY-MM-DD format)
- Scheduled maintenance records

### 20-projects
- One subfolder per repository: `<org>_<repo>/`
- Requirements, architecture, per-project decisions
- Links back to relevant sessions in `30-sessions/`

### 30-sessions
- Raw logs: write-once, never edited
- Summaries: concise, must list promoted items
- Older than 90 days with no references → candidate for `90-archive/`

### 40-knowledge
- Facts and patterns worth reusing across sessions
- Must carry at least one canonical tag
- Updated in place when the fact changes

### 50-maps
- Index and map files only — no raw content
- Updated by scripts or agents after every session

### 60-signals
- Signal-Lang spec and schema
- Per-session signal log files (one per session or agent run)

### 90-archive
- Immutable; never edit after archival
- Use original path prefix for folder naming

## What Does NOT Belong in Memory
- Binary files or large media (use external storage, note the path here)
- Credentials or secrets (use a secrets manager)
- Duplicate content (deduplicate before writing)
