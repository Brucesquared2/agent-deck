---
status: candidate
version: 0.1
authority: provisional
artifact: TAXONOMY_MIGRATION_PLAN
---

# TAXONOMY_MIGRATION_PLAN

## Purpose

This document defines the migration path from the legacy unnumbered taxonomy to the
canonical numbered taxonomy. It is a companion artifact to CD-002 in
`CANONIZATION_DECISIONS.md`.

## Canonical target

The numbered taxonomy defined in `50-maps/MEMORY_MAP.md`:

| Prefix | Domain |
|--------|--------|
| `00-core` | Policies, governance, foundational rules |
| `10-ops` | Operational state and runbooks |
| `20-projects` | Project-level knowledge |
| `30-sessions` | Session logs and state |
| `40-knowledge` | General knowledge base |
| `50-maps` | Memory maps and taxonomies |
| `60-signals` | Signal-Lang spec and schemas |
| `90-archive` | Archived and deprecated material |

## Migration phases

### Phase 0 — Freeze (pre-approval)

- No new documents may be created under the legacy unnumbered tree.
- Legacy documents remain readable and referenceable.
- All new documents must use numbered prefixes.

**Status:** pending Bruce approval of CD-002.

### Phase 1 — Mapping (post-approval)

1. Produce a complete inventory of all legacy unnumbered documents.
2. For each legacy document, record the target numbered path.
3. Publish the mapping table in this file (§ Legacy mapping table below).
4. Mark each legacy document with a `deprecated: true` front-matter flag and a
   `canonical: <numbered-path>` pointer.

**Completion criterion:** Every legacy document has an entry in the mapping table.

### Phase 2 — Redirect

1. For each legacy document that is actively referenced, add a redirect note at the
   top of the file: `> This document has moved to <numbered-path>.`
2. Update all internal cross-references to use numbered paths.

**Completion criterion:** `grep -r '<legacy-path>'` returns zero active references
in non-archived locations.

### Phase 3 — Archive

1. Move all legacy unnumbered documents to `90-archive/legacy-taxonomy/`.
2. Update `WAREHOUSE_AUTHORITY_MAP.json` to remove legacy paths.
3. Remove legacy paths from any authority or governance documents.

**Completion criterion:** No legacy-unnumbered paths appear in authority artifacts.

### Phase 4 — Enforcement

1. Add a pre-commit or CI check that rejects new documents not under a numbered prefix.
2. Update `WAREHOUSE_SPECIFICATION.md` to record numbered taxonomy as `canonical`
   (upgrade from `candidate`).
3. Close this plan with `status: complete`.

**Completion criterion:** CD-002 status updated to `accepted`.

## Grandfathering policy

Legacy documents that cannot be migrated without breaking external references may be
grandfathered. Grandfathered documents:

- Keep their original path.
- Must carry `status: grandfathered` front-matter.
- Must carry a `canonical: <numbered-path>` pointer to a numbered-tree canonical.
- Are not counted as active authority.

Grandfathering requires explicit Bruce approval and a record in `CANONIZATION_DECISIONS.md`.

## Legacy mapping table

> To be populated during Phase 1.

| Legacy path | Numbered canonical target | Disposition |
|-------------|--------------------------|-------------|
| (TBD)       | (TBD)                    | migrate / grandfather / archive |
