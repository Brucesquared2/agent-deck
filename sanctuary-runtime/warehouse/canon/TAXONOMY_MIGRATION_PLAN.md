---
status: candidate
version: "0.1"
authority: provisional
artifact: TAXONOMY_MIGRATION_PLAN
---

# TAXONOMY_MIGRATION_PLAN

## Purpose

This document resolves the dual-taxonomy conflict identified in
`WAREHOUSE_SPECIFICATION.md §7.3` and `CANONIZATION_DECISIONS.md CD-002`.

## The conflict

Two memory taxonomy shapes currently coexist:

| Shape | Description | Location |
|-------|-------------|---------|
| **Numbered** | `00-core/`, `10-ops/`, `20-projects/`, `30-sessions/`, `40-knowledge/`, `50-maps/`, `60-signals/`, `90-archive/` | `sanctuary-runtime/agent-runtime/shared/memory/` |
| **Unnumbered** | Ad-hoc folder names without numeric prefix | Legacy docs and older references |

## Decision dependency

This plan activates only after Bruce approves CD-002 (Q5 of the decision packet).
Until then, both shapes remain in use and the numbered tree is preferred but not enforced.

## Migration path

### Phase 1 — Declare (no file moves)

1. Bruce approves CD-002.
2. Update `CANONIZATION_DECISIONS.md` CD-002 status to `ACTIVE`.
3. Update `WAREHOUSE_AUTHORITY_MAP.json` to mark `memory-taxonomy` as `canonical`.

### Phase 2 — Map legacy references

1. Identify all documents referencing unnumbered taxonomy paths.
2. For each, create a mapping entry in the table below.
3. Classify each as: **redirect** (still valid, just add numeric prefix) or **archive** (no longer maintained).

| Legacy path | Mapped numbered path | Classification |
|-------------|----------------------|----------------|
| *(to be filled in after Phase 1)* | — | — |

### Phase 3 — Grandfathering (if Q7 = YES)

If Bruce approves grandfathering (Q7):

- Legacy unnumbered docs remain readable but are labeled `[LEGACY]` in their headers.
- No new content is written to unnumbered paths.
- Agents must resolve references to numbered paths.

### Phase 4 — Deprecation (if Q7 = NO)

If Bruce does not grandfather:

- A deprecation notice is added to each legacy document (see `DEPRECATION_POLICY.md`).
- A deadline is set (default: 30 days after Phase 1).
- After the deadline, legacy docs move to `90-archive/`.

## Enforcement

After Phase 1, the sync script (`scripts/sync-skills.sh`) and agent prompts should
reference only numbered paths. Any CI check or review that encounters an unnumbered
taxonomy reference should flag it as a lint warning.

## Success criterion

A new operator can answer "where does X go in memory?" by reading only the numbered
taxonomy without encountering unnumbered path references.
