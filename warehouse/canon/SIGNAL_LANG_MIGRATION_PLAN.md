---
status: candidate
version: "0.1"
authority: provisional
artifact: SIGNAL_LANG_MIGRATION_PLAN
---

# SIGNAL_LANG_MIGRATION_PLAN

> **Trigger:** This plan is activated when Bruce approves CD-001 in `CANONIZATION_DECISIONS.md`.
> Do not execute any step before that approval.

---

## Background

Two Signal-Lang formats currently coexist:

### Format A — YAML-in-Markdown v1.0 (canonical candidate)

- Defined in: `agent-runtime/shared/memory/60-signals/signal-lang.md`
- Schema: `agent-runtime/shared/memory/60-signals/signal-schema.json`
- ADR status: ADR-001 accepted (2026-04-29)
- Structure: fenced YAML block embedded in Markdown session files
- Top-level fields: `version`, `type`, `id`, `from`, `to`, `session`, `timestamp`, `payload`, `tags`
- Signal types: `task-request`, `handoff`, `constraint`, `memory-write`, `review-request`
- Normalization rules: field order canonical, UTC timestamps, sorted tags

### Format B — `.signal` front-matter (legacy)

- Defined in: `agent-runtime/shared/memory/signals/README.md`
- Schema: none
- ADR status: not covered by any ADR (created after ADR-001)
- Structure: standalone `.signal` files with YAML front-matter + Markdown body
- Top-level fields: `signal`, `id`, `from`, `to`, `date`, `session`, `priority`, `tags`
- Signal types: `HANDOFF`, `RESEARCH_REQUEST`, `TASK_BATCH` (uppercase)

### Incompatibility summary

| Dimension | Format A | Format B |
|-----------|----------|----------|
| `version` field | Required, `"1.0"` | Absent |
| Priority | `payload.priority: "high"` | `priority: P1` (flat) |
| Timestamp | `timestamp: 2026-04-29T04:51:00Z` | `date: 2026-04-29` |
| Type casing | `handoff` | `HANDOFF` |
| Payload | Nested object | Flat fields |
| Schema | JSON Schema Draft-07 | None |
| Storage | Embedded in session Markdown | Standalone `.signal` file |

The two formats are **not schema-compatible**. A parser cannot handle both without a dual-mode
dispatcher that encodes the unresolved decision.

---

## Migration phases

### Phase 0 — Prerequisite (before any migration work)

- [ ] Bruce approves CD-001
- [ ] ADR-005 recorded in `agent-runtime/shared/memory/50-maps/DECISION_LOG.md`

### Phase 1 — Freeze legacy format

1. Add the following notice to `agent-runtime/shared/memory/signals/README.md`:

```markdown
> **LEGACY — READ ONLY**
> This format is superseded by the YAML-in-Markdown signal format v1.0.
> See `60-signals/signal-lang.md` and `60-signals/signal-schema.json`.
> Decision: CD-001 / ADR-005.
> No new `.signal` files should be created.
```

2. No existing `.signal` files are deleted or modified at this stage.

### Phase 2 — Archive legacy signal files

Move all existing `.signal` files to `90-archive/signals-legacy/`:

```
agent-runtime/shared/memory/signals/HANDOFF_2026-04-29_001.signal
agent-runtime/shared/memory/signals/RESEARCH_REQUEST_2026-04-29_001.signal
agent-runtime/shared/memory/signals/TASK_BATCH_2026-04-29_001.signal
```

Add a README to `90-archive/signals-legacy/` explaining the archive:

```markdown
# Archived Legacy Signals

These `.signal` files used the pre-ADR-001 front-matter format.
They are retained for historical lineage but are not authoritative.
Archived: <date> per CD-001 / ADR-005.
```

### Phase 3 — Add equivalent v1.0 signals (where needed)

For any legacy signal whose event is still active or referenced, emit an equivalent
YAML-in-Markdown signal in the corresponding `30-sessions/` session file.

Mapping table:

| Legacy signal | Equivalent v1.0 type | Target session file |
|---------------|---------------------|---------------------|
| `HANDOFF_2026-04-29_001.signal` | `handoff` | `30-sessions/2026-04-29-001/log.md` |
| `RESEARCH_REQUEST_2026-04-29_001.signal` | `task-request` (with PI as `to`) | `30-sessions/2026-04-29-001/log.md` |
| `TASK_BATCH_2026-04-29_001.signal` | `task-request` (multiple acceptance criteria) | `30-sessions/2026-04-29-001/log.md` |

### Phase 4 — Update agent contracts

Each file in `agent-runtime/shared/agents/` contains signal emission instructions. Verify:

1. All emission instructions reference `60-signals/signal-lang.md` only.
2. No agent contract instructs creation of `.signal` files.
3. All example signals in agent contracts use Format A field names.

### Phase 5 — Update PI adapter

The `agent-runtime/pi/` adapter may reference the legacy signal format. Verify
`agent-runtime/pi/AGENTS.md` and any scripts in `agent-runtime/pi/scripts/` emit
only Format A signals.

---

## New signal authoring rules (post-migration)

After Phase 1 is complete, agents must follow these rules for all new signals:

1. **Never create a `.signal` file.** Signals are embedded in session Markdown files.
2. **Always use the YAML-in-Markdown fence** with the `signal` tag:
   ````
   ```yaml signal
   version: "1.0"
   ...
   ```
   ````
3. **Validate against `signal-schema.json`** before appending to a session file.
4. **Follow normalization rules** from `signal-lang.md` §4: field order, UTC timestamps, sorted tags.

---

## Rollback plan

If any agent or workflow breaks after Phase 1:

1. Remove the "LEGACY — READ ONLY" notice from `signals/README.md`.
2. Un-archive the `.signal` files (git revert is sufficient through Phase 2).
3. The session-embedded v1.0 signals added in Phase 3 are additive; no rollback required for them.

---

## Success criteria

- No new `.signal` files created after Phase 1.
- All existing `.signal` files archived in `90-archive/signals-legacy/`.
- `signals/README.md` contains only a legacy notice and pointer to `60-signals/`.
- All agent contracts reference only Format A.
- `WAREHOUSE_AUTHORITY_MAP.json` entry for `signal-lang-legacy` is updated to `status: archived`.
