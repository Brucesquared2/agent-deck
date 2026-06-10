---
status: candidate
version: "0.1"
authority: provisional
artifact: SIGNAL_LANG_MIGRATION_PLAN
---

# SIGNAL_LANG_MIGRATION_PLAN

## Purpose

This document resolves the dual-Signal-format conflict identified in
`WAREHOUSE_SPECIFICATION.md §8` and `CANONIZATION_DECISIONS.md CD-001`.

## The conflict

Two Signal formats currently coexist:

| Format | Description | Location |
|--------|-------------|---------|
| **Versioned Signal-Lang** | Deterministic parsing, JSON schema validation, explicit type system | `60-signals/signal-lang.md`, `60-signals/signal-schema.json` |
| **Legacy `.signal` front-matter** | YAML-like front-matter blocks, no formal schema, dynamic field discovery | Legacy files and older agent prompts |

## Decision dependency

This plan activates only after Bruce approves CD-001 (Q6 of the decision packet).
Until then, both formats remain in use and the versioned format is preferred but not enforced.

## Migration path

### Phase 1 — Declare (no file changes)

1. Bruce approves CD-001.
2. Update `CANONIZATION_DECISIONS.md` CD-001 status to `ACTIVE`.
3. Update `WAREHOUSE_AUTHORITY_MAP.json`: mark `signal-lang` as `canonical`.

### Phase 2 — Inventory legacy signals

1. Find all files containing legacy `.signal` front-matter blocks.
2. Record them in the mapping table below.
3. Classify each as: **convertible** (can be mechanically translated) or **review-required** (needs human decision).

| Legacy file | Signal type | Classification |
|-------------|-------------|----------------|
| *(to be filled in after Phase 1)* | — | — |

### Phase 3 — Conversion tooling

1. Write a conversion script or use an agent task to transform legacy `.signal` blocks into
   versioned Signal-Lang format using `60-signals/signal-schema.json` as the target schema.
2. For `review-required` entries, produce a diff and request operator sign-off.

### Phase 4 — Grandfathering (if Q8 = YES)

If Bruce approves grandfathering (Q8):

- Legacy `.signal` files are labeled `[LEGACY FORMAT]` at the top.
- No new content is written in legacy format.
- Agents and parsers must handle both formats during the transition window.
- Transition window: default 60 days after Phase 1.

### Phase 5 — Deprecation (if Q8 = NO)

If Bruce does not grandfather:

- Each legacy `.signal` file receives a deprecation notice (see `DEPRECATION_POLICY.md`).
- A conversion deadline is set (default: 30 days after Phase 1).
- After the deadline, unconverted files move to `90-archive/`.

## Parser enforcement rule

- **[DECISION]** Parser work against Signal-Lang MUST NOT begin before Phase 1 completes.
- After Phase 1, the parser MAY target only the versioned format.
- The parser SHOULD reject legacy format by default and emit a clear migration error.

## Validation

Once the versioned format is enforced:

```sh
# Validate a signal file against the schema
npx ajv validate -s 60-signals/signal-schema.json -d <signal-file.json>
```

## Success criterion

All signal artifacts in active use validate against `signal-schema.json` without errors.
No agent prompt or adapter config references the legacy `.signal` front-matter format.
