---
status: candidate
version: "0.1"
authority: provisional
artifact: CANONIZATION_DECISIONS
---

# CANONIZATION_DECISIONS

> Append-only. One entry per canonization decision.
> Decisions here are **proposed** until explicitly marked `accepted` by Bruce.
> Format mirrors `agent-runtime/shared/memory/50-maps/DECISION_LOG.md`.

---

## Format

```
### CD-NNN — <Title>

| Field | Value |
|-------|-------|
| **Date proposed** | YYYY-MM-DD |
| **Status** | proposed / accepted / rejected / superseded |
| **Decided by** | bruce / planner / consensus |
| **Source ADR** | ADR-NNN (if applicable) |

**Decision:** _One or two sentences._

**Rationale:** _Why this decision matters._

**Consequences:** _What changes when this is accepted._
```

---

### CD-001 — Versioned YAML-in-Markdown Signal format supersedes legacy `.signal` front-matter

| Field | Value |
|-------|-------|
| **Date proposed** | 2026-06-10 |
| **Status** | proposed |
| **Decided by** | pending Bruce |
| **Source ADR** | ADR-001 |

**Decision:** The YAML-in-Markdown signal format defined in
`agent-runtime/shared/memory/60-signals/signal-lang.md` (v1.0, schema-backed) is the canonical
Signal emission format. No new `.signal` front-matter files should be created.

**Rationale:** ADR-001 already ratified this format. The legacy `.signal` files were created
after ADR-001 and represent a format divergence. A parser cannot be implemented until one format
is authoritative.

**Consequences:** Existing `.signal` files become legacy read-only artifacts. Agent contracts
must be updated to reference only the v1.0 format. Migration plan: `SIGNAL_LANG_MIGRATION_PLAN.md`.

---

### CD-002 — Numbered taxonomy supersedes legacy unnumbered taxonomy

| Field | Value |
|-------|-------|
| **Date proposed** | 2026-06-10 |
| **Status** | proposed |
| **Decided by** | pending Bruce |
| **Source ADR** | — |

**Decision:** The numbered memory zone structure (`00-core/`, `10-ops/`, `20-projects/`,
`30-sessions/`, `40-knowledge/`, `50-maps/`, `60-signals/`, `90-archive/`) is the canonical
taxonomy. The legacy unnumbered zones (`core/`, `ops/`, `maps/`, `signals/`, etc.) are
grandfathered read-only until a migration note is published.

**Rationale:** The numbered taxonomy is more complete, is referenced by the newer agent contracts
and `MEMORY_MAP.md`, and provides sorting and navigation properties the unnumbered zones do not.

**Consequences:** Agent contracts must be unified to reference only numbered zones. Redirect
stubs must be added to legacy zone files. Migration plan: `TAXONOMY_MIGRATION_PLAN.md`.

---

### CD-003 — Candidate specifications do not override source evidence

| Field | Value |
|-------|-------|
| **Date proposed** | 2026-06-10 |
| **Status** | proposed |
| **Decided by** | pending Bruce |
| **Source ADR** | — |

**Decision:** Candidate or provisional specification documents (including
`WAREHOUSE_SPECIFICATION.md`) are subordinate to direct source evidence when a conflict exists.
A source artifact found in the repository is more authoritative than a reconstructed prose claim
unless the prose claim is tagged `[FACT]` with an explicit citation.

**Rationale:** Prevents reconstructed prose from drifting away from ground truth as the corpus
evolves.

**Consequences:** Any `[FACT]` claim in provisional spec files must carry a source path.
`[INFERENCE]` claims are valid but must not be treated as authoritative without explicit blessing.

---

### CD-004 — Authority artifacts require explicit operator blessing

| Field | Value |
|-------|-------|
| **Date proposed** | 2026-06-10 |
| **Status** | proposed |
| **Decided by** | pending Bruce |
| **Source ADR** | — |

**Decision:** No artifact family may be promoted from `candidate` to `canonical` status without
an explicit approval decision recorded here or in `DECISION_LOG.md` by Bruce (the operator).
Repeated agent use of an artifact does not confer canonical status.

**Rationale:** Prevents gradual drift where "it has always been done this way" becomes treated
as canon. Axiom A8: agents consume authority but do not create authority.

**Consequences:** Every `status: candidate` artifact in `warehouse/canon/` must wait for a
corresponding entry in this log before it may be cited as canonical. Agents may cite candidate
artifacts but must mark citations as provisional.
