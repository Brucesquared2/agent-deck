---
status: candidate
version: "0.1"
authority: provisional
artifact: WAREHOUSE_CANONICALIZATION_REVIEW
---

# WAREHOUSE_CANONICALIZATION_REVIEW

> **Note:** The canonical location for this file is `warehouse/canon/WAREHOUSE_CANONICALIZATION_REVIEW.md`.
> A prior draft exists at `WAREHOUSE_CANONICALIZATION_REVIEW.md` in the repo root (created 2026-06-10).
> This copy supersedes that draft. The root copy is retained as a historical artifact.

---

## Executive finding

The Warehouse has crossed from idea-space into governable structure.

The current recovered corpus supports canonization work, but not final canon.
The safest next move is to bless a provisional authority set before more parser,
compiler, orchestration, or governance implementation proceeds.

---

## 1. What is directly supported

The following claims are directly supported by source artifacts present in the repository.

| Claim | Source |
|-------|--------|
| Structured memory and policy subsystem exists | `agent-runtime/shared/memory/00-core/policies.md` |
| Numbered memory taxonomy candidate exists | `agent-runtime/shared/memory/50-maps/MEMORY_MAP.md` |
| Versioned Signal-Lang spec and event schema exist | `agent-runtime/shared/memory/60-signals/` |
| Agent contracts exist in shared form | `agent-runtime/shared/agents/` |
| Adapter/runtime separation exists | `agent-runtime/shared/` vs `agent-runtime/{opencode,aider,pi,agent-deck}/` |
| Explicit authority and write-governance concepts exist | `agent-runtime/shared/memory/00-core/policies.md` |
| ADR-001 ratified YAML-in-Markdown as signal format | `agent-runtime/shared/memory/50-maps/DECISION_LOG.md` |
| Dual taxonomy (numbered vs. legacy) is active | Both `00-core/` and `core/` trees present and referenced |
| Dual signal format (v1.0 vs. .signal) is active | `60-signals/*.md` and `signals/*.signal` both present |
| No Signal-Lang parser exists | No parser source found anywhere in repository |

---

## 2. What is inferred

The following claims are high-confidence synthesis from multiple artifacts, but not directly cited by a single source file.

| Claim | Inference basis |
|-------|----------------|
| System is converging toward an OS-like memory substrate | Memory taxonomy, authority model, and agent contracts together suggest OS-style layering |
| shared/adapters split functions like a runtime ABI boundary | Directory structure mirrors ABI separation patterns |
| Lineage is culturally present but not machine-enforced | Lineage fields exist in session templates and ADRs, but no schema enforces them |
| Canonization has higher value than more implementation | Dual-truth risk grows with each new implementation that assumes an unresolved decision |

---

## 3. What requires Bruce approval

Bruce approval is required for the following before any implementation proceeds:

1. Blessing `WAREHOUSE_SPECIFICATION.md` as provisional seed authority
2. Blessing `WAREHOUSE_AUTHORITY_MAP.json` as provisional authority map
3. Blessing `LINEAGE_SCHEMA.json` as provisional lineage contract
4. Blessing `RECOVERY_MANIFEST_SCHEMA.json` as provisional recovery contract
5. Choosing numbered taxonomy as canonical, with legacy grandfathered temporarily
6. Choosing versioned YAML-in-Markdown Signal format as canonical
7. Deciding whether legacy taxonomy artifacts are deprecated or grandfathered permanently
8. Deciding whether legacy `.signal` artifacts are deprecated or grandfathered permanently
9. Deciding whether migration notes must exist before parser implementation begins
10. Deciding whether canonization scope should be frozen before new orchestration expansion

---

## 4. Recommended canonical seeds

### Provisional seed artifacts (warehouse/canon/)

These four files form the governance floor:

| Artifact | Purpose |
|----------|---------|
| `WAREHOUSE_SPECIFICATION.md` | Defines axioms, layers, and authority model |
| `WAREHOUSE_AUTHORITY_MAP.json` | Maps each artifact family to its single authority source |
| `LINEAGE_SCHEMA.json` | First-class machine-validatable lineage contract |
| `RECOVERY_MANIFEST_SCHEMA.json` | First-class machine-validatable recovery contract |

### Candidate source inputs (agent-runtime/)

These existing files are strong enough to be cited by the provisional seeds:

| File | Strength |
|------|----------|
| `agent-runtime/shared/memory/00-core/policies.md` | Explicit write-authority table; append-only rule |
| `agent-runtime/shared/memory/50-maps/MEMORY_MAP.md` | Comprehensive numbered zone overview |
| `agent-runtime/shared/memory/60-signals/signal-lang.md` | Version-stamped spec; ADR-001 accepted |
| `agent-runtime/shared/memory/60-signals/signal-schema.json` | Machine-validatable; 5 typed signal variants |
| `agent-runtime/shared/agents/*.md` | Four shared agent contracts |

---

## 5. Files that should remain experimental

Until explicitly blessed, treat as experimental or legacy-active:

- Legacy unnumbered taxonomy docs (`core/`, `ops/`, `maps/`, etc.)
- Legacy `.signal` format docs and files
- Any runtime-local convenience docs that conflict with policy-backed shared docs
- Any provisional scoring formula not explicitly approved by Bruce

---

## 6. RM-09 definition

RM-09 should be interpreted as:

> Bruce formally approves or rejects the provisional canon set as the current
> governance floor for the Warehouse.

That decision is not asking whether the Warehouse is complete.
It is asking whether these artifacts are allowed to function as provisional truth
while the rest of the canon is stabilized.

---

## 7. Safest next implementation step

After Bruce approves the decision packet:

1. Append ADR-004 and ADR-005 to `DECISION_LOG.md` (taxonomy precedence, signal format precedence)
2. Publish `TAXONOMY_MIGRATION_PLAN.md` (redirect stubs, agent contract unification)
3. Publish `SIGNAL_LANG_MIGRATION_PLAN.md` (legacy `.signal` file status, new emission rules)
4. Add lineage fields to any new canonical artifact
5. Wire JSON Schema validation against `LINEAGE_SCHEMA.json` and `RECOVERY_MANIFEST_SCHEMA.json`
6. Only then begin Signal-Lang parser enforcement work

**Do not proceed before approval:**

- Do not delete or rename any legacy zone file
- Do not implement a Signal-Lang parser (format not yet locked)
- Do not mark this specification canonical (pending Bruce approval)
- Do not start new orchestration layers that assume unresolved decisions are settled

---

## 8. Bruce decision packet

Answer each item with **YES** or **NO**.

| # | Decision |
|---|----------|
| 1 | Approve `WAREHOUSE_SPECIFICATION.md` as provisional candidate authority? |
| 2 | Approve `WAREHOUSE_AUTHORITY_MAP.json` as provisional authority map? |
| 3 | Approve `LINEAGE_SCHEMA.json` as provisional lineage contract? |
| 4 | Approve `RECOVERY_MANIFEST_SCHEMA.json` as provisional recovery contract? |
| 5 | Approve numbered taxonomy (`00-core/` …) as the default canonical tree? |
| 6 | Approve versioned `60-signals` YAML-in-Markdown as the default canonical Signal format? |
| 7 | Grandfather legacy unnumbered taxonomy temporarily (retain as read-only, not deprecated)? |
| 8 | Grandfather legacy `.signal` format temporarily (retain as read-only, not deprecated)? |
| 9 | Require explicit migration/deprecation note before any parser implementation begins? |
| 10 | Freeze canonization scope before new orchestration expansion? |

---

## 9. Recommended default stance pending answers

Until Bruce answers the packet:

- Treat all four new canon artifacts as `candidate/provisional`
- Prefer versioned + schema-backed sources over legacy descriptive ones
- Do not mark the Warehouse fully canonical
- Do not implement parser-centered enforcement that assumes unresolved decisions are settled
- Do not start new orchestration expansion
