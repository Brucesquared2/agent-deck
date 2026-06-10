---
status: candidate
version: "0.1"
authority: provisional
artifact: DEPRECATION_POLICY
---

# DEPRECATION_POLICY

> This policy governs how Warehouse artifacts are deprecated.
> It applies to all artifacts in `agent-runtime/`, `warehouse/canon/`, and any
> artifact family tracked in `WAREHOUSE_AUTHORITY_MAP.json`.
> Status: candidate until Bruce approval.

---

## 1. Definitions

| Term | Meaning |
|------|---------|
| **Canonical** | Explicitly blessed as authoritative by Bruce. The single truth for its artifact family. |
| **Candidate** | Proposed for canonical status. Agents may cite it but must mark citations provisional. |
| **Grandfathered** | Legacy artifact retained as read-only for continuity. Not authoritative. Not archived. |
| **Deprecated** | Artifact is superseded. A redirect stub or deprecation notice is in place. No new content should be added. |
| **Archived** | Artifact has been moved to `90-archive/`. It is no longer active but is preserved for historical lineage. |

---

## 2. Lifecycle states

```
candidate ──► canonical
    │              │
    │              ▼
    │         deprecated ──► archived
    │
    ▼
grandfathered ──► deprecated ──► archived
```

No artifact transitions directly from `canonical` to `archived` without passing through
`deprecated` first. This ensures a redirect stub is always in place for at least one cycle.

---

## 3. Deprecation rules

### 3.1 What triggers deprecation

An artifact may be deprecated when:

1. A canonical superseding artifact exists and has been blessed (CD or ADR record).
2. The artifact is no longer referenced by any active session, project pack, or agent contract.
3. Bruce explicitly directs deprecation.

An artifact must **not** be deprecated when:

- No superseding artifact exists.
- The superseding artifact is still in `candidate` status.
- The deprecation would remove the only source of a fact or policy.

### 3.2 Required steps to deprecate

| Step | Action |
|------|--------|
| 1 | Record the deprecation decision in `CANONIZATION_DECISIONS.md` or `DECISION_LOG.md` |
| 2 | Add a deprecation notice to the top of the artifact (see §3.3) |
| 3 | Add a corresponding entry to `WAREHOUSE_AUTHORITY_MAP.json` with `"status": "deprecated"` |
| 4 | Update any agent contracts or session templates that reference the artifact |
| 5 | Run `scripts/refresh-indexes.sh` to update indexes |

### 3.3 Deprecation notice format

Prepend to the deprecated file:

```markdown
> **DEPRECATED**
> Superseded by: `<path-to-superseding-artifact>`
> Decision: CD-NNN / ADR-NNN
> Date deprecated: YYYY-MM-DD
> Status: deprecated — do not add new content; do not cite as authoritative
```

---

## 4. Archival rules

### 4.1 When to archive

An artifact moves to `90-archive/` when:

- It has been in `deprecated` status for at least **90 days**, and
- No active session, project pack, or agent contract references it, and
- The Planner agent confirms no active workflows depend on it.

### 4.2 Archive path

```
90-archive/<original-layer-path>/<original-filename>
```

Example: `signals/HANDOFF_2026-04-29_001.signal` → `90-archive/signals-legacy/HANDOFF_2026-04-29_001.signal`

### 4.3 Archive record

Append an entry to `50-maps/INDEX.md`:

```
| `90-archive/<path>` | Archived <ISO-date>. Formerly `<original-path>`. Superseded by `<new-path>`. |
```

---

## 5. Grandfathering rules

Grandfathered artifacts are a special case: they are deprecated in spirit but retained
active in practice because migration is incomplete.

### 5.1 Conditions for grandfathering

An artifact may be grandfathered (rather than immediately deprecated) when:

- Active agent workflows still reference it.
- A migration plan exists but has not yet been executed.
- Deleting or redirecting it immediately would break running agents.

### 5.2 Grandfathering obligations

A grandfathered artifact must:

1. Have a grandfathering notice at the top of the file (see §5.3).
2. Have an entry in `WAREHOUSE_AUTHORITY_MAP.json` with `"status": "legacy-active"`.
3. Have a corresponding migration plan referenced in the notice.
4. Be reviewed every 90 days by the Planner agent.

### 5.3 Grandfathering notice format

```markdown
> **GRANDFATHERED — LEGACY ACTIVE**
> This artifact is superseded by: `<path-to-superseding-artifact>`
> Decision: CD-NNN / ADR-NNN
> Migration plan: `<path-to-migration-plan>`
> Date grandfathered: YYYY-MM-DD
> Status: legacy-active — read-only; do not add new content
```

---

## 6. Forbidden actions

The following actions are **forbidden** for all agents without explicit Bruce approval:

- Deleting any file that has no redirect stub or archival record.
- Removing a `deprecated` notice once added.
- Promoting an artifact from `deprecated` back to `candidate` or `canonical` (requires new ADR).
- Archiving an artifact that is still referenced by an active workflow.

---

## 7. Current deprecation schedule

| Artifact | Current status | Planned action | Trigger |
|----------|---------------|----------------|---------|
| `agent-runtime/shared/memory/core/` (legacy unnumbered) | `legacy-active` | Grandfathered → deprecated after migration | CD-002 approval + TAXONOMY_MIGRATION_PLAN Phase 3 |
| `agent-runtime/shared/memory/maps/` (legacy unnumbered) | `legacy-active` | Redirect stubs → deprecated | CD-002 approval + TAXONOMY_MIGRATION_PLAN Phase 3 |
| `agent-runtime/shared/memory/ops/` (legacy unnumbered) | `legacy-active` | Content promoted → deprecated | CD-002 approval + TAXONOMY_MIGRATION_PLAN Phase 2 |
| `agent-runtime/shared/memory/signals/*.signal` | `legacy-active` | Archive → `90-archive/signals-legacy/` | CD-001 approval + SIGNAL_LANG_MIGRATION_PLAN Phase 2 |
| `agent-runtime/shared/memory/signals/README.md` | `legacy-active` | Legacy notice + redirect | CD-001 approval + SIGNAL_LANG_MIGRATION_PLAN Phase 1 |

---

## 8. Policy revision

This policy is append-only.

To revise a rule:
1. Append a `## Revision NNN — <Date>` section.
2. State the revised rule.
3. State the reason for revision.
4. Record the decision in `CANONIZATION_DECISIONS.md`.

Do not edit or delete earlier rule text.
