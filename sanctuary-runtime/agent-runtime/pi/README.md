# Pi Adapter

Adapter configuration for the Pi (Principal Investigator) runtime.

## Purpose
Pi handles experimental research, repo evaluation, and skill discovery (Lane 6).

## Setup
<!-- TODO: add pi config file path and format -->

1. Install Pi: follow upstream docs (badlogic/pi-mono).
2. Copy or symlink `../shared/skills/` as a Pi skill pack.
3. Point Pi's AGENTS.md to `../shared/agents/pi.md`.

## Sync Skills
```sh
bash ../scripts/sync-skills.sh pi
```

## Memory Integration
- Read: `../shared/memory/40-knowledge/`, `../shared/memory/50-maps/ENTITY_INDEX.md`
- Write: `../shared/memory/60-signals/` (research.findings signals)
- Update: `../shared/memory/50-maps/ENTITY_INDEX.md`

## TODO
- [ ] Add `AGENTS.md` stub pointing to `shared/agents/pi.md`
- [ ] Document Pi skill format differences vs OpenCode/Aider
