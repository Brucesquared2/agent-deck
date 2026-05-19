# Memory Maintenance Checklist

## Weekly (every Monday)

- [ ] Run `scripts/memory-tag-refresh.sh` to regenerate `maps/TAG_INDEX.md` and `maps/ENTITY_INDEX.md`
- [ ] Review `scratch/` — promote or delete items
- [ ] Check `ops/task-queue.md` — archive completed tasks
- [ ] Verify `maps/INDEX.md` is current (new sessions, new knowledge files)
- [ ] Add any new recurring signals to `signals/README.md`

## Monthly (first Monday)

- [ ] Archive sessions older than 30 days → `sessions/archive/YYYY-MM/`
- [ ] Review `knowledge/` for stale or contradicted facts; update or delete
- [ ] Review `maps/DECISION_LOG.md` — add "outcome" notes to decisions > 60 days old
- [ ] Review `core/MISSION.md` and `core/PRINCIPLES.md` — update if context has shifted
- [ ] Review `projects/` — archive completed projects → `projects/archive/`
- [ ] Prune `maps/ENTITY_INDEX.md` — remove dead tools/repos
- [ ] Publish a "monthly memory health" note to `knowledge/memory-health-<YYYY-MM>.md`

## Quarterly

- [ ] Full audit: read every file in `maps/` and `core/`
- [ ] Update agent prompts in `../agents/` if roles have evolved
- [ ] Review scripts in `../../scripts/` for correctness
