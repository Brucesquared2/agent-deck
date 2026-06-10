---
status: candidate
version: "0.1"
authority: provisional
artifact: WAREHOUSE_SPECIFICATION
---

# WAREHOUSE_SPECIFICATION

## 0. Purpose

This document is the provisional candidate specification for the Warehouse canon.
It is not final authority. It is the current best reconstruction from recovered
artifacts, archaeology outputs, runtime scaffolding, and explicit source-grounded
findings.

This document exists to prevent multiple truths from emerging simultaneously.

## 1. Canon status

This specification is:

- candidate
- provisional
- subject to Bruce approval
- subordinate to direct source evidence when conflict exists

Normative statements in this document use these tags:

- **[FACT]** directly supported by source artifacts
- **[INFERENCE]** high-confidence synthesis from multiple artifacts
- **[AMBIGUITY]** unresolved conflict, dual authority, or missing evidence
- **[DECISION]** requires human approval before becoming canonical

## 2. Identity

- **[INFERENCE]** The Warehouse is not merely an application, note system, or infrastructure stack.
  It is an authority-centered memory substrate.
- **[INFERENCE]** The Warehouse should be treated as an operating substrate in which files,
  memory, state, lineage, and execution are different views of the same system object.
- **[FACT]** The strongest in-repo evidence today is a structured memory and authority subsystem,
  not a fully explicit warehouse-native package.

## 3. Core axioms

The current canonical candidate axioms are:

| ID | Axiom |
|----|-------|
| A1 | Events are immutable. |
| A2 | State is derived. |
| A3 | Narrative explains state. |
| A4 | Lineage must be preserved. |
| A5 | Authority must be explicit. |
| A6 | Reflections are not authority. |
| A7 | Recovery must be deterministic. |
| A8 | Agents consume authority but do not create authority. |
| A9 | Canon supersedes convenience. |

These axioms remain **candidate** until explicitly blessed by Bruce.

## 4. Layered model

The current layer stack is:

| Layer | Name | Description |
|-------|------|-------------|
| L0 | Events | Immutable event facts |
| L1 | State | Materialized current truth |
| L2 | Narrative | Human-readable interpretation |
| L3 | Lineage | Provenance and transformation tracking |
| L4 | Semantic | Linked meaning and retrieval structure |
| L5 | Symbolic | Formal abstraction, Signal-Lang, graphable structures |
| L6 | Compiled | Derived machine-oriented artifacts |
| L7 | Retention | Preservation, decay, archival, and pruning policy |

### 4.1 Layer confidence

- **[FACT]** L2 and parts of L3/L5 are strongly evidenced by recovered docs.
- **[INFERENCE]** The full L0–L7 stack is the best current architecture synthesis.
- **[AMBIGUITY]** Some layers are explicit, some inferred, and some still aspirational.

## 5. Canonical runtime split

The Warehouse runtime candidate model is split into:

**Shared canon**

- agents
- skills
- memory
- mcp

**Execution adapters**

- opencode
- aider
- pi
- agent-deck

**[INFERENCE]** This split is the beginning of a Warehouse Runtime ABI.

Source evidence: `agent-runtime/shared/` vs `agent-runtime/{opencode,aider,pi,agent-deck}/`

## 6. Authority model

### 6.1 Authority rules

- **[FACT]** Authority is singular per artifact family. (Source: `agent-runtime/shared/memory/00-core/policies.md`)
- **[FACT]** Layer-specific write control exists in current recovered policy documents.
- **[FACT]** Non-authoritative scans, reflections, mirrors, and generated copies are not truth.
- **[INFERENCE]** Authority must become machine-readable, not just described in prose.

### 6.2 Current candidate authority sources

The strongest current candidates are:

| Artifact | Path | Domain |
|----------|------|--------|
| Write authority and governance rules | `agent-runtime/shared/memory/00-core/policies.md` | Memory write control |
| Numbered memory taxonomy | `agent-runtime/shared/memory/50-maps/MEMORY_MAP.md` | Filesystem layout |
| Versioned Signal-Lang spec | `agent-runtime/shared/memory/60-signals/signal-lang.md` | Event interchange |
| Signal payload validation | `agent-runtime/shared/memory/60-signals/signal-schema.json` | Event schema |
| Behavioral boundaries | `agent-runtime/shared/agents/*.md` | Agent governance |

## 7. Memory system

### 7.1 Memory classes

The memory system should distinguish at minimum:

- events
- state
- narrative
- lineage
- semantic links
- symbolic structures
- compiled artifacts
- retention policy objects

### 7.2 Memory hierarchy

The strongest current candidate hierarchy is the numbered taxonomy in
`agent-runtime/shared/memory/`:

```
00-core/       Principles, north star, policies
10-ops/        Runbooks, checklists, incident notes
20-projects/   Per-project packs
30-sessions/   Per-session logs and summaries
40-knowledge/  Facts, references, learned patterns
50-maps/       Indexes and maps
60-signals/    Signal-lang spec and examples
90-archive/    Retired entries
```

### 7.3 Current ambiguity

- **[AMBIGUITY]** The numbered tree and the legacy unnumbered tree (`core/`, `ops/`, `maps/`,
  `signals/`, …) both remain in active reference.
- **[DECISION]** One taxonomy must become canonical and the other must be mapped,
  deprecated, or grandfathered. (See `TAXONOMY_MIGRATION_PLAN.md`)

## 8. Signal-Lang role

### 8.1 Current state

- **[FACT]** A versioned Signal-Lang spec v1.0 and JSON Schema exist.
  Source: `agent-runtime/shared/memory/60-signals/`
- **[FACT]** The current spec emphasizes deterministic parsing and rejects dynamic field discovery.
- **[FACT]** ADR-001 ratified YAML-in-Markdown as the accepted format.
  Source: `agent-runtime/shared/memory/50-maps/DECISION_LOG.md`
- **[AMBIGUITY]** A legacy `.signal` front-matter format also exists in `signals/` and is
  referenced by `sessions/2026-04-29-001/`.
- **[DECISION]** One Signal format must be named authoritative.
  (See `SIGNAL_LANG_MIGRATION_PLAN.md`)

### 8.2 Architectural role

**[INFERENCE]** Signal-Lang belongs in the symbolic/control plane of the Warehouse (L5), but it
is not yet sufficiently connected to active lineage to be treated as fully central canon.

## 9. Lineage model

### 9.1 Current state

- **[FACT]** Lineage-bearing fields exist in session templates, decision logs, and signal artifacts.
- **[FACT]** There is no blessed standalone lineage schema.
- **[INFERENCE]** The current practical lineage graph can be reconstructed from IDs, timestamps,
  session references, supersession links, and referenced artifact paths.

### 9.2 Canon requirement

- **[DECISION]** The Warehouse must define a first-class lineage schema. (See `LINEAGE_SCHEMA.json`)
- **[DECISION]** No artifact family should become final canon without provenance and lineage fields.

## 10. Reflection and recovery

### 10.1 Reflection

- **[FACT]** Duplication patterns exist across multiple memory zones.
- **[INFERENCE]** Reflection should mean recoverable mirrors, not authoritative copies.

### 10.2 Recovery

- **[AMBIGUITY]** Recovery is not yet formalized as machine-readable rebuild instructions.
- **[DECISION]** Recovery manifest schema must be established before large-scale orchestration work.
  (See `RECOVERY_MANIFEST_SCHEMA.json`)

## 11. Agent governance

- **[FACT]** Shared agent contract documents exist in `agent-runtime/shared/agents/`.
- **[INFERENCE]** Agents should remain workers operating against external authority.
- **[DECISION]** Agents may not define canon merely by repeated use; canon must be explicitly blessed.

## 12. Provisional authority artifact set

The following are provisional authority artifacts for this canon seed:

| Artifact | Path |
|----------|------|
| This specification | `warehouse/canon/WAREHOUSE_SPECIFICATION.md` |
| Authority map | `warehouse/canon/WAREHOUSE_AUTHORITY_MAP.json` |
| Lineage schema | `warehouse/canon/LINEAGE_SCHEMA.json` |
| Recovery manifest schema | `warehouse/canon/RECOVERY_MANIFEST_SCHEMA.json` |
| Canonicalization review | `warehouse/canon/WAREHOUSE_CANONICALIZATION_REVIEW.md` |
| Canonization decisions | `warehouse/canon/CANONIZATION_DECISIONS.md` |
| Taxonomy migration plan | `warehouse/canon/TAXONOMY_MIGRATION_PLAN.md` |
| Signal format migration plan | `warehouse/canon/SIGNAL_LANG_MIGRATION_PLAN.md` |
| Deprecation policy | `warehouse/canon/DEPRECATION_POLICY.md` |

These artifacts create a governance floor, not final canon.

## 13. Canonization priorities

The current priority order is:

1. Bless precedence rules (Bruce decision packet)
2. Bless provisional canon artifacts
3. Publish lineage schema
4. Publish recovery manifest schema
5. Resolve taxonomy split
6. Resolve Signal format split
7. Implement parser/compiler enforcement against blessed canon

## 14. Provisional precedence rules

Until superseded by Bruce decision:

| Priority | Rule |
|----------|------|
| 1 | Versioned + schema-backed artifact > unversioned descriptive artifact |
| 2 | Explicit policy matrix > adapter-local convenience docs |
| 3 | Numbered taxonomy > unnumbered taxonomy unless explicitly grandfathered |
| 4 | Explicit accepted decision records > implied practice |
| 5 | Source evidence > reconstructed prose |

## 15. Canon blockers

Current blockers to full canon:

- [ ] Dual taxonomy (numbered vs. legacy)
- [ ] Dual Signal format (YAML-in-Markdown vs. `.signal` front-matter)
- [ ] Missing lineage schema
- [ ] Missing recovery manifest schema
- [ ] Incomplete authority-map formalization
- [ ] Bruce decision packet not yet answered

## 16. Exit criteria for version 1.0

Warehouse canon may move from `candidate/provisional` to `canonical` only when:

- Bruce approves the decision packet
- Authority map is accepted
- Lineage schema is accepted
- Recovery manifest schema is accepted
- One taxonomy is declared authoritative
- One Signal format is declared authoritative
- Migration/deprecation note is published

## 17. Implementation sequencing rule

> Before parser work, memory compiler work, or orchestration expansion:
> canon must be frozen enough to prevent parallel truths.

This is the governing constraint for the current phase.
