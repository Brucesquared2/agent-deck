---
status: candidate
version: "0.1"
authority: provisional
artifact: TAXONOMY_MIGRATION_PLAN
---

# TAXONOMY_MIGRATION_PLAN

Describes how to migrate from the legacy unnumbered memory taxonomy to the canonical
numbered taxonomy. See CD-002 in `CANONIZATION_DECISIONS.md`.

## Current state

Two taxonomies are currently active:

| Taxonomy | Status |
|----------|--------|
| Numbered (`00-core`, `10-ops`, …) | Preferred candidate |
| Legacy unnumbered (`core/`, `ops/`, …) | Active legacy |

## Canonical numbered zones

```
00-core/      — policies, authority, core governance
10-ops/       — operational configs, infra, system state
20-projects/  — project records, milestones, deliverables
30-sessions/  — session records, task logs, agent outputs
40-knowledge/ — reference material, documentation, domain notes
50-maps/      — taxonomy maps, memory maps, spatial indexes
60-signals/   — Signal-Lang specs, schemas, signal records
90-archive/   — deprecated, superseded, frozen artifacts
```

## Migration mapping

| Legacy path | Canonical path | Notes |
|-------------|---------------|-------|
| `core/` | `00-core/` | |
| `ops/` | `10-ops/` | |
| `projects/` | `20-projects/` | |
| `sessions/` | `30-sessions/` | |
| `knowledge/` | `40-knowledge/` | |
| `maps/` | `50-maps/` | |
| `signals/` | `60-signals/` | |
| `archive/` | `90-archive/` | |

Paths not listed above require individual triage before migration.

## Grandfathered paths

The following legacy paths are temporarily grandfathered pending explicit migration:

<!-- Add entries here as grandfathering decisions are made -->
*(none yet — to be populated after Bruce decision packet is answered)*

## Migration procedure

1. For each legacy path, identify its canonical numbered equivalent.
2. Move content to the canonical path.
3. Add a redirect/tombstone note at the legacy path.
4. Update all artifact references that pointed to the legacy path.
5. Update `WAREHOUSE_AUTHORITY_MAP.json` to reflect the new canonical path.
6. Remove the legacy path after a deprecation notice period (see `DEPRECATION_POLICY.md`).

## Deprecation timeline

- Phase 1 (now): Legacy paths are active-legacy; new artifacts must use numbered zones.
- Phase 2 (after Bruce decision): Legacy paths are deprecated; warnings issued on use.
- Phase 3 (after migration complete): Legacy paths are archived under `90-archive/`.

## Status

**BLOCKED** on Bruce decision packet item 5 and 7 (CD-002).
