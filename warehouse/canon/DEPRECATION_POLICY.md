---
status: candidate
version: 0.1
authority: provisional
artifact: DEPRECATION_POLICY
---

# DEPRECATION_POLICY

## Purpose

This document defines the rules for deprecating, grandfathering, and archiving
Warehouse artifacts. It is a companion to `CANONIZATION_DECISIONS.md`,
`TAXONOMY_MIGRATION_PLAN.md`, and `SIGNAL_LANG_MIGRATION_PLAN.md`.

## Principles

1. **Nothing is silently deleted.** Deprecated artifacts are marked and archived,
   not removed.
2. **Deprecation is a governance act.** It requires a decision record in
   `CANONIZATION_DECISIONS.md`.
3. **Grandfathering is explicit, bounded, and time-limited.** Grandfathered artifacts
   are not authority; they are legacy with a documented exit plan.
4. **Recovery must remain possible.** Archived artifacts stay readable so that
   lineage and provenance chains are not broken.

## Artifact states

| State | Meaning |
|-------|---------|
| `candidate` | Proposed; not yet blessed |
| `provisional` | Approved as a governance floor; not final canon |
| `canonical` | Formally blessed as authoritative |
| `deprecated` | Superseded; no longer authoritative; migration required |
| `grandfathered` | Legacy-active with a documented exit plan; not authority |
| `archived` | Read-only; preserved for lineage and provenance only |

State transitions require:

| Transition | Requires |
|------------|---------|
| candidate → provisional | Bruce decision packet item answered YES |
| provisional → canonical | Bruce approval + all blockers in WAREHOUSE_SPECIFICATION.md §16 cleared |
| canonical → deprecated | Bruce approval + decision record + canonical replacement named |
| any → grandfathered | Bruce approval + decision record + exit plan documented |
| deprecated/grandfathered → archived | Migration complete + no active references |

## Deprecation procedure

1. **Raise a decision item** in `CANONIZATION_DECISIONS.md` proposing deprecation.
2. **Name the canonical replacement** explicitly. Deprecation without a named
   replacement is blocked.
3. **Bruce approves** the decision item (status → `accepted`).
4. **Mark the artifact** with `status: deprecated` and `superseded_by: <canonical-path>`.
5. **Add a redirect notice** at the top of the deprecated document pointing to the
   canonical replacement.
6. **Publish a migration note** describing what consumers must change.
7. **Update `WAREHOUSE_AUTHORITY_MAP.json`** to remove the deprecated path from
   active authority entries.

## Grandfathering procedure

1. **Raise a decision item** in `CANONIZATION_DECISIONS.md` proposing grandfathering.
2. **Document the exit plan**: what would need to change for the grandfathered
   artifact to be fully migrated or archived.
3. **Set a review date**: grandfathered status is reviewed at each major canon version.
4. **Bruce approves.**
5. **Mark the artifact** with `status: grandfathered`, `canonical_equivalent: <path>`,
   and `review_date: <ISO-8601-date>`.

## Archival procedure

1. Migration for all dependents is complete.
2. No active references to the artifact remain in non-archived locations.
3. Move the artifact to `90-archive/` with its lineage record intact.
4. Record the archive action in `CANONIZATION_DECISIONS.md`.

## Prohibited actions

- **Silent deletion** of any artifact that has a lineage record or authority entry.
- **Deprecation without a named replacement.**
- **Parser or compiler enforcement** against a deprecated format that has no
  migration path for existing files.
- **Agent-driven deprecation.** Only human operator decisions may deprecate canonical
  or provisional artifacts.

## Retention

Archived artifacts in `90-archive/` are retained indefinitely unless Bruce explicitly
authorizes deletion. Deletion of an archived artifact requires a lineage note recording
the deletion event.
