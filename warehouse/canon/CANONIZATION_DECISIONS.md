---
status: candidate
version: 0.1
authority: provisional
artifact: CANONIZATION_DECISIONS
---

# CANONIZATION_DECISIONS

This file is the canonical log of all decisions that govern the Warehouse canon.
Each entry is immutable once accepted. Supersession is handled by a new entry that
references the one it replaces.

## Decision record format

| Field | Meaning |
|-------|---------|
| `ID` | Sequential decision identifier (CD-NNN) |
| `Status` | `proposed` / `accepted` / `rejected` / `superseded` |
| `Date` | ISO-8601 date of acceptance or rejection |
| `Approved by` | Human operator who blessed this decision |
| `Supersedes` | ID of any prior decision this replaces |
| `Statement` | The binding canonical statement |
| `Rationale` | Supporting reasoning |

---

## CD-001 — Signal format precedence

| Field | Value |
|-------|-------|
| **Status** | proposed |
| **Date** | — |
| **Approved by** | — |
| **Supersedes** | — |

**Statement:** The versioned Signal-Lang spec at `60-signals/signal-lang.md` and
`60-signals/signal-schema.json` supersede the legacy `.signal` front-matter format
as the authoritative Signal format for the Warehouse.

**Rationale:** The versioned spec is schema-backed and enforces deterministic parsing.
The legacy format is undocumented and fragile. Precedence rule 1 in
`WAREHOUSE_SPECIFICATION.md §14` requires schema-backed formats to win.

---

## CD-002 — Taxonomy precedence

| Field | Value |
|-------|-------|
| **Status** | proposed |
| **Date** | — |
| **Approved by** | — |
| **Supersedes** | — |

**Statement:** The numbered taxonomy (`00-core` … `90-archive`) defined in
`50-maps/MEMORY_MAP.md` supersedes the legacy unnumbered taxonomy as the
authoritative memory tree for the Warehouse.

**Rationale:** The numbered tree is explicit, sortable, and prefix-scoped. The
unnumbered tree is legacy convenience. Precedence rule 3 in
`WAREHOUSE_SPECIFICATION.md §14` requires the numbered tree to win unless
explicitly grandfathered.

---

## CD-003 — Candidate specifications do not override source evidence

| Field | Value |
|-------|-------|
| **Status** | proposed |
| **Date** | — |
| **Approved by** | — |
| **Supersedes** | — |

**Statement:** Candidate or provisional specification documents (including this
canon set) are subordinate to direct source evidence when a conflict exists.
Source evidence always wins.

**Rationale:** Spec documents reconstruct intent; source artifacts express realized
truth. Specs catch up to sources, not the reverse.

---

## CD-004 — Explicit operator blessing required for canon promotion

| Field | Value |
|-------|-------|
| **Status** | proposed |
| **Date** | — |
| **Approved by** | — |
| **Supersedes** | — |

**Statement:** No artifact may be promoted from `candidate`/`provisional` to
`canonical` by agent action, repeated use, or convention alone. Promotion requires
explicit human operator approval recorded in this file.

**Rationale:** Agents consume authority but do not create authority (Axiom A8).
Canonical status is a governance act, not an emergent property.

---

## CD-005 — Lineage schema required before orchestration expansion

| Field | Value |
|-------|-------|
| **Status** | proposed |
| **Date** | — |
| **Approved by** | — |
| **Supersedes** | — |

**Statement:** The lineage schema (`LINEAGE_SCHEMA.json`) must be accepted before
new orchestration, parser, or memory-compiler work begins that would produce
artifacts without machine-verifiable lineage.

**Rationale:** Lineage-free orchestration output becomes ungovernable. The
implementation sequencing rule in `WAREHOUSE_SPECIFICATION.md §17` enforces this.

---

## CD-006 — Recovery manifest schema required before large-scale orchestration

| Field | Value |
|-------|-------|
| **Status** | proposed |
| **Date** | — |
| **Approved by** | — |
| **Supersedes** | — |

**Statement:** The recovery manifest schema (`RECOVERY_MANIFEST_SCHEMA.json`) must
be accepted before large-scale orchestration work that would make node rebuild
non-deterministic.

**Rationale:** Recovery must be deterministic (Axiom A7). Without a manifest
schema, recovery devolves to tribal knowledge.
