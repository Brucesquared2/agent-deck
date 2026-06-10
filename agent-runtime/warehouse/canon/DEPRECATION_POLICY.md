---
status: candidate
version: "0.1"
authority: provisional
artifact: DEPRECATION_POLICY
---

# DEPRECATION_POLICY

Governs how artifacts, paths, and formats are deprecated in the Warehouse.

## Principles

1. **No silent removal.** Deprecated artifacts must be announced before removal.
2. **Tombstones required.** Every deprecated path must leave a tombstone note
   pointing to its canonical replacement.
3. **Grandfathering is explicit.** Grandfathered paths must be listed in the
   relevant migration plan. Unlisted paths are not grandfathered.
4. **Reflections are not authority.** Deprecated artifacts that exist as reflection
   copies may be removed without notice once the authority source is current.

## Deprecation phases

Every deprecated artifact passes through three phases:

| Phase | Label | Behavior |
|-------|-------|----------|
| 1 | `active-legacy` | Still functional. New artifacts must not use this format/path. |
| 2 | `deprecated` | Tooling emits warnings. Migration is required within the current sprint. |
| 3 | `archived` | Moved to `90-archive/`. No longer referenced by active canon. |

## Minimum notice period

- From `active-legacy` → `deprecated`: no minimum; may be immediate after Bruce decision.
- From `deprecated` → `archived`: minimum 1 sprint (or 2 weeks), whichever is longer.

## Tombstone format

When a file or path is deprecated, leave a tombstone at the old location:

```markdown
# DEPRECATED

This artifact has been deprecated.

- Deprecated: <date>
- Canonical replacement: <path or ID>
- Migration guide: <link to migration plan>
- Archive location: 90-archive/<original-path>
```

## Currently deprecated artifacts

| Artifact | Phase | Canonical replacement | Migration plan |
|----------|-------|-----------------------|----------------|
| *(none yet)* | | | |

## Currently grandfathered artifacts

| Artifact | Grandfathered until | Decision ref |
|----------|---------------------|-------------|
| *(none yet — pending Bruce decision packet)* | | |

## Adding a deprecation

1. Change the artifact's status to `active-legacy` in `WAREHOUSE_AUTHORITY_MAP.json`.
2. Add a row to the "Currently deprecated artifacts" table above.
3. Add a tombstone note at the deprecated path.
4. Reference the relevant migration plan.
5. Advance to `deprecated` after Bruce confirmation.
6. Advance to `archived` after the minimum notice period.
