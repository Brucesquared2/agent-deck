# Decision Log

> ADR-lite entries. Append only. One entry per architectural or significant decision.
> Referenced from project packs and session summaries.

---

## Format

```
### ADR-NNN — <Title>

| Field | Value |
|-------|-------|
| **Date** | YYYY-MM-DD |
| **Status** | proposed / accepted / deprecated / superseded |
| **Supersedes** | ADR-NNN (if applicable) |
| **Agents involved** | planner, implementer, ... |
| **Session** | <session-id> |

**Context:** _Why was this decision needed?_

**Decision:** _What was decided, in one or two sentences._

**Consequences:** _What changes as a result? What trade-offs were accepted?_
```

---

### ADR-001 — Use YAML-in-Markdown as the signal-lang format

| Field | Value |
|-------|-------|
| **Date** | 2026-04-29 |
| **Status** | accepted |
| **Supersedes** | — |
| **Agents involved** | planner |
| **Session** | bootstrap |

**Context:** Agents need a lightweight, human-readable format for emitting structured signals (handoffs, constraints, memory write intents). Options considered: JSON-only, TOML, a terse `.signal` log format, and YAML blocks inside Markdown.

**Decision:** Use YAML front-matter blocks inside Markdown (``` ```yaml ```) as the canonical signal-lang format. A companion JSON Schema (`signal-schema.json`) validates the structure programmatically.

**Consequences:** Signals are readable in any text editor and renderable in GitHub. Parsers need only a YAML library. The JSON Schema enables optional CI validation without changing the authoring format.

---

### ADR-002 — Reviewer VRAM gate is opt-in (default off)

| Field | Value |
|-------|-------|
| **Date** | 2026-04-29 |
| **Status** | accepted |
| **Supersedes** | — |
| **Agents involved** | planner, reviewer |
| **Session** | bootstrap |

**Context:** The Reviewer agent may need to load a model locally to validate outputs. VRAM availability varies across hosts. Blocking CI on VRAM checks on hosts without a GPU would break pipelines.

**Decision:** `scripts/reviewer-vram-check.sh` exits 0 (no-op) by default. Setting `AGENT_DECK_REVIEWER_VRAM_CHECK=1` enables the actual check.

**Consequences:** Zero friction on GPU-less CI. Teams with GPU runners can opt in via environment variable.

---

### ADR-003 — Memory indexes are script-generated (not hand-edited)

| Field | Value |
|-------|-------|
| **Date** | 2026-04-29 |
| **Status** | accepted |
| **Supersedes** | — |
| **Agents involved** | planner |
| **Session** | bootstrap |

**Context:** Keeping TAG_INDEX and ENTITY_INDEX accurate by hand is error-prone and creates merge conflicts when multiple agents write simultaneously.

**Decision:** `scripts/refresh-indexes.sh` owns TAG_INDEX.md and ENTITY_INDEX.md entirely. It replaces content between sentinel comments on every run. Agents and humans must not edit those files directly.

**Consequences:** Indexes are always regenerable from source. The cost is that any manual customisation of the index format is lost on the next refresh.
