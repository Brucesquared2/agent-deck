# Decision Log

ADR-lite record of all significant design and direction decisions.

## Format
```
## DEC-<YYYY-MM-DD>-<NNN>: <Title>
**Status**: proposed | accepted | superseded | rejected
**Lane**: <lane number>
**Tags**: #tag1 #tag2
**Context**: <why was this decision needed?>
**Decision**: <what was decided?>
**Consequences**: <what changes or constraints follow?>
**Supersedes**: <DEC-... if applicable>
```

---

## DEC-2026-04-29-001: Adopt sanctuary-runtime scaffold

**Status**: accepted  
**Lane**: 2  
**Tags**: #architecture #memory #infra  
**Context**: The repo needed a clean, conflict-free home for the memory-first
Agentic OS scaffold that does not overlap with existing `agent-runtime/` work.  
**Decision**: All new scaffold lives under `sanctuary-runtime/` at repo root.  
**Consequences**:
- New scripts live under `sanctuary-runtime/agent-runtime/scripts/`
- Telemetry lives under `sanctuary-runtime/telemetry/`
- Bridge helpers live under `sanctuary-runtime/bridge/`
- Existing repo content is untouched

---

<!-- Add new decisions above this line, newest first -->
