---
status: candidate
version: "0.1"
authority: provisional
artifact: CANONIZATION_DECISIONS
---

# CANONIZATION_DECISIONS

This file records explicit canonization decisions that have been accepted or proposed.
Decisions here supersede implied practice and convenience conventions.

## Status key

| Status | Meaning |
|--------|---------|
| `PROPOSED` | Drafted; pending Bruce approval |
| `ACCEPTED` | Approved; now in force |
| `REJECTED` | Considered and explicitly declined |
| `DEFERRED` | Under discussion; not yet resolved |

---

## CD-001 — Signal format authority

**Status:** `PROPOSED`  
**Proposed:** 2026-06-10  
**Decided by:** pending  

> The versioned, schema-backed Signal-Lang format defined in `60-signals/signal-lang.md`
> and validated by `60-signals/signal-schema.json` supersedes the legacy `.signal`
> front-matter format.

**Rationale:** Versioned + schema-backed artifacts provide deterministic parsing.
The legacy format relies on convention and is not machine-enforceable.

**Implications:**
- New signals must use the versioned format.
- Existing `.signal` files must be migrated per the deprecation plan.
- Parser implementations must target the versioned format only.

---

## CD-002 — Memory taxonomy authority

**Status:** `PROPOSED`  
**Proposed:** 2026-06-10  
**Decided by:** pending  

> The numbered memory taxonomy defined in `50-maps/MEMORY_MAP.md` supersedes
> the legacy unnumbered taxonomy unless a path is explicitly grandfathered.

**Rationale:** The numbered tree provides unambiguous ordering, zone separation,
and machine-sortable hierarchy. The unnumbered tree is inconsistent across references.

**Implications:**
- New memory artifacts must use numbered zone prefixes.
- Legacy unnumbered paths must be mapped and migrated.
- Grandfathered paths must be listed explicitly in the deprecation plan.

---

## CD-003 — Candidate specifications do not override source evidence

**Status:** `ACCEPTED` (pre-approved by convention)  
**Proposed:** 2026-06-10  
**Decided by:** convention  

> Candidate specification documents (including `WAREHOUSE_SPECIFICATION.md`)
> do not override direct source artifact evidence when a conflict exists.

**Rationale:** Reconstructed prose is always subordinate to the original source.
This prevents spec drift from becoming truth.

---

## CD-004 — Authority artifacts require explicit operator blessing

**Status:** `ACCEPTED` (pre-approved by convention)  
**Proposed:** 2026-06-10  
**Decided by:** convention  

> No artifact may be promoted to canonical authority by repeated use alone.
> Canonical promotion requires explicit approval from the operator (Bruce).

**Rationale:** Prevents agents, scripts, or accumulated convention from silently
promoting an artifact to authority status without human review.

---

## Adding a decision

To propose a new decision:

1. Assign the next sequential `CD-NNN` identifier.
2. Set status to `PROPOSED`.
3. Include rationale and implications.
4. Submit for Bruce review.
5. Update status to `ACCEPTED` or `REJECTED` after decision.
