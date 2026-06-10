---
status: candidate
version: 0.1
authority: provisional
artifact: WAREHOUSE_CANONICALIZATION_REVIEW
---

# WAREHOUSE_CANONICALIZATION_REVIEW

## Executive finding

The Warehouse has crossed from idea-space into governable structure.

The current recovered corpus supports canonization work, but not final canon.
The safest next move is to bless a provisional authority set before more parser,
compiler, orchestration, or governance implementation proceeds.

## 1. What is directly supported

### Supported by recovered evidence

- A structured memory and policy subsystem exists.
- A stronger numbered memory taxonomy candidate exists.
- A versioned Signal-Lang spec and event schema exist.
- Agent contracts exist in shared form.
- Adapter/runtime separation exists.
- Explicit authority and write-governance concepts exist.

## 2. What is inferred

### High-confidence inference

- The system is converging toward an OS-like memory substrate.
- The shared/adapters split functions like a runtime ABI boundary.
- Lineage is culturally present but not yet machine-enforced.
- Canonization now has higher value than more implementation.

## 3. What requires Bruce approval

Bruce approval is required for:

1. Blessing `WAREHOUSE_SPECIFICATION.md` as provisional seed authority.
2. Blessing `WAREHOUSE_AUTHORITY_MAP.json` as provisional authority map.
3. Blessing `LINEAGE_SCHEMA.json` as provisional lineage contract.
4. Blessing `RECOVERY_MANIFEST_SCHEMA.json` as provisional recovery contract.
5. Choosing numbered taxonomy vs. unnumbered taxonomy.
6. Choosing versioned Signal format vs. legacy `.signal` format.
7. Deciding whether legacy artifacts are deprecated or grandfathered.

## 4. Which files should become canonical seeds

### Recommended provisional seeds

| File | Role |
|------|------|
| `WAREHOUSE_SPECIFICATION.md` | Root candidate specification |
| `WAREHOUSE_AUTHORITY_MAP.json` | Governance registry |
| `LINEAGE_SCHEMA.json` | Lineage contract |
| `RECOVERY_MANIFEST_SCHEMA.json` | Recovery contract |

### Recommended candidate-source inputs

| File | Role |
|------|------|
| `00-core/policies.md` | Write authority and governance rules |
| `50-maps/MEMORY_MAP.md` | Memory taxonomy |
| `60-signals/signal-lang.md` | Signal-Lang versioned spec |
| `60-signals/signal-schema.json` | Signal payload schema |
| Shared agent contract files | Agent behavioral boundaries |

## 5. Which files should remain experimental

Until explicitly blessed, treat as experimental or legacy-active:

- Legacy unnumbered taxonomy docs
- Legacy `.signal` format docs/files
- Any runtime-local convenience docs that conflict with policy-backed shared docs
- Any provisional scoring formula not explicitly approved

## 6. Exact decision for RM-09

RM-09 should be interpreted as:

> Bruce formally approves or rejects the provisional canon set as the current
> governance floor for the Warehouse.

That decision is not asking whether the Warehouse is complete.
It is asking whether these artifacts are allowed to function as provisional truth
while the rest of the canon is stabilized.

## 7. Safest next implementation step after approval

After approval, the safest next step is:

1. Publish a migration/deprecation note.
2. Wire validation against `LINEAGE_SCHEMA.json`.
3. Wire validation against `RECOVERY_MANIFEST_SCHEMA.json`.
4. Only then begin parser enforcement work against the blessed Signal format.

## 8. Bruce decision packet

Answer each item with **YES** or **NO**.

| # | Decision item | Answer |
|---|---------------|--------|
| 1 | Approve `WAREHOUSE_SPECIFICATION.md` as provisional candidate authority? | |
| 2 | Approve `WAREHOUSE_AUTHORITY_MAP.json` as provisional authority map? | |
| 3 | Approve `LINEAGE_SCHEMA.json` as provisional lineage contract? | |
| 4 | Approve `RECOVERY_MANIFEST_SCHEMA.json` as provisional recovery contract? | |
| 5 | Approve numbered taxonomy as default canonical tree? | |
| 6 | Approve versioned `60-signals` format as default canonical Signal format? | |
| 7 | Grandfather legacy unnumbered taxonomy temporarily? | |
| 8 | Grandfather legacy `.signal` format temporarily? | |
| 9 | Require explicit migration/deprecation note before parser implementation? | |
| 10 | Freeze canonization scope before new orchestration expansion? | |

## 9. Recommended default stance pending answers

Until Bruce answers the packet:

- Treat all four new canon artifacts as `candidate/provisional`.
- Prefer versioned + schema-backed sources over legacy descriptive ones.
- Do not mark the Warehouse fully canonical.
- Do not implement parser-centered enforcement that assumes unresolved decisions are settled.
