---
status: candidate
version: 0.1
authority: provisional
artifact: SIGNAL_LANG_MIGRATION_PLAN
---

# SIGNAL_LANG_MIGRATION_PLAN

## Purpose

This document defines the migration path from the legacy `.signal` front-matter
format to the canonical versioned Signal-Lang format. It is a companion artifact
to CD-001 in `CANONIZATION_DECISIONS.md`.

## Canonical target

The versioned Signal-Lang spec and JSON schema at:

- `60-signals/signal-lang.md` — normative specification
- `60-signals/signal-schema.json` — machine-enforced payload schema

Key properties of the canonical format:

- deterministic parsing
- explicit field declarations (no reflection or dynamic field discovery)
- schema-validated payloads
- version field required

## Legacy format

The legacy `.signal` front-matter format:

- undocumented field set
- reflection-based discovery in some parsers
- no schema validation
- version field not required

## Migration phases

### Phase 0 — Freeze (pre-approval)

- No new `.signal` files may be created using the legacy format.
- All new signal artifacts must conform to `60-signals/signal-schema.json`.
- Legacy `.signal` files remain readable.

**Status:** pending Bruce approval of CD-001.

### Phase 1 — Inventory (post-approval)

1. Produce a complete inventory of all files using the legacy `.signal` format.
2. For each file, record:
   - Path
   - Whether it can be automatically migrated or requires manual review
   - Any fields present in legacy format that have no canonical equivalent
3. Publish the inventory in § Legacy inventory table below.

**Completion criterion:** Every legacy `.signal` file has an inventory entry.

### Phase 2 — Schema gap analysis

1. Compare the field sets present in legacy files against `signal-schema.json`.
2. For any field that has no canonical equivalent, raise a proposed schema extension
   in `60-signals/signal-lang.md` for Bruce review.
3. Do not migrate files that depend on schema gaps until the gap is resolved.

**Completion criterion:** All legacy fields are either mapped or formally excluded.

### Phase 3 — Automated migration

1. Write a migration script (or use an existing tool) that transforms legacy `.signal`
   front-matter to the canonical schema format.
2. Run the script on all files marked `auto-migrate` in the inventory.
3. Validate each migrated file against `signal-schema.json`.
4. Commit migrated files with a lineage record noting the migration.

**Completion criterion:** All `auto-migrate` files pass schema validation.

### Phase 4 — Manual migration

1. Manually migrate files marked `manual-review` in the inventory.
2. Validate each against `signal-schema.json`.
3. Commit with lineage records.

**Completion criterion:** All inventory files migrated.

### Phase 5 — Enforcement

1. Add a pre-commit or CI check that rejects new files using the legacy format.
2. Mark legacy `.signal` format as `deprecated` in `WAREHOUSE_AUTHORITY_MAP.json`.
3. Update `WAREHOUSE_SPECIFICATION.md §8` to record versioned format as `canonical`.
4. Close this plan with `status: complete`.

**Completion criterion:** CD-001 status updated to `accepted`.

## Grandfathering policy

Legacy `.signal` files that feed external consumers and cannot be migrated without
breaking those consumers may be grandfathered:

- Keep original path and format.
- Must carry `status: grandfathered` and `canonical_equivalent: <path>` fields.
- Are not parsed as authoritative signals.
- External consumer must be notified of migration timeline.

Grandfathering requires explicit Bruce approval and a record in `CANONIZATION_DECISIONS.md`.

## Legacy inventory table

> To be populated during Phase 1.

| File path | Field set | Migration type | Schema gaps | Status |
|-----------|-----------|----------------|-------------|--------|
| (TBD)     | (TBD)     | auto / manual / grandfather | (TBD) | pending |
