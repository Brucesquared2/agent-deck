# Memory Index

> **Start here.** This is the human front door to the shared memory system.

## Quick Reference

| Folder | What lives there |
|--------|-----------------|
| `00-core/` | Principles, policies, charter |
| `10-ops/` | Runbooks, incidents, maintenance |
| `20-projects/` | Per-repo project packs |
| `30-sessions/` | Dated session logs and summaries |
| `40-knowledge/` | Curated facts and reusable patterns |
| `50-maps/` | Indexes and memory maps (you are here) |
| `60-signals/` | Signal-Lang spec and signal logs |
| `90-archive/` | Frozen, immutable history |

## Key Files

| File | Purpose |
|------|---------|
| `MEMORY_MAP.md` | Rules for what belongs where |
| `TAG_INDEX.md` | Canonical tags → memory links |
| `ENTITY_INDEX.md` | People, tools, repos, components |
| `DECISION_LOG.md` | ADR-lite decision history |

## Maintenance Habit

After every session:
1. Add any new tags to `TAG_INDEX.md`
2. Add any new entities to `ENTITY_INDEX.md`
3. Record any decisions in `DECISION_LOG.md`
4. Run `scripts/refresh-indexes.sh` to regenerate derived indexes

## Last Refreshed
<!-- Updated automatically by refresh-indexes.sh -->
_Not yet refreshed._
