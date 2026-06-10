# WAREHOUSE_GAP_ANALYSIS

> Status: **archaeology output — draft**
> Produced by: Warehouse Archaeology Agent, 2026-06-10
> Scope: `Brucesquared2/agent-deck` corpus (911 files)
> Reference: `WAREHOUSE_SPECIFICATION.md` §15 Open Questions

---

## Summary

The corpus is **specification-rich at the session-management layer** and **specification-absent at the Warehouse / memory-lattice layer**. The sanctuary-runtime scaffold fills many structural gaps but is entirely chat-derived and not yet battle-tested.

Overall confidence in canonical coverage:

| Domain | Coverage | Confidence |
|--------|----------|------------|
| Session persistence | ✅ Full spec | High |
| Per-group config | ✅ Full spec | High |
| Conductor / Watcher | ✅ User docs + some spec | Medium-High |
| Session ID lifecycle | ✅ Spec + enforced in code | High |
| Signal-Lang grammar | 🟡 Initial spec only | Medium (chat-derived) |
| Memory lattice / taxonomy | 🟡 Structure exists, no enforcement | Medium (chat-derived) |
| Authority / lineage model | 🔴 Conceptual only | Low |
| VRAM telemetry | 🟡 Docker+Prometheus configs | Medium (untested) |
| Warehouse spec itself | 🔴 Does not exist prior to this doc | Low |

---

## Gap Inventory

### CRITICAL — Must Recover First

#### G-01: No authoritative Signal-Lang parser exists

**What exists:** `sanctuary-runtime/agent-runtime/shared/memory/60-signals/signal-lang.md` (spec), `signal-schema.json` (JSON Schema draft-07), `examples.md` (sample signals).

**What is missing:**
- No parser implementation in any language.
- No test suite for the schema.
- No CLI tool to validate a signal file.
- No integration with agent-deck's Go codebase.

**Impact:** Signal-Lang cannot serve as the canonical normalization gateway without a parser. Every inter-agent handoff is manual and unvalidated.

**Recovery action:** See `WAREHOUSE_RECOVERY_MANIFEST.json` item RM-01.

---

#### G-02: No lineage tracking system

**What exists:** Lineage is described conceptually in `WAREHOUSE_SPECIFICATION.md` §9 and the problem-statement seed.

**What is missing:**
- No `lineage.json` or `provenance.json` schema.
- No tooling to record `derived_from`, `source_artifacts`, or `transform_history`.
- No code in the Go codebase that tracks artifact provenance.
- `.claude/plans/DECISIONS.md` has good decision records but is session-local (not promoted to `docs/`).

**Impact:** Reconstruction after node loss cannot verify which copy is canonical.

**Recovery action:** See `WAREHOUSE_RECOVERY_MANIFEST.json` item RM-02.

---

#### G-03: No authority scoring implementation

**What exists:** The authority score formula in `WAREHOUSE_SPECIFICATION.md` §C (Appendix C) and the problem-statement seed.

**What is missing:**
- No script or program that computes `authority_score` for a set of candidate files.
- No threshold rules ("score > X = canonical candidate").
- No human review workflow.

**Impact:** Archaeology is manual and non-deterministic.

**Recovery action:** See `WAREHOUSE_RECOVERY_MANIFEST.json` item RM-03.

---

#### G-04: Memory lattice has no enforcement

**What exists:** The `sanctuary-runtime/agent-runtime/shared/memory/` taxonomy directories with `README.md` files explaining purpose.

**What is missing:**
- No lint rule or CI check enforcing naming conventions.
- No script that validates artifacts are in the correct tier.
- No automated promotion pipeline (`30-sessions/` → `20-projects/` → `40-knowledge/`).
- `refresh-indexes.sh` is a stub (creates placeholder only).

**Impact:** The taxonomy becomes a dumping ground without enforcement — the exact failure mode the memory layer was designed to prevent.

**Recovery action:** See `WAREHOUSE_RECOVERY_MANIFEST.json` item RM-04.

---

### HIGH — Must Recover Second

#### G-05: Vagrant Mode design not promoted to authority

**What exists:** `.claude/plans/DECISIONS.md` and presumably `docs/plans/2026-02-14-vagrant-mode-design.md` (621 lines per session handoff note).

**What is missing:**
- No formal spec file at `docs/VAGRANT-MODE-SPEC.md`.
- The design is session-local and could be lost on branch deletion.
- No implementation — the design was finalized but no PR was created.

**Classification:** `high-confidence-inference` — the session handoff note is strong evidence the doc exists; the gap is its non-canonical location.

---

#### G-06: No watcher event schema (standalone)

**What exists:** `internal/watcher/` Go structs; `internal/statedb/statedb.go` SQLite schema for watcher rows; `assets/watcher-templates/POLICY.md` behavior rules.

**What is missing:**
- No JSON Schema or OpenAPI definition for watcher events.
- No standalone `WATCHER-EVENT-SPEC.md` in `docs/`.
- The Go structs are the de facto schema but are not machine-readable for non-Go consumers.

---

#### G-07: No canonical filesystem taxonomy document

**What exists:** `sanctuary-runtime/README.md` describes the new layout. `WAREHOUSE_SPECIFICATION.md` §8 synthesizes from corpus analysis.

**What is missing:**
- No single authoritative `FILESYSTEM-TAXONOMY.md` covering the entire repo root — only individual README files.
- The `~/.agent-deck/` runtime directory layout is documented in `documentation/CONDUCTOR.md` and `WATCHERS.md` but not in a dedicated spec.

---

#### G-08: No retention policy document

**What exists:** `CHANGELOG.md` mentions configurable `debug_retention_days`; `cmd/agent-deck/main.go` runs retention cleanup on startup; `assets/watcher-templates/POLICY.md` has watcher-specific escalation rules.

**What is missing:**
- No unified `RETENTION-POLICY.md` governing all seven retention categories (logs, sessions, archived memory, watcher events, compiled artifacts, schemas, signals).

---

#### G-09: VRAM telemetry is untested

**What exists:** `sanctuary-runtime/telemetry/docker-compose.dcgm-node.yml`, `docker-compose.prometheus-hub.yml`, `prometheus.yml`, `reviewer-vram-check.sh`.

**What is missing:**
- No CI test for the VRAM gate script.
- `prometheus.yml` has placeholder targets (`dcgm-node-1.local:9400`, etc.) — requires DNS/host config.
- No documented procedure to verify the DCGM exporter is working.
- `reviewer-vram-check.sh` assumes Prometheus is available at `localhost:9090` — no fallback URL.

---

### MEDIUM — Spec Gaps

#### G-10: No agent contract schema

**What exists:** `sanctuary-runtime/agent-runtime/shared/agents/*.md` describe roles in prose.

**What is missing:**
- No machine-readable agent contract (JSON Schema or YAML) specifying required inputs, outputs, signal obligations per role.

---

#### G-11: No compiled artifact manifest

**What exists:** `internal/releasetests/manifest_test.go` (Go release manifest test); `internal/web/static/manifest.webmanifest` (PWA manifest).

**What is missing:**
- No `COMPILED-ARTIFACTS.md` or JSON manifest listing all L6 objects, how they are generated, and which canonical sources they derive from.

---

#### G-12: Sanctuary-runtime has no test coverage

**What exists:** All `sanctuary-runtime/` files are Markdown, YAML, or shell scripts.

**What is missing:**
- No tests for shell scripts (`sync-skills.sh`, `new-session.sh`, etc.).
- No integration test confirming scripts run without errors.
- `vram_teleport.py` is a stub with no unit tests.

---

#### G-13: Bridge helpers are stubs

**What exists:** `sanctuary-runtime/bridge/powershell/profile-snippets.ps1`, `sanctuary-runtime/bridge/termux/install-termux-bridge.sh`.

**What is missing:**
- No tested path — both files have `TODO` placeholders.
- No documentation on how to test bridge connectivity from WSL or Termux.

---

## What Is NOT Missing (Confirmed Present)

| Artifact | Location | Confidence |
|----------|----------|-----------|
| Session persistence spec | `docs/SESSION-PERSISTENCE-SPEC.md` | High |
| Session ID lifecycle rules | `docs/session-id-lifecycle.md` | High |
| Per-group config spec | `docs/PER-GROUP-CLAUDE-CONFIG-SPEC.md` | High |
| Evaluator harness RFC | `docs/rfc/EVALUATOR_HARNESS.md` | High |
| Contributor rules | `CLAUDE.md` | High |
| Watcher shared knowledge | `assets/watcher-templates/CLAUDE.md` | High |
| Watcher policy | `assets/watcher-templates/POLICY.md` | High |
| Conductor user doc | `documentation/CONDUCTOR.md` | High |
| Skills user doc | `documentation/SKILLS.md` | High |
| Signal-Lang spec (initial) | `sanctuary-runtime/agent-runtime/shared/memory/60-signals/signal-lang.md` | Medium |
| Memory taxonomy structure | `sanctuary-runtime/agent-runtime/shared/memory/` | Medium |
| DCGM telemetry configs | `sanctuary-runtime/telemetry/` | Medium |

---

## Unresolved Ambiguities

| ID | Ambiguity | Evidence |
|----|-----------|----------|
| A-01 | Is `sanctuary-runtime/` permanent namespace or bootstrap? | No decision recorded in canonical `docs/` |
| A-02 | Should Vagrant Mode design be promoted to `docs/`? | Session-local decision in `.claude/plans/` |
| A-03 | What is the exact L6 compiled format for indexes? | Stub script only |
| A-04 | Is the authority score formula normative or illustrative? | Problem-statement seed only |
| A-05 | Does conductor `task-log.md` map to L0 events or L2 narrative? | Both are plausible; no ruling |
