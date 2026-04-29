# Decisions

Permanent record of architectural and product decisions. Entries are never deleted;
superseded entries are marked `[SUPERSEDED by #N]`.

---

## Template

```
## Decision #N: <short title>

- **Date**: YYYY-MM-DD
- **Status**: Proposed | Accepted | Superseded
- **Deciders**: <agent or person>
- **Context**: <what forced the decision>
- **Decision**: <what was decided>
- **Rationale**: <why this option over alternatives>
- **Consequences**: <expected outcomes, trade-offs>
```

---

## Decision #1: Use monorepo with shared canonical brain

- **Date**: 2024-01-01
- **Status**: Accepted
- **Deciders**: Planner, PI
- **Context**: Three runtime adapters (OpenCode, Aider, Pi) each need the same
  agent prompts and skill definitions. Duplicating them leads to drift.
- **Decision**: Keep one `shared/` directory as the canonical source; a sync script
  copies content into adapter folders on demand.
- **Rationale**: Avoids symlinks (cross-platform issues), keeps adapters self-contained,
  and makes sync explicit and auditable.
- **Consequences**: Contributors must run `sync-skills.sh` after editing `shared/`.
  CI should validate that adapter copies are not stale.
