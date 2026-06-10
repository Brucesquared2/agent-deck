---
status: candidate
version: "0.1"
authority: provisional
artifact: WAREHOUSE_CANONICALIZATION_REVIEW
---

# WAREHOUSE_CANONICALIZATION_REVIEW

## Executive finding

The Warehouse has crossed from idea-space into governable structure.

The current recovered corpus supports canonization work, but not final canon.
The safest next move is to bless a provisional authority set before more parser,
compiler, orchestration, or governance implementation proceeds.

---

## 1. What is directly supported

### Supported by recovered evidence

- A structured memory and policy subsystem exists.
- A stronger numbered memory taxonomy candidate exists.
- A versioned Signal-Lang spec and event schema exist.
- Agent contracts exist in shared form.
- Adapter/runtime separation exists.
- Explicit authority and write-governance concepts exist.

---

## 2. What is inferred

### High-confidence inference

- The system is converging toward an OS-like memory substrate.
- The shared/adapters split functions like a runtime ABI boundary.
- Lineage is culturally present but not yet machine-enforced.
- Canonization now has higher value than more implementation.

---

## 3. What requires Bruce approval

Bruce approval is required for each item in the decision packet (section 8).

Summary of approvals needed:

1. Bless `WAREHOUSE_SPECIFICATION.md` as provisional seed authority.
2. Bless `WAREHOUSE_AUTHORITY_MAP.json` as provisional authority map.
3. Bless `LINEAGE_SCHEMA.json` as provisional lineage contract.
4. Bless `RECOVERY_MANIFEST_SCHEMA.json` as provisional recovery contract.
5. Choose numbered taxonomy vs unnumbered taxonomy.
6. Choose versioned Signal format vs legacy `.signal` format.
7. Decide whether legacy artifacts are deprecated or grandfathered.

---

## 4. Recommended provisional canon seeds

| File | Role |
|------|------|
| `WAREHOUSE_SPECIFICATION.md` | Root provisional spec |
| `WAREHOUSE_AUTHORITY_MAP.json` | Governance registry |
| `LINEAGE_SCHEMA.json` | First-class lineage contract |
| `RECOVERY_MANIFEST_SCHEMA.json` | Node rebuild contract |

### Recommended candidate-source inputs

| Source | Reason |
|--------|--------|
| `00-core/policies.md` | Strongest explicit authority/write-governance evidence |
| `50-maps/MEMORY_MAP.md` | Strongest numbered taxonomy candidate |
| `60-signals/signal-lang.md` | Strongest versioned Signal-Lang spec |
| `60-signals/signal-schema.json` | Formal signal/event payload schema |
| `agent-runtime/shared/agents/` | Shared agent behavioral contracts |

---

## 5. What should remain experimental until blessed

Treat the following as experimental or legacy-active until explicitly blessed:

- Legacy unnumbered taxonomy docs
- Legacy `.signal` format docs and files
- Runtime-local convenience docs that conflict with policy-backed shared docs
- Any provisional scoring formula not explicitly approved

---

## 6. Exact interpretation of RM-09

RM-09 should be interpreted as:

> Bruce formally approves or rejects the provisional canon set as the current
> governance floor for the Warehouse.

That decision is not asking whether the Warehouse is complete.
It is asking whether these artifacts are allowed to function as provisional truth
while the rest of the canon is stabilized.

---

## 7. Safest next implementation step after approval

1. Publish a migration/deprecation note.
2. Wire validation against `LINEAGE_SCHEMA.json`.
3. Wire validation against `RECOVERY_MANIFEST_SCHEMA.json`.
4. Only then begin parser enforcement work against the blessed Signal format.

---

## 8. Bruce decision packet

Answer each item with **YES** or **NO**.
Leave blank if deferring. Blanks are treated as "not yet approved."

| # | Question | Answer |
|---|----------|--------|
| 1 | Approve `WAREHOUSE_SPECIFICATION.md` as provisional candidate authority? | |
| 2 | Approve `WAREHOUSE_AUTHORITY_MAP.json` as provisional authority map? | |
| 3 | Approve `LINEAGE_SCHEMA.json` as provisional lineage contract? | |
| 4 | Approve `RECOVERY_MANIFEST_SCHEMA.json` as provisional recovery contract? | |
| 5 | Approve numbered taxonomy as default canonical tree? | |
| 6 | Approve versioned `60-signals` format as default canonical Signal format? | |
| 7 | Grandfather legacy unnumbered taxonomy temporarily (with migration note)? | |
| 8 | Grandfather legacy `.signal` format temporarily (with migration note)? | |
| 9 | Require explicit migration/deprecation note before parser implementation begins? | |
| 10 | Freeze canonization scope before new orchestration expansion? | |

---

## 9. Recommended default stance pending answers

Until Bruce answers the packet:

- Treat all four new canon artifacts as `candidate/provisional`.
- Prefer versioned + schema-backed sources over legacy descriptive ones.
- Do not mark the Warehouse fully canonical.
- Do not implement parser-centered enforcement that assumes unresolved decisions are settled.
- Do not start Signal-Lang parser, memory compiler, or large-scale orchestration work.

---

## 10. Canonization decisions in effect

The following decisions are pre-approved by convention and do not require the packet:

| ID    | Decision |
|-------|----------|
| CD-001 | Versioned schema-backed Signal format supersedes legacy Signal format. |
| CD-002 | Numbered taxonomy supersedes unnumbered taxonomy. |
| CD-003 | Candidate specifications do not override source evidence. |
| CD-004 | Authority artifacts require explicit operator blessing. |

These are provisional defaults only. They may be revised by Bruce approval.

---

## 11. Maturity estimate at time of authorship

| Subsystem | Estimated maturity |
|-----------|-------------------|
| Infrastructure | 85% |
| Runtime | 70% |
| Authority concepts | 60% |
| Memory model | 55% |
| Reflection model | 50% |
| Recovery model | 30% |
| Signal-Lang | 25% |
| Lineage system | 20% |
| Canonical spec | 35% |

---

## 12. Summary statement

> agent-deck contains a recoverable Warehouse-adjacent memory architecture with
> explicit policy, taxonomy, and event-model evidence, but the Warehouse canon
> is still incomplete until taxonomy, Signal format, and lineage/authority
> artifacts are formally blessed.
>
> The Warehouse has become measurable enough to govern, but not yet canonical
> enough to automate.
