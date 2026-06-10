---
status: candidate
version: "0.1"
authority: provisional
artifact: CANONIZATION_DECISIONS
---

# CANONIZATION_DECISIONS

Explicit decision records for the Warehouse canon. Each decision requires operator blessing
before it becomes enforceable. Decisions that remain `PENDING` are not yet in effect.

---

## CD-001 — Signal format precedence

**Decision:** Versioned schema-backed Signal format (`60-signals/signal-lang.md` + `60-signals/signal-schema.json`)
supersedes the legacy `.signal` front-matter format.

**Rationale:** The versioned format has deterministic parsing rules, a machine-readable JSON schema,
and explicit rejection of dynamic field discovery. The legacy format is descriptive and has no
validator.

**Alternatives considered:** Retaining both formats with a bridging adapter layer.

**Status:** `PENDING — awaiting Bruce decision packet Q6`

---

## CD-002 — Memory taxonomy precedence

**Decision:** The numbered taxonomy (`00-core`, `10-ops`, `20-projects`, `30-sessions`,
`40-knowledge`, `50-maps`, `60-signals`, `90-archive`) supersedes any unnumbered taxonomy.

**Rationale:** The numbered tree has clear tier semantics, is the structure present in the active
`agent-runtime` scaffold, and can be enforced by path pattern. The unnumbered tree lacks ordering
semantics.

**Alternatives considered:** Merging both trees into a flat namespace.

**Status:** `PENDING — awaiting Bruce decision packet Q5`

---

## CD-003 — Candidate specifications do not override source evidence

**Decision:** When a candidate specification conflicts with direct source artifact evidence,
the source evidence wins until the specification is formally blessed.

**Rationale:** Prevents specification drift where prose claims outrun actual implementation.

**Alternatives considered:** Specification-first authority with source evidence as corroboration.

**Status:** `ACTIVE — no blessing required; consistent with WAREHOUSE_SPECIFICATION.md §14`

---

## CD-004 — Authority artifacts require explicit operator blessing

**Decision:** No artifact may be promoted from `candidate` to `canonical` by agent action alone.
An operator (Bruce) must explicitly approve promotion.

**Rationale:** Agents may produce high-quality artifacts but cannot constitute an approval quorum.
Canon must not be writable by consensus or repeated agent use.

**Alternatives considered:** Automated promotion based on confidence score thresholds.

**Status:** `ACTIVE — no blessing required; consistent with WAREHOUSE_SPECIFICATION.md §11`

---

## CD-005 — Provisional set is the governance floor

**Decision:** The four provisional artifacts (`WAREHOUSE_SPECIFICATION.md`,
`WAREHOUSE_AUTHORITY_MAP.json`, `LINEAGE_SCHEMA.json`, `RECOVERY_MANIFEST_SCHEMA.json`) form the
governance floor while canon is being stabilized. They are not final canon, but they are the
reference point for all new work.

**Rationale:** Without a floor, every new implementation risks encoding an unresolved assumption.

**Alternatives considered:** Waiting for fully resolved canon before any governance artifacts exist.

**Status:** `PENDING — awaiting Bruce decision packet Q1–Q4`

---

## Adding a decision

Copy the template below and append above this line:

```md
## CD-NNN — <title>

**Decision:** <what was decided>

**Rationale:** <why this was chosen>

**Alternatives considered:** <what was evaluated and rejected>

**Status:** `PENDING | ACTIVE | SUPERSEDED | REVERSED — <reason>`
```
