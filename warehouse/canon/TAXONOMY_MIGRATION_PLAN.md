---
status: candidate
version: "0.1"
authority: provisional
artifact: TAXONOMY_MIGRATION_PLAN
---

# TAXONOMY_MIGRATION_PLAN

> **Trigger:** This plan is activated when Bruce approves CD-002 in `CANONIZATION_DECISIONS.md`.
> Do not execute any step before that approval.

---

## Background

Two memory zone trees currently coexist in `agent-runtime/shared/memory/`:

**Numbered (canonical candidate)**

```
00-core/       policies.md, north-star.md
10-ops/        runbook-template.md
20-projects/   project-pack-template.md
30-sessions/   session-template.md
40-knowledge/  README.md
50-maps/       MEMORY_MAP.md, INDEX.md, TAG_INDEX.md, ENTITY_INDEX.md, DECISION_LOG.md
60-signals/    signal-lang.md, signal-schema.json, examples.md
90-archive/    README.md
```

**Legacy unnumbered (grandfathered)**

```
core/          IDENTITY.md, MISSION.md, PRINCIPLES.md
ops/           MEMORY_RUNBOOK.md, task-queue.md, maintenance-checklist.md
maps/          MEMORY_MAP.md, INDEX.md, TAG_INDEX.md, ENTITY_INDEX.md, DECISION_LOG.md
signals/       README.md, *.signal files
knowledge/     glossary.md, lessons-learned.md
projects/      sample-project/, agent-runtime-scaffold/
sessions/      2026-04-29-001/, _template/
scratch/       .gitkeep
```

The legacy tree has content that the numbered tree does not yet have (e.g. `IDENTITY.md`,
`MISSION.md`, `PRINCIPLES.md`). Migration must preserve that content.

---

## Migration phases

### Phase 0 — Prerequisite (before any migration work)

- [ ] Bruce approves CD-002
- [ ] ADR-004 recorded in `agent-runtime/shared/memory/50-maps/DECISION_LOG.md`

### Phase 1 — Content audit

For each legacy file, determine one of:

| Disposition | Meaning |
|-------------|---------|
| `PROMOTE` | Content is unique; promote to numbered zone |
| `MERGE` | Content partially overlaps numbered zone; merge and annotate |
| `REDIRECT` | Content fully covered; replace with redirect stub |
| `ARCHIVE` | Content is outdated; move to `90-archive/` |

| Legacy file | Proposed disposition | Target in numbered zone |
|-------------|---------------------|------------------------|
| `core/IDENTITY.md` | PROMOTE | `00-core/identity.md` |
| `core/MISSION.md` | PROMOTE | `00-core/mission.md` |
| `core/PRINCIPLES.md` | PROMOTE | `00-core/principles.md` |
| `ops/MEMORY_RUNBOOK.md` | PROMOTE | `10-ops/memory-runbook.md` |
| `ops/task-queue.md` | PROMOTE | `10-ops/task-queue.md` |
| `ops/maintenance-checklist.md` | PROMOTE | `10-ops/maintenance-checklist.md` |
| `maps/MEMORY_MAP.md` | REDIRECT → `50-maps/MEMORY_MAP.md` | — |
| `maps/INDEX.md` | REDIRECT → `50-maps/INDEX.md` | — |
| `maps/TAG_INDEX.md` | REDIRECT → `50-maps/TAG_INDEX.md` | — |
| `maps/ENTITY_INDEX.md` | REDIRECT → `50-maps/ENTITY_INDEX.md` | — |
| `maps/DECISION_LOG.md` | REDIRECT → `50-maps/DECISION_LOG.md` | — |
| `knowledge/glossary.md` | PROMOTE | `40-knowledge/glossary.md` |
| `knowledge/lessons-learned.md` | PROMOTE | `40-knowledge/lessons-learned.md` |
| `signals/*.signal` | ARCHIVE | `90-archive/signals-legacy/` |
| `signals/README.md` | REDIRECT | See `SIGNAL_LANG_MIGRATION_PLAN.md` |
| `projects/` | PROMOTE | `20-projects/` (merge with existing) |
| `sessions/` | PROMOTE | `30-sessions/` (merge with existing) |
| `scratch/` | RETAIN | Keep in place; already ephemeral |

### Phase 2 — Promote unique content

For each file marked `PROMOTE`:

1. Copy content to the numbered zone target.
2. Add front-matter block with `author`, `date`, `session`, `tags`.
3. Append lineage note: `Promoted from legacy/<original-path>`.

### Phase 3 — Add redirect stubs

For each file marked `REDIRECT`, replace content with:

```markdown
# <Filename> (Legacy Redirect)

> **This file is a redirect stub.**
> Canonical location: `<numbered-zone-path>`
> Redirected: <ISO-date> per CD-002 / ADR-004.

See [<numbered-zone-path>](../../<numbered-zone-path>).
```

### Phase 4 — Unify agent contracts

Each file in `agent-runtime/shared/agents/` currently contains two prompt templates
(one referencing legacy paths, one referencing numbered paths). After Phase 2:

1. Remove the legacy-path template block from each agent contract.
2. Verify the remaining template references only numbered zone paths.
3. Record the change in `30-sessions/` and emit a `memory-write` signal.

### Phase 5 — Validate and index

1. Run `agent-runtime/scripts/sync-skills.sh` to propagate changes to adapters.
2. Run `agent-runtime/scripts/memory-tag-refresh.sh` to regenerate indexes.
3. Verify `50-maps/INDEX.md` reflects all promoted files.

### Phase 6 — Archive legacy root (deferred)

After a 90-day observation period with no legacy path references in new agent output:

1. Move remaining legacy zone directories to `90-archive/legacy-taxonomy/`.
2. Record the archival in `DECISION_LOG.md`.
3. Update `WAREHOUSE_AUTHORITY_MAP.json` to remove `legacy-active` entries.

---

## Rollback plan

If any agent or human workflow breaks after Phase 3:

1. Redirect stubs are trivially reversible — restore original content.
2. Promoted content in numbered zones is additive — no deletion occurred.
3. The original legacy files are never deleted until Phase 6.

The migration is designed to be non-destructive through Phase 5.

---

## Success criteria

- All `PROMOTE` files have a counterpart in the numbered zone.
- All `REDIRECT` files contain only a redirect stub.
- All agent contracts reference only numbered zone paths.
- `50-maps/INDEX.md` is complete and accurate.
- No agent produces output that cites a legacy path as authoritative.
