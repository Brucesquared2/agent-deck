# Warehouse Canonicalization Review

> **Status:** DRAFT — awaiting Bruce approval on decisions D-01 through D-05.
> **Reviewer:** Copilot Coding Agent (canonicalization pass)
> **Date:** 2026-06-10
> **Task:** Review `agent-runtime/` archaeology outputs and deliver a Bruce Decision Packet.

---

## 1. Source Corpus Available for Review

The following artifacts are present in the current branch and were inspected for this review.

| Artifact | Path | Notes |
|----------|------|-------|
| Memory taxonomy (numbered) | `agent-runtime/shared/memory/00-core/` … `90-archive/` | 8 layers, fully scaffolded |
| Memory taxonomy (legacy) | `agent-runtime/shared/memory/core/` … `signals/` | Parallel, partially populated |
| Authority / write-rules | `agent-runtime/shared/memory/00-core/policies.md` | Layer-by-layer write table |
| North Star | `agent-runtime/shared/memory/00-core/north-star.md` | System purpose and values |
| Signal-Lang spec v1.0 | `agent-runtime/shared/memory/60-signals/signal-lang.md` | YAML-in-Markdown format |
| Signal JSON Schema | `agent-runtime/shared/memory/60-signals/signal-schema.json` | Draft-07, `additionalProperties: false` |
| Legacy signal format | `agent-runtime/shared/memory/signals/README.md` + `*.signal` files | YAML front-matter + Markdown body |
| Decision log (ADRs) | `agent-runtime/shared/memory/50-maps/DECISION_LOG.md` | ADR-001, 002, 003 |
| Memory map (numbered) | `agent-runtime/shared/memory/50-maps/MEMORY_MAP.md` | References numbered zones |
| Memory map (legacy) | `agent-runtime/shared/memory/maps/MEMORY_MAP.md` | References unnumbered zones |
| Agent contracts | `agent-runtime/shared/agents/{planner,implementer,reviewer,pi}.md` | Each contains two prompt templates (one per taxonomy) |
| Runtime adapter READMEs | `agent-runtime/{opencode,aider,pi,agent-deck}/README.md` | Placeholder configs |
| Utility scripts | `agent-runtime/scripts/*.sh` | sync-skills, run-*, memory-* |

**Absent from this branch (not committed):**

| Expected Artifact | Status |
|-------------------|--------|
| `WAREHOUSE_SPECIFICATION.md` | Not found |
| `WAREHOUSE_GAP_ANALYSIS.md` | Not found |
| `WAREHOUSE_AUTHORITY_MAP.json` | Not found |
| `WAREHOUSE_RECOVERY_MANIFEST.json` | Not found |

The review below therefore evaluates the underlying corpus directly. Claims attributed to the archaeology outputs are treated as inferred from the corpus unless a specific source file confirms them.

---

## 2. Claim Verification Matrix

### 2.1 Claims directly supported by source artifacts

| Claim | Source file | Confidence |
|-------|------------|------------|
| Memory taxonomy has 8 numbered layers (00–90) | `agent-runtime/shared/memory/50-maps/MEMORY_MAP.md` | HIGH |
| Authority write-rules exist per layer | `agent-runtime/shared/memory/00-core/policies.md` | HIGH |
| Signal-Lang v1.0 uses YAML-in-Markdown with JSON Schema validation | `agent-runtime/shared/memory/60-signals/signal-lang.md`, `signal-schema.json` | HIGH |
| ADR-001 ratified YAML-in-Markdown as the canonical signal format | `agent-runtime/shared/memory/50-maps/DECISION_LOG.md` | HIGH |
| Four-agent team (Planner, Implementer, Reviewer, PI) is documented | `agent-runtime/shared/agents/*.md`, `00-core/north-star.md` | HIGH |
| Planner is the sole writer of `00-core/` | `agent-runtime/shared/memory/00-core/policies.md` line "Planner only" | HIGH |
| Indexes (`TAG_INDEX.md`, `ENTITY_INDEX.md`) are script-generated (ADR-003) | `agent-runtime/shared/memory/50-maps/DECISION_LOG.md` | HIGH |
| Two parallel memory taxonomies both exist and are active | Directory listing: `00-core/` AND `core/` both present | HIGH |
| Two Signal-Lang formats both exist | `60-signals/signal-lang.md` (YAML-in-Markdown) AND `signals/*.signal` (YAML front-matter files) | HIGH |
| No Signal-Lang parser is implemented | No `.go`, `.py`, or equivalent parser found anywhere in the repo | HIGH |
| Reviewer VRAM gate is opt-in via env var (ADR-002) | `agent-runtime/shared/memory/50-maps/DECISION_LOG.md` | HIGH |

### 2.2 Claims that are inferred (no direct source file)

| Claim | Basis for inference | Risk if wrong |
|-------|--------------------|----|
| Signal-Lang scores 0.52 on authority scale, penalized for zero inbound references | Mentioned in problem statement; no scoring artifact in repo | Medium — score is unverifiable |
| `agent-runtime/` is "Warehouse-adjacent" | Pattern match against memory lattice, authority model, and filesystem taxonomy present in memory system | Low — claim is architectural framing, not a normative assertion |
| conductor `task-log.md` maps to L0 or L2 | No `task-log.md` file found; claim derived from problem statement discussion | High — outcome depends on file format and Bruce intent |
| `sanctuary-runtime/` was a previous experiment | No directory found in repo; referenced only in problem statement | Medium — without the directory, status cannot be confirmed |
| Warehouse recovery manifest item RM-09 is unresolved | Referenced in problem statement; no `RECOVERY_MANIFEST.json` in repo | High — must be an open item for Bruce |
| Lineage is captured only as distributed fields (not first-class schema) | No `lineage-schema.json` found; lineage references exist only as prose in ADRs | Medium — true by absence, but may exist in a non-committed file |

### 2.3 Claims requiring Bruce approval before any agent acts on them

| Claim | Why Bruce must decide |
|-------|----------------------|
| Numbered taxonomy (`00-core/` …) supersedes legacy (`core/` …) | Both are active; agent contracts reference both; choosing the wrong one breaks running agents |
| Versioned YAML-in-Markdown signal format supersedes legacy `.signal` front-matter | ADR-001 ratified YAML-in-Markdown, but `.signal` files were created afterward and are still in use |
| `WAREHOUSE_SPECIFICATION.md` is a candidate canonical seed | File absent from repo; cannot be blessed without existence |
| conductor `task-log.md` is L2 Narrative (not L0 Events) | Affects archival policy, immutability guarantees, and which agents may write to it |
| `sanctuary-runtime/` is experimental and non-normative | Cannot be deprecated without knowing what depends on it |

---

## 3. File Status Assessment

### 3.1 Recommended canonical seed candidates

These files have strong source support, schema backing, or explicit ADR ratification. They are safe to treat as authoritative foundations once Bruce blesses the taxonomy decision (D-01) and signal format decision (D-02).

| File | Rationale |
|------|-----------|
| `agent-runtime/shared/memory/00-core/policies.md` | Explicit write-authority table; Planner-owned; append-only rule enforced |
| `agent-runtime/shared/memory/50-maps/MEMORY_MAP.md` (numbered) | Comprehensive layer overview; references canonical numbered zones |
| `agent-runtime/shared/memory/60-signals/signal-lang.md` | Version-stamped spec; ADR-001 accepted; JSON Schema in same folder |
| `agent-runtime/shared/memory/60-signals/signal-schema.json` | Machine-validatable; `additionalProperties: false`; 5 typed signal variants |
| `agent-runtime/shared/memory/50-maps/DECISION_LOG.md` | Three ADRs committed; ADR-lite format documented; append-only |
| `agent-runtime/shared/memory/00-core/north-star.md` | System purpose and values; Planner-owned |

### 3.2 Files that should remain experimental until decisions are made

| File | Blocker |
|------|---------|
| `agent-runtime/shared/memory/core/IDENTITY.md` | D-01: superseded by numbered taxonomy or retained? |
| `agent-runtime/shared/memory/core/MISSION.md` | D-01: same |
| `agent-runtime/shared/memory/core/PRINCIPLES.md` | D-01: same |
| `agent-runtime/shared/memory/maps/MEMORY_MAP.md` (legacy) | D-01: conflicts with numbered version |
| `agent-runtime/shared/memory/signals/*.signal` | D-02: conflicts with YAML-in-Markdown format |
| `agent-runtime/shared/memory/signals/README.md` | D-02: documents a format that may be deprecated |
| Agent contracts in `shared/agents/*.md` | Both D-01 and D-02: currently embed two prompt templates each, one per taxonomy; must be unified |

### 3.3 First-class missing artifacts (must be created after decisions)

These are referenced or implied by the existing corpus but do not yet exist.

| Artifact | Why needed |
|----------|-----------|
| `lineage-schema.json` | Lineage exists only as prose in ADRs; no machine-readable schema |
| `WAREHOUSE_AUTHORITY_MAP.json` | Authority is described in `policies.md` but not in a queryable map artifact |
| Migration note: numbered ↔ legacy taxonomy | Required before any agent can safely deprecate old paths |
| Signal format migration guide | Explains which existing `.signal` files are legacy and what the new equivalent looks like |

---

## 4. Format Split Analysis

### 4.1 Taxonomy fork

**Evidence (direct inspection):**

`agent-runtime/shared/memory/` contains both:
- `00-core/`, `10-ops/`, `20-projects/`, `30-sessions/`, `40-knowledge/`, `50-maps/`, `60-signals/`, `90-archive/`
- `core/`, `ops/`, `projects/`, `sessions/`, `knowledge/`, `maps/`, `signals/`, `scratch/`

**Impact:**

The `planner.md` agent contract (`agent-runtime/shared/agents/planner.md`) contains two distinct prompt templates — one referencing `memory/core/IDENTITY.md` (legacy) and one referencing `shared/memory/00-core/policies.md` (numbered). A running agent reading this file receives conflicting instructions about where canonical state lives.

**Recommended precedence rule (pending D-01):**

> Numbered zones (`00-core/` …) supersede legacy zones (`core/` …).
> Legacy zones are grandfathered until a migration note and redirect stubs are in place.

### 4.2 Signal format fork

**Evidence (direct inspection):**

- `60-signals/signal-lang.md`: YAML-in-Markdown (`\`\`\`yaml signal` blocks), `version`/`type`/`payload` fields, UTC `timestamp`, schema-validated.
- `signals/README.md` + `signals/*.signal`: Standalone `.signal` files, YAML front-matter, `signal`/`priority`/`date` fields, no schema reference, no `version` field.

**Key difference:** The legacy format uses a flat field model (e.g., `priority: P1`). The versioned format uses a typed payload object (`payload.priority: "high"`). They are not schema-compatible.

**ADR-001 status:** "accepted" for YAML-in-Markdown. However, the `.signal` files were committed after ADR-001 and are still active (referenced in session log `2026-04-29-001`).

**Recommended precedence rule (pending D-02):**

> YAML-in-Markdown (v1.0, schema-backed) is the canonical emission format for new signals.
> Existing `.signal` files are legacy read-only artifacts; no new `.signal` files should be created.

---

## 5. Safest Next Implementation Step

**After Bruce approves D-01 and D-02:**

1. Append two ADRs to `DECISION_LOG.md`:
   - ADR-004: Numbered taxonomy supersedes legacy zones
   - ADR-005: YAML-in-Markdown signal format supersedes `.signal` files
2. Add redirect stubs in legacy zone files (e.g., `core/IDENTITY.md` → "See `00-core/north-star.md`").
3. Unify agent contracts: remove the legacy prompt template from each `shared/agents/*.md` file.
4. Create `lineage-schema.json` stub in `60-signals/` or a new `70-lineage/` zone.
5. Only after the above: begin any Signal-Lang parser implementation.

**Do not do before Bruce approval:**

- Delete or rename any legacy zone file.
- Mark `WAREHOUSE_SPECIFICATION.md` canonical (file is absent from this branch).
- Start a Signal-Lang parser (format is not yet locked).
- Change authority scores in any external scoring artifact.

---

## 6. Bruce Decision Packet

Five decisions are required. Each is a yes/no or forced choice. No implementation will proceed until Bruce records a decision.

---

### D-01 — Taxonomy precedence

**Question:** Do the numbered zones (`00-core/`, `10-ops/`, …) supersede the legacy unnumbered zones (`core/`, `ops/`, …)?

**Evidence:** Both are present and active. The numbered zones are more complete and are referenced by the newer agent contracts. The legacy zones contain the only populated content files (IDENTITY, MISSION, PRINCIPLES).

**Options:**

| Option | Consequence |
|--------|-------------|
| **A — Numbered supersedes legacy** | Legacy zones become deprecated; redirect stubs needed; agent contracts unified |
| **B — Legacy supersedes numbered** | Numbered zones are reverted; all newer spec work is archived |
| **C — Maintain both permanently** | Highest maintenance burden; agent confusion risk remains |

**Recommended:** A.

**Bruce decision:** ☐ A — Numbered supersedes legacy  ☐ B — Legacy supersedes numbered  ☐ C — Maintain both

---

### D-02 — Signal format precedence

**Question:** Does the YAML-in-Markdown format (`60-signals/signal-lang.md`) supersede the legacy `.signal` front-matter format?

**Evidence:** ADR-001 ratified YAML-in-Markdown. `.signal` files exist but use an incompatible schema. No parser exists for either format.

**Options:**

| Option | Consequence |
|--------|-------------|
| **A — YAML-in-Markdown is canonical** | `.signal` files become legacy read-only; ADR-001 is honored |
| **B — `.signal` format is canonical** | ADR-001 is superseded; signal-lang.md and signal-schema.json are archived |
| **C — Define a single merged format** | Requires new ADR and new schema; delays parser work further |

**Recommended:** A — ADR-001 should be honored as accepted.

**Bruce decision:** ☐ A — YAML-in-Markdown canonical  ☐ B — `.signal` format canonical  ☐ C — Merged format (new ADR needed)

---

### D-03 — RM-09: conductor task-log.md classification

**Question:** Does conductor `task-log.md` map to L0 (Events: immutable, schema-valid, timestamped) or L2 (Narrative: human-readable operational prose)?

**Context:** No `task-log.md` file was found in this branch. The classification determines: who may write it, whether entries are append-only, and whether a schema is required.

**Options:**

| Option | Consequence |
|--------|-------------|
| **L0 — Events** | Must be schema-valid, timestamped, immutable; only structured signal emission allowed |
| **L2 — Narrative** | Human-readable prose is acceptable; any agent may append; no schema required |

**Recommended:** L2 unless entries carry machine-parseable event payloads (in which case emit a signal alongside the prose).

**Bruce decision:** ☐ L0 — Events  ☐ L2 — Narrative

---

### D-04 — WAREHOUSE_SPECIFICATION.md candidate status

**Question:** Should `WAREHOUSE_SPECIFICATION.md` be blessed as a candidate canonical seed (once it is committed to this branch)?

**Context:** The file is not present in the current branch. It was described in the problem statement as a "candidate reconstructed specification" with authority score below the canonical threshold. It cannot be blessed until it exists.

**Pre-condition:** File must be committed before this decision can be executed.

**Options:**

| Option | Consequence |
|--------|-------------|
| **A — Bless as candidate seed** | File receives `status: CANDIDATE` tag; agents may cite it; human review required before promotion to canonical |
| **B — Treat as experimental only** | File is not cited by agents until a separate canonicalization pass |
| **C — Block until missing artifacts exist** | Defer until `lineage-schema.json` and `WAREHOUSE_AUTHORITY_MAP.json` are created |

**Bruce decision:** ☐ A — Candidate seed  ☐ B — Experimental  ☐ C — Block pending missing artifacts

---

### D-05 — sanctuary-runtime/ disposition

**Question:** Is `sanctuary-runtime/` a permanent part of the system or a deprecated experiment?

**Context:** The directory is not present in this branch. Referenced in the problem statement as an unresolved item. Without the directory, its status cannot be determined from the corpus.

**Options:**

| Option | Consequence |
|--------|-------------|
| **A — Permanent, referenced by active workflows** | Must be documented, added to INDEX.md, and integrated with sync scripts |
| **B — Deprecated experiment** | Add a note to `90-archive/` and remove any references from active workflows |
| **C — Unknown — defer** | Leave unresolved until the directory or a reference to it appears in the active branch |

**Bruce decision:** ☐ A — Permanent  ☐ B — Deprecated  ☐ C — Defer

---

## 7. Summary

| Category | Count | Notes |
|----------|-------|-------|
| Claims directly supported | 11 | All traceable to specific file + line |
| Claims inferred | 6 | Require corroboration or are from absent files |
| Claims requiring Bruce approval | 5 | See decision packet above |
| Recommended canonical seed candidates | 6 | See §3.1 |
| Files to remain experimental | 7 | See §3.2 |
| First-class missing artifacts | 4 | Must be created post-decision |
| Decisions required before implementation | 5 (D-01–D-05) | |

The strongest current canonicalization candidate is the numbered memory taxonomy backed by `00-core/policies.md`, `50-maps/MEMORY_MAP.md`, and `60-signals/signal-lang.md`. These three files together define authority, navigation, and interchange format — they are the foundation on which everything else depends.

No agent should modify those files, attempt to implement a Signal-Lang parser, or merge the two taxonomies until D-01 and D-02 are recorded.
