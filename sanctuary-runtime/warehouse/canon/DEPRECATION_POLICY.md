---
status: candidate
version: "0.1"
authority: provisional
artifact: DEPRECATION_POLICY
---

# DEPRECATION_POLICY

## Purpose

This document defines the rules for deprecating Warehouse artifacts. It prevents silent deletion,
ensures lineage is preserved, and gives operators a predictable process for retiring content.

## Core principle

> No artifact is deleted silently. Every retired artifact carries a deprecation record and
> moves to `90-archive/` rather than being removed from history.

## Deprecation lifecycle

```
active → candidate-deprecated → deprecated → archived
```

| Stage | Meaning |
|-------|---------|
| `active` | Currently authoritative or in use |
| `candidate-deprecated` | Flagged for deprecation; decision pending operator approval |
| `deprecated` | Officially deprecated; no new writes; still readable |
| `archived` | Moved to `90-archive/`; read-only; not expected to be updated |

## Deprecation notice format

Every deprecated artifact must have the following block inserted at the **top** of the file (or
as a top-level key in JSON):

### Markdown files

```md
> ⚠️ **DEPRECATED** — This artifact is deprecated as of YYYY-MM-DD.
> Replaced by: `<path-to-replacement>`
> See: `DEPRECATION_POLICY.md` and `CANONIZATION_DECISIONS.md <CD-NNN>`
```

### JSON files

```json
{
  "_deprecated": true,
  "_deprecated_at": "YYYY-MM-DD",
  "_replaced_by": "<path-to-replacement>",
  "_see": "CANONIZATION_DECISIONS.md <CD-NNN>"
}
```

## Process

### Step 1 — Flag

Open a decision record in `CANONIZATION_DECISIONS.md` or `50-maps/DECISION_LOG.md` with status
`PENDING`. Record:

- artifact path
- reason for deprecation
- proposed replacement
- proposed deadline

### Step 2 — Approve

Operator (Bruce) approves the deprecation decision. Status moves to `ACTIVE`.

### Step 3 — Notice

Add the deprecation notice to the top of the artifact file. Update its lineage record
(`LINEAGE_SCHEMA.json` instance) to `status: deprecated`.

### Step 4 — Deadline

The default deprecation window is **30 days** from notice date unless explicitly extended.
During this window:

- Reads are allowed.
- New writes are forbidden.
- Agents must resolve references to the replacement artifact.

### Step 5 — Archive

After the deadline:

1. Move the artifact to `90-archive/`.
2. Update `WAREHOUSE_AUTHORITY_MAP.json` to mark the artifact as `archived`.
3. Update `50-maps/ENTITY_INDEX.md` to point to the archived path.

## What is never deleted

The following artifact types are **never deleted**, only archived:

- Canonical spec versions
- Decision records
- Lineage records
- Session logs
- Signal archives

## Exceptions

The following may bypass the standard process with operator written consent:

- Secrets or credentials discovered in source — immediate removal, lineage note added.
- Corrupted or zero-byte files with no meaningful content.

## Grandfathering

When a batch deprecation is approved (e.g., taxonomy migration, Signal format migration):

1. All affected artifacts receive the deprecation notice in a single commit.
2. The commit message references the governing decision (e.g., `CD-002`).
3. The 30-day window starts from that commit date.
