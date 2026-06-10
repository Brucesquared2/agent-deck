---
status: candidate
version: 0.1
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

| ID  | Axiom |
|-----|-------|
| A1  | Events are immutable. |
| A2  | State is derived. |
| A3  | Narrative explains state. |
| A4  | Lineage must be preserved. |
| A5  | Authority must be explicit and singular. |
| A6  | Reflections are not authority. |
| A7  | Recovery must be deterministic. |
| A8  | Agents consume authority but do not create authority. |
| A9  | Canon supersedes convenience. |

These axioms remain **candidate** until explicitly blessed.

## 4. Layered model

The current layer stack is:

| Layer | Name      | Description |
|-------|-----------|-------------|
| L0    | Events    | Immutable event facts |
| L1    | State     | Materialized current truth |
| L2    | Narrative | Human-readable interpretation |
| L3    | Lineage   | Provenance and transformation tracking |
| L4    | Semantic  | Linked meaning and retrieval structure |
| L5    | Symbolic  | Formal abstraction, Signal-Lang, graphable structures |
| L6    | Compiled  | Derived machine-oriented artifacts |
| L7    | Retention | Preservation, decay, archival, pruning policy |

### 4.1 Layer confidence

- **[FACT]** L2 and parts of L3/L5 are strongly evidenced by recovered docs.
- **[INFERENCE]** The full L0–L7 stack is the best current architecture synthesis.
- **[AMBIGUITY]** Some layers are explicit, some inferred, and some still aspirational.

## 5. Canonical runtime split

The Warehouse runtime candidate model is split into:

- **shared canon**
  - agents
  - skills
  - memory
  - mcp
- **execution adapters**
  - opencode
  - aider
  - pi
  - agent-deck

**[INFERENCE]** This split is the beginning of a Warehouse Runtime ABI.

## 6. Authority model

### 6.1 Authority rules

- **[FACT]** Authority is singular per artifact family.
- **[FACT]** Non-authoritative scans, reflections, mirrors, and generated copies are not truth.
- **[FACT]** Layer-specific write control exists in current recovered policy documents.
- **[INFERENCE]** Authority must become machine-readable, not just described in prose.

### 6.2 Current candidate authority sources

The strongest current candidates are:

| Artifact | Authority path |
|----------|----------------|
| Write authority and governance rules | `00-core/policies.md` |
| Numbered memory taxonomy | `50-maps/MEMORY_MAP.md` |
| Versioned Signal-Lang spec | `60-signals/signal-lang.md` |
| Signal/event payload validation | `60-signals/signal-schema.json` |
| Behavioral boundaries | shared agent contracts |

## 7. Memory system

### 7.1 Memory classes

The memory system distinguishes:

- events
- state
- narrative
- lineage
- semantic links
- symbolic structures
- compiled artifacts
- retention policy objects

### 7.2 Memory hierarchy

The strongest current candidate hierarchy is the numbered taxonomy:

| Prefix | Domain |
|--------|--------|
| `00-core` | Policies, governance, foundational rules |
| `10-ops` | Operational state and runbooks |
| `20-projects` | Project-level knowledge |
| `30-sessions` | Session logs and state |
| `40-knowledge` | General knowledge base |
| `50-maps` | Memory maps and taxonomies |
| `60-signals` | Signal-Lang spec and schemas |
| `90-archive` | Archived and deprecated material |

### 7.3 Current ambiguity

- **[AMBIGUITY]** The numbered tree and the legacy unnumbered tree both remain in active reference.
- **[DECISION]** One taxonomy must become canonical and the other must be mapped, deprecated, or grandfathered.

## 8. Signal-Lang role

### 8.1 Current state

- **[FACT]** A versioned Signal-Lang spec and JSON schema exist.
- **[FACT]** The current spec emphasizes deterministic parsing and rejects reflection/dynamic field discovery.
- **[AMBIGUITY]** A legacy `.signal` front-matter format also exists.
- **[DECISION]** One Signal format must be named authoritative.

### 8.2 Architectural role

**[INFERENCE]** Signal-Lang belongs in the symbolic/control plane of the Warehouse, but it is not yet
sufficiently connected to active lineage to be treated as fully central canon.

## 9. Lineage model

### 9.1 Current state

- **[FACT]** Lineage-bearing fields exist in session templates, decision logs, and signal artifacts.
- **[FACT]** There is no blessed standalone lineage schema.
- **[INFERENCE]** The current practical lineage graph can be reconstructed from IDs, timestamps,
  session references, supersession links, and referenced artifact paths.

### 9.2 Canon requirement

- **[DECISION]** The Warehouse must define a first-class lineage schema.
- **[DECISION]** No artifact family should become final canon without provenance and lineage fields.

## 10. Reflection and recovery

### 10.1 Reflection

- **[FACT]** Reflection-like duplication patterns exist.
- **[INFERENCE]** Reflection should mean recoverable mirrors, not truth copies.

### 10.2 Recovery

- **[AMBIGUITY]** Recovery is not yet formalized as machine-readable rebuild instructions.
- **[DECISION]** Recovery manifest schema must be established before large-scale orchestration work.

## 11. Agent governance

- **[FACT]** Shared agent contract documents exist.
- **[INFERENCE]** Agents should remain workers operating against external authority.
- **[DECISION]** Agents may not define canon merely by repeated use; canon must be explicitly blessed.

## 12. Provisional canon artifacts

The following are the provisional authority artifacts for this canon set:

| Artifact | Role |
|----------|------|
| `WAREHOUSE_SPECIFICATION.md` | Root candidate specification |
| `WAREHOUSE_AUTHORITY_MAP.json` | Governance registry |
| `LINEAGE_SCHEMA.json` | Lineage contract |
| `RECOVERY_MANIFEST_SCHEMA.json` | Recovery contract |

These artifacts are intended to create a governance floor, not final canon.

## 13. Canonization priorities

The current priority order is:

1. Bless precedence rules
2. Bless provisional canon artifacts
3. Publish lineage schema
4. Publish recovery manifest schema
5. Resolve taxonomy split
6. Resolve Signal format split
7. Implement parser/compiler enforcement against blessed canon

## 14. Provisional precedence rules

Until superseded, apply:

1. versioned + schema-backed artifact > unversioned descriptive artifact
2. explicit policy matrix > adapter-local convenience docs
3. numbered taxonomy > unnumbered taxonomy unless explicitly grandfathered
4. explicit accepted decision records > implied practice
5. source evidence > reconstructed prose

## 15. Canon blockers

Current blockers to full canon:

- dual taxonomy (numbered vs. unnumbered)
- dual Signal format (versioned spec vs. legacy `.signal`)
- missing lineage schema
- missing recovery manifest schema
- incomplete authority-map formalization
- incomplete blessing of candidate specification

## 16. Exit criteria for version 1.0

Warehouse canon may move from `candidate/provisional` to `canonical` only when:

- [ ] Bruce approves the decision packet
- [ ] authority map is accepted
- [ ] lineage schema is accepted
- [ ] recovery manifest schema is accepted
- [ ] one taxonomy is declared authoritative
- [ ] one Signal format is declared authoritative
- [ ] migration/deprecation note is published

## 17. Implementation sequencing rule

> Before parser work, memory compiler work, or orchestration expansion,
> canon must be frozen enough to prevent parallel truths.

This is the governing constraint for the current phase.
