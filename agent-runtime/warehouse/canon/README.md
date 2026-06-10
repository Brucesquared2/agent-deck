# warehouse/canon

**Status:** candidate · **Version:** 0.1 · **Authority:** provisional

This directory is the provisional canon seed for the Warehouse.

Its purpose is to prevent multiple truths from emerging simultaneously while the
full Warehouse canon is stabilized and blessed.

---

## Contents

| File | Purpose |
|------|---------|
| [`WAREHOUSE_SPECIFICATION.md`](WAREHOUSE_SPECIFICATION.md) | Root provisional spec — axioms, layer model, authority rules, canon blockers |
| [`WAREHOUSE_AUTHORITY_MAP.json`](WAREHOUSE_AUTHORITY_MAP.json) | Governance registry — one canonical source per artifact family |
| [`LINEAGE_SCHEMA.json`](LINEAGE_SCHEMA.json) | JSON Schema for first-class lineage records (draft-07) |
| [`RECOVERY_MANIFEST_SCHEMA.json`](RECOVERY_MANIFEST_SCHEMA.json) | JSON Schema for machine-readable node recovery manifests (draft-07) |
| [`WAREHOUSE_CANONICALIZATION_REVIEW.md`](WAREHOUSE_CANONICALIZATION_REVIEW.md) | Evidence summary + Bruce decision packet |
| [`CANONIZATION_DECISIONS.md`](CANONIZATION_DECISIONS.md) | Explicit accepted/proposed canonization decisions (CD-001…) |
| [`TAXONOMY_MIGRATION_PLAN.md`](TAXONOMY_MIGRATION_PLAN.md) | How to migrate unnumbered → numbered taxonomy |
| [`SIGNAL_LANG_MIGRATION_PLAN.md`](SIGNAL_LANG_MIGRATION_PLAN.md) | How to migrate legacy `.signal` → versioned Signal-Lang format |
| [`DEPRECATION_POLICY.md`](DEPRECATION_POLICY.md) | Rules governing deprecation phases, tombstones, and grandfathering |

---

## How to use this directory

1. **Read `WAREHOUSE_SPECIFICATION.md` first.** It defines the governing axioms,
   layer model, and current canon blockers.

2. **Check `WAREHOUSE_AUTHORITY_MAP.json`** to find the authoritative source for
   any artifact family before creating or modifying files.

3. **Use `LINEAGE_SCHEMA.json`** to validate lineage records on new canonical artifacts.

4. **Use `RECOVERY_MANIFEST_SCHEMA.json`** to author or validate node recovery manifests.

5. **Answer the decision packet** in `WAREHOUSE_CANONICALIZATION_REVIEW.md` (section 8)
   to unblock taxonomy and Signal format resolution.

6. **Check `CANONIZATION_DECISIONS.md`** before implementing any parser, compiler,
   or enforcement logic to confirm which decisions are accepted vs proposed.

---

## What "candidate/provisional" means

Every file in this directory is marked:

```yaml
status: candidate
version: "0.1"
authority: provisional
```

This means:

- These artifacts create a **governance floor**, not final canon.
- They are the current best reconstruction from recovered evidence.
- They are **subordinate to direct source evidence** when conflict exists.
- They become canonical only after Bruce approves the decision packet.

---

## Current canon blockers

- [ ] Dual taxonomy unresolved (numbered vs unnumbered)
- [ ] Dual Signal format unresolved (versioned vs legacy `.signal`)
- [ ] Lineage schema not yet wired to enforcement
- [ ] Recovery manifest schema not yet wired to enforcement
- [ ] Decision packet (WAREHOUSE_CANONICALIZATION_REVIEW §8) not yet answered
