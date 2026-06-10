# WAREHOUSE_SPECIFICATION

> Status: **seed-authority candidate — chat-derived**
> Provenance: recovered from corpus archaeology of `Brucesquared2/agent-deck` (911 files, 547 Go, 69 Markdown, 68 TypeScript).
> Every claim is traced to one or more source artifacts.
> Classification: `recovered-fact` | `high-confidence-inference` | `unresolved-ambiguity`

---

## 1. Identity

The AI Warehouse is:

- A **memory-centric operating substrate** — files are its primary state medium.
- A **canonical authority store** — truth about sessions, configurations, and agents is governed by explicit authority rules, not recency or count.
- A **lineage-preserving computation compound** — all derived objects trace to a documented source chain.
- A **reconstruction-capable knowledge system** — any node can be rebuilt from the authority store and its reflection manifest.

The AI Warehouse is **not**:

- Just infrastructure (hardware and network topology are substrate, not identity).
- Just storage (it maintains provenance, not just bits).
- Just agents (agents are workers; the Warehouse is the environment they operate within).
- Just orchestration (orchestration is one layer; the Warehouse spans L0–L7).
- Just notes (every artifact either governs behavior or is labeled archival).

*Source: problem-statement seed `WAREHOUSE_RECONSTRUCTION_CHAT_DERIVED.md`, `sanctuary-runtime/README.md`.*

---

## 2. Core Axioms

| # | Axiom |
|---|-------|
| A1 | Files are memory. |
| A2 | Memory is state. |
| A3 | State is architecture. |
| A4 | Architecture is executable. |
| A5 | Authority is singular per artifact family. |
| A6 | Lineage is mandatory — undocumented origin = suspect. |
| A7 | Agents are workers, not truth. |
| A8 | Reflections are recovery instruments, not backups. |
| A9 | Narrative and payload are two views of one object. |

*Source: problem-statement seed.*

---

## 3. System Layers

| Layer | ID | Mutability | Description |
|-------|----|-----------|-------------|
| Events | L0 | Immutable | Source facts; append-only records of what occurred. |
| State | L1 | Materialized, disposable | Derived from events; can be rebuilt from L0. |
| Narrative | L2 | Explanatory | Human-readable prose explaining state transitions. |
| Lineage | L3 | Mandatory traceability | Every L2/L4+ object must carry provenance to an L0/L1 source. |
| Semantic | L4 | Meaning linkage | Tags, entities, concept references across artifacts. |
| Symbolic | L5 | Abstract formal representation | Signal-Lang expressions; normalized canonical objects. |
| Compiled | L6 | Machine-optimized derivative | Pre-parsed indexes, schemas, binary manifests. |
| Retention | L7 | Survival policy | Governs what is kept, promoted, archived, or expired. |

*Source: problem-statement seed; corroborated by `internal/statedb/statedb.go` (event rows → state), `cmd/agent-deck/main.go` retention cleanup on startup.*

---

## 4. Authority Model

### 4.1 Copy Types

| Type | Role | Description |
|------|------|-------------|
| Canonical copy | Single truth | The one file whose content governs behavior. Must be explicitly blessed. |
| Reflection copy | Recovery instrument | Structurally identical to canonical; maintained at another node for rebuild. |
| Archive copy | Historical record | Immutable snapshot; not used for active decisions. |

### 4.2 Truth Rules

1. A canonical copy supersedes all other copies for its artifact family.
2. Reflections must be kept byte-for-byte in sync with canonical; divergence = conflict requiring reconciliation.
3. Archives must be stamped with `archived_at`, `archived_from`, and reason.
4. Human operator is the final arbiter of ambiguous canon.
5. Disk scans are **non-authoritative** for identity binding. The stored ID in the authority file is authoritative.

*Source: `docs/session-id-lifecycle.md` lines 1–10, 54–57 ("sole authoritative source"; "non-authoritative"); `documentation/SKILLS.md` ("canonical orchestration skill"); `docs/PER-GROUP-CLAUDE-CONFIG-SPEC.md` ("canonical plugin-cache path").*

### 4.3 Observed Reflection Pattern in Corpus

The only confirmed duplicate family in the corpus:

```
assets/watcher-templates/CLAUDE.md
internal/watcher/assets/watcher-templates/CLAUDE.md     ← reflection

assets/watcher-templates/LEARNINGS.md
internal/watcher/assets/watcher-templates/LEARNINGS.md  ← reflection

assets/watcher-templates/POLICY.md
internal/watcher/assets/watcher-templates/POLICY.md     ← reflection
```

`assets/watcher-templates/` = canonical copy (repo root exposure).
`internal/watcher/assets/watcher-templates/` = reflection copy (Go `//go:embed` target for binary distribution).

This is a **compile-time reflection** — the binary embeds the reflection; the canonical lives in the repo root.

*Source: `cmd/agent-deck/watcher_cmd_skills.go` line 12 ("The canonical source also lives at docs/skills/watcher-creator/").*

---

## 5. Object Model

| Object | Description | Authority Home |
|--------|-------------|----------------|
| Event | L0 immutable fact (session created, watcher triggered, etc.) | `internal/statedb/statedb.go` schema |
| State | L1 materialized view (session status, watcher health) | `internal/session/storage*.go` |
| Memory artifact | An `.md` file in the memory taxonomy | `sanctuary-runtime/agent-runtime/shared/memory/` |
| Narrative artifact | Human-prose spec, RFC, or design doc | `docs/`, `documentation/` |
| Schema | Machine-readable constraint definition (JSON Schema) | `sanctuary-runtime/agent-runtime/shared/memory/60-signals/signal-schema.json` |
| Manifest | Deployment/rebuild declaration | `internal/web/static/manifest.webmanifest`; `internal/releasetests/manifest_test.go` |
| Agent artifact | Agent role definition (planner, reviewer, etc.) | `sanctuary-runtime/agent-runtime/shared/agents/` |
| Compiled artifact | Pre-built binary, index, or JSONL cache | `~/.claude/projects/<hash>/*.jsonl` |

---

## 6. Signal-Lang Role

### 6.1 Summary

Signal-Lang is a **YAML-in-Markdown** message format for inter-agent handoffs, constraints, and status reporting. It is the canonical normalization gateway for the Sanctuary layer.

### 6.2 Required Fields

| Field | Type | Description |
|-------|------|-------------|
| `signal` | enum | Signal type identifier |
| `id` | string | Unique signal ID (`<type>-<YYYYMMDD>-<NNN>`) |
| `lane` | enum | Execution lane: `planner`, `implementer`, `reviewer`, `pi`, `ops` |
| `from` | string | Emitting agent or role |
| `to` | string | Target agent, role, or `broadcast` |

### 6.3 Signal Types

`task.plan`, `task.progress`, `task.handoff`, `review.findings`, `research.findings`

### 6.4 Role in the Warehouse Pipeline

```
raw artifacts
  → archaeology pipeline
  → Signal-aware parser / extractors
  → normalized canonical objects
  → lineage reconciliation
  → authority scoring
  → Warehouse specification
  → manifests / schemas / indexes
```

The parser is part of **recovery, validation, and canon formation** — not just delivery.

*Source: `sanctuary-runtime/agent-runtime/shared/memory/60-signals/signal-lang.md`, `signal-schema.json`.*

---

## 7. Memory Lattice

### 7.1 Taxonomy (numbered for stable ordering)

| Dir | Tier | Contents |
|-----|------|----------|
| `00-core/` | Core | Axioms, identity, governing rules |
| `10-ops/` | Ops | Runbooks, system health, incident log |
| `20-projects/` | Projects | Per-repo task stacks, decision logs |
| `30-sessions/` | Sessions | Per-agent-session handoff notes, summaries |
| `40-knowledge/` | Knowledge | Research findings, reference material |
| `50-maps/` | Maps | Indexes, memory maps, entity/tag indexes |
| `60-signals/` | Signals | Signal-Lang spec, schema, examples |
| `90-archive/` | Archive | Expired or superseded artifacts |

### 7.2 Promotion Rules

- `30-sessions/` → compress to `20-projects/` after session close.
- `20-projects/` → compile to `40-knowledge/` when project is complete.
- `40-knowledge/` → archive to `90-archive/` after retention window.
- `50-maps/` are always rebuilt from live content; never promoted (they are L6 compiled artifacts).
- `60-signals/` are ephemeral after consumption; archive if historically significant.

### 7.3 Retention

`[recovered-fact]` Agent-deck has configurable log retention: `debug_retention_days` in `[logs]` config block; `CleanupStorage` runs at startup.

*Source: `CHANGELOG.md` v1.7.x log rotation section; `cmd/agent-deck/main.go` line 678 retention call; `sanctuary-runtime/agent-runtime/shared/memory/50-maps/MEMORY_MAP.md`.*

---

## 8. Filesystem Canon

### 8.1 Repository Root Layout

```
agent-deck/
  cmd/                     Go CLI entrypoints
  internal/                Go packages (session, ui, watcher, tmux, statedb, feedback, web)
  conductor/               Conductor orchestrator scripts + bridge.py
  documentation/           Feature-level user docs (CONDUCTOR.md, WATCHERS.md, SKILLS.md, WATCHDOG.md)
  docs/                    Spec-level authority docs (SESSION-PERSISTENCE-SPEC.md, etc.)
  scripts/                 Operational shell scripts (verify-*, watchdog/)
  skills/                  Embedded Claude Code skills (agent-deck skill, session-share)
  tests/                   Go unit + e2e + eval tests
  assets/                  Embedded assets (watcher-templates canonical copies)
  sanctuary-runtime/       [NEW] Memory-first runtime scaffold (see §8.2)
  .claude/plans/           Session-scoped planning docs (NOT authority — session-local only)
  CLAUDE.md                Contributor hard rules (highest authority)
  CHANGELOG.md             Authoritative version history
  README.md                User-facing overview
```

### 8.2 Sanctuary-Runtime Layout

```
sanctuary-runtime/
  README.md                Architecture overview
  agent-runtime/
    shared/
      agents/              Role definitions (planner, implementer, reviewer, pi)
      skills/              Skill templates
      memory/              Full L0–L7 taxonomy (00-core … 90-archive)
    opencode/              OpenCode adapter placeholder
    aider/                 Aider adapter placeholder
    pi/                    Pi adapter placeholder
    scripts/               Lifecycle scripts (sync-skills, new-session, etc.)
  telemetry/               DCGM + Prometheus telemetry layer
  bridge/                  Platform bridges (PowerShell, Termux)
  warehouse/
    recovery/              [THIS DIR] Archaeology output documents
```

### 8.3 Naming Rules

- Spec files: `SCREAMING_SNAKE_CASE.md` (e.g., `SESSION-PERSISTENCE-SPEC.md`)
- Role/feature docs: `TITLE_CASE.md` (e.g., `CONDUCTOR.md`, `WATCHERS.md`)
- Memory tier READMEs: `README.md` in numbered dir
- Index files: `INDEX.md`, `MEMORY_MAP.md`, `TAG_INDEX.md`, `ENTITY_INDEX.md`, `DECISION_LOG.md`
- Signal IDs: `<type>-<YYYYMMDD>-<NNN>`

*Source: `documentation/CONDUCTOR.md`, `docs/SESSION-PERSISTENCE-SPEC.md`, `sanctuary-runtime/agent-runtime/shared/memory/50-maps/`.*

---

## 9. Lineage Model

### 9.1 Provenance

Every authority document must carry:
- `provenance` — how it was created (authored, generated, recovered, compiled)
- `source_artifacts` — list of input files used in synthesis
- `derived_from` — parent document if derivative

### 9.2 Derivation Rules

1. A document that re-packages another without adding new facts is a **reflection**, not a new authority.
2. A document that synthesizes multiple sources becomes a **compiled artifact** and must list all sources.
3. A generated document that is not verified by a human carries confidence `unverified` until blessed.

### 9.3 Authority Inheritance

Forked documents inherit parent lineage up to the fork point, then diverge. Conflicts between forks must be reconciled before either can be canonical.

*Source: `CHANGELOG.md` #745 fork-session fix (lineage of Claude session IDs through fork); `docs/session-id-lifecycle.md`.*

---

## 10. Reflection Model

### 10.1 Node Rebuild Rules

A node is considered fully rebuilt when:
1. All reflection copies are verified against canonical hashes.
2. The authority store (canonical copies) is intact.
3. All compiled artifacts (indexes, schemas) are regenerated from canonical sources.
4. Agent role files and skill templates are present and hash-matched.

### 10.2 Recovery Scope

| Priority | Artifact Family | Recovery Method |
|----------|----------------|----------------|
| P0 | `CLAUDE.md` contributor rules | Copy from canonical; no synthesis |
| P0 | `docs/*-SPEC.md` specs | Copy from canonical; do not regenerate |
| P1 | Session storage schemas | Rebuild from Go struct definitions |
| P1 | Memory taxonomy (00–90) | Rebuild from `MEMORY_MAP.md` |
| P2 | Watcher templates | Rebuild from `assets/watcher-templates/` canonical |
| P3 | `.claude/plans/` files | Not recovered — session-local, not authority |

### 10.3 Reflection Manifest Format (proposed)

```json
{
  "canonical_path": "assets/watcher-templates/CLAUDE.md",
  "reflections": [
    {
      "path": "internal/watcher/assets/watcher-templates/CLAUDE.md",
      "purpose": "go-embed compile-time reflection",
      "sync_method": "exact copy",
      "verified_at": null
    }
  ]
}
```

*Source: `cmd/agent-deck/watcher_cmd_skills.go` line 12; duplicate hash analysis.*

---

## 11. Agent Contract Model

### 11.1 Agents as Workers

Agents are workers, not truth. Their outputs are `unverified` until validated against a canonical source or blessed by a human operator.

### 11.2 Known Agent Roles

| Role | Adapter | Strengths |
|------|---------|-----------|
| Planner | OpenCode | Multi-file architectural planning, task decomposition |
| Implementer | OpenCode / Aider | Code execution; Aider for surgical edits |
| Reviewer | Aider / agent-deck | Code review, VRAM gate enforcement |
| PI (Principal Investigator) | Pi | Research, experimental inquiry |
| Conductor | Claude Code | Supervises child sessions; delegates; does not code |

### 11.3 Permissions Model

- Agents emit signals; they do not write directly to the authority store.
- Only the Conductor can promote a session artifact to `20-projects/`.
- Only a human operator can bless a document as `canonical`.

### 11.4 Event Obligations

Every agent session MUST:
1. Emit a `task.plan` signal at start.
2. Emit `task.progress` at each milestone.
3. Emit `task.handoff` at end, referencing the next agent or `broadcast`.

*Source: `sanctuary-runtime/agent-runtime/shared/agents/planner.md`, `implementer.md`, `reviewer.md`, `pi.md`; `documentation/CONDUCTOR.md`.*

---

## 12. Runtime Model

### 12.1 Events → State

Agent-deck persists session state via `internal/session/storage*.go`. Each `Instance` carries a `ClaudeSessionID` (or equivalent for other runtimes). State is materialized from stored JSON; events are the JSONL conversation logs.

### 12.2 Memory → Action

The Conductor reads `task-log.md` (append-only event log) and `state.json` (health snapshot) to determine routing and escalation. It does not read raw session JSONL — it operates on L1/L2.

### 12.3 Compiled Artifact Generation

Scripts in `sanctuary-runtime/agent-runtime/scripts/` govern the compilation cycle:
- `refresh-indexes.sh` — rebuilds `50-maps/` L6 indexes from live memory content.
- `sync-skills.sh` — copies `shared/skills/` to adapter directories.
- `summarize-session.sh` — compresses `30-sessions/` entry to `20-projects/`.

*Source: `documentation/CONDUCTOR.md`; `internal/watcher/testdata/`; `sanctuary-runtime/agent-runtime/scripts/`.*

---

## 13. Recovery and Reconstruction

### 13.1 Dead Node Restore

1. Clone the repo (canonical store).
2. Run `bash scripts/verify-session-persistence.sh` (confirms session storage layer).
3. Run `bash sanctuary-runtime/agent-runtime/scripts/refresh-indexes.sh` (rebuild L6 indexes).
4. Restore watcher reflection copies: `cp assets/watcher-templates/* internal/watcher/assets/watcher-templates/`.
5. Confirm `CLAUDE.md` is intact (contributor rules gate all further operations).

### 13.2 Authority Re-establishment

1. Enumerate all `*-SPEC.md` files — these are P0 authority candidates.
2. Verify `CHANGELOG.md` is present and continuous (authoritative version history).
3. Verify `docs/session-id-lifecycle.md` is present (authoritative identity rules).
4. Regenerate `50-maps/INDEX.md` from file scan.

### 13.3 Canon Verification

Run `go test ./internal/releasetests/...` — this verifies the release manifest (compiled artifact).

*Source: `internal/releasetests/manifest_test.go`; `CLAUDE.md` test mandates; `docs/SESSION-PERSISTENCE-SPEC.md`.*

---

## 14. Risk Model

| Risk | Type | Severity | Mitigation |
|------|------|----------|-----------|
| Authority drift | Two copies of same artifact diverge silently | High | Hash-verified reflection checks in CI |
| Fragmentation | Spec knowledge spread across `.claude/plans/` session files (non-authority) | Medium | Promote critical decisions to `docs/` immediately |
| Duplicate repos | `assets/` vs `internal/watcher/assets/` reflection pattern multiplies | Low | Compile-time reflection is intentional; document clearly |
| Schema divergence | `signal-schema.json` and `signal-lang.md` drift | Medium | Schema validates `examples.md` on every PR |
| Lineage loss | Chat-derived docs have no traceable source chain | High | Tag all chat-derived docs with `provenance: chat-derived` |
| Stale `.claude/plans/` | Session-local planning docs mistaken for authority | Medium | `DECISIONS.md` and `SESSION-HANDOFF.md` are session-local, not canonical |
| Go version skew | Go 1.25 breaks macOS TUI | High | `GOTOOLCHAIN=go1.24.0` pinned; enforced in `CLAUDE.md` |
| Test gate bypass | Source commit with `--no-verify` | High | `CLAUDE.md` explicitly forbids on source-modifying commits |

---

## 15. Open Questions

| # | Question | Evidence | Status |
|---|----------|----------|--------|
| Q1 | What is the full grammar of Signal-Lang? The current `signal-lang.md` is the initial spec but has not been battle-tested. | `sanctuary-runtime/agent-runtime/shared/memory/60-signals/signal-lang.md` | **Unresolved** — needs parser implementation |
| Q2 | Should the memory lattice have numeric weights? The problem statement suggests `0.25*canonical_claim + …` but no implementation exists. | Problem-statement seed | **Unresolved** — authority scoring formula is proposed, not implemented |
| Q3 | What is the exact L6 compiled format for memory indexes? `refresh-indexes.sh` is a stub. | `sanctuary-runtime/agent-runtime/scripts/refresh-indexes.sh` | **Unresolved** |
| Q4 | Is `sanctuary-runtime/` a permanent namespace or a bootstrap scaffold? | `sanctuary-runtime/README.md` | **Unresolved** — should be clarified by human operator |
| Q5 | How should conductor `task-log.md` entries be normalized to Signal-Lang? | `documentation/CONDUCTOR.md` | **Unresolved** |
| Q6 | Vagrant Mode design exists (`.claude/plans/DECISIONS.md`) but no PR — should it be promoted to `docs/`? | `.claude/plans/2026-02-14-vagrant-mode-design.md` | **Unresolved** |

---

## 16. Canonical Appendices

### A. Glossary

| Term | Definition |
|------|-----------|
| Canonical copy | The single blessed source of truth for an artifact family. |
| Reflection copy | A byte-identical copy maintained at another node for rebuild. |
| Archive copy | An immutable historical snapshot; not used for active decisions. |
| Signal | A YAML-in-Markdown inter-agent message conforming to Signal-Lang. |
| Lane | The execution channel a signal is addressed to (planner/implementer/reviewer/pi/ops). |
| Conductor | The long-lived Claude Code session that supervises child sessions. |
| Watcher | An event-driven monitoring agent (GitHub/Gmail/calendar/cron adapters). |
| VRAM gate | A Prometheus-based gate that blocks teleport when GPU memory exceeds 80%. |
| Authority score | A weighted sum scoring a document's claim to be canonical. |
| Teleport | Moving a model/session from one node to another (VRAM-gated). |

### B. Key Schemas

- Signal-Lang schema: `sanctuary-runtime/agent-runtime/shared/memory/60-signals/signal-schema.json`
- Watcher state schema: `internal/watcher/` (Go structs; no standalone JSON Schema yet)
- Session storage schema: `internal/session/storage*.go` (Go structs)
- Web manifest: `internal/web/static/manifest.webmanifest`

### C. Authority Score Formula

For each candidate artifact:

```
authority_score =
  0.25 * explicit_canonical_claim   # "canonical", "authoritative", "SPEC" in name/content
  0.20 * lineage_depth              # how many referenced sources exist
  0.15 * inbound_reference_density  # how many other files reference this one
  0.15 * schema_consistency         # whether it conforms to a known schema
  0.10 * parser_alignment           # whether Signal-Lang or JSON Schema validates it
  0.10 * recency                    # normalized to repo history
  0.05 * duplication_stability      # reflection copies are stable, not divergent
```

*Source: problem-statement seed.*

### D. Provenance of This Document

- Primary source: problem-statement seed (chat-derived reconstruction, 2026-06-10)
- Corpus analyzed: 911 files in `Brucesquared2/agent-deck`
- Key authority artifacts consumed:
  - `CLAUDE.md` (contributor rules)
  - `docs/SESSION-PERSISTENCE-SPEC.md`
  - `docs/session-id-lifecycle.md`
  - `docs/PER-GROUP-CLAUDE-CONFIG-SPEC.md`
  - `documentation/CONDUCTOR.md`
  - `documentation/WATCHERS.md`
  - `documentation/SKILLS.md`
  - `sanctuary-runtime/README.md` and all sub-files
  - `CHANGELOG.md`
  - `.claude/plans/DECISIONS.md`, `SESSION-HANDOFF.md`
  - Duplicate hash analysis (3 reflection families found)
- Classification: `high-confidence-inference` — synthesized from corpus; not yet human-blessed as canonical
