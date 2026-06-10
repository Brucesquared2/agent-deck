---
status: candidate
version: "0.1"
authority: provisional
artifact: SIGNAL_LANG_MIGRATION_PLAN
---

# SIGNAL_LANG_MIGRATION_PLAN

Describes how to migrate from the legacy `.signal` front-matter format to the
canonical versioned Signal-Lang format. See CD-001 in `CANONIZATION_DECISIONS.md`.

## Current state

Two Signal formats are currently active:

| Format | Location | Status |
|--------|----------|--------|
| Versioned fenced-YAML blocks | `60-signals/signal-lang.md` + `signal-schema.json` | Preferred candidate |
| Legacy `.signal` front-matter | Various legacy files | Active legacy |

## Canonical Signal format (versioned)

A Signal in canonical form uses a fenced YAML block with an explicit version tag:

```yaml
signal:
  version: "1"
  id: "<unique-id>"
  type: "<signal-type>"
  emitted_at: "<ISO-8601-timestamp>"
  emitted_by: "<agent-or-system>"
  payload: {}
  lineage_ref: "<artifact-id or null>"
```

The canonical format is validated against `60-signals/signal-schema.json`.

## Legacy `.signal` format (deprecated)

The legacy format uses YAML/TOML front-matter in `.signal` files with no version
field and no schema validation. Field names and structure vary across files.

## Migration mapping

| Legacy field | Canonical field | Notes |
|-------------|----------------|-------|
| `id:` | `signal.id` | |
| `type:` | `signal.type` | |
| `timestamp:` | `signal.emitted_at` | Normalize to ISO 8601 |
| `author:` or `from:` | `signal.emitted_by` | |
| `data:` or `body:` | `signal.payload` | |
| *(none)* | `signal.version` | Add `"1"` for all migrated signals |
| *(none)* | `signal.lineage_ref` | Add if source session/artifact is known |

## Migration procedure

1. Inventory all `.signal` files and front-matter signal blocks.
2. For each, map legacy fields to canonical fields using the table above.
3. Validate the migrated signal against `60-signals/signal-schema.json`.
4. Replace the legacy file/block with the canonical form.
5. Add a tombstone comment in place of the old format.
6. Record the migration in `LINEAGE_SCHEMA.json` for the affected artifact.

## Grandfathered signals

The following signal files are temporarily grandfathered pending explicit migration:

<!-- Add entries here as grandfathering decisions are made -->
*(none yet — to be populated after Bruce decision packet is answered)*

## Deprecation timeline

- Phase 1 (now): Legacy `.signal` format is active-legacy; new signals must use versioned format.
- Phase 2 (after Bruce decision): Legacy `.signal` files are deprecated; tooling emits warnings.
- Phase 3 (after migration complete): Legacy `.signal` files are archived under `90-archive/`.

## Status

**BLOCKED** on Bruce decision packet items 6 and 8 (CD-001).
