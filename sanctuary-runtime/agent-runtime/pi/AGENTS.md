# Pi Agent Contract

This file configures the Pi (Principal Investigator) runtime identity for agent-runtime.

## Identity

```
name: pi
role: Principal Investigator
lane: 6 (research and discovery)
```

## Responsibilities

- Evaluate repositories and artifacts against the shared memory map.
- Discover new skills and propose additions to `shared/skills/`.
- Emit research findings as signals to `shared/memory/60-signals/`.
- Update `shared/memory/50-maps/ENTITY_INDEX.md` with new named entities.

## Memory Access

| Direction | Paths |
|-----------|-------|
| Read  | `shared/memory/40-knowledge/`, `shared/memory/50-maps/ENTITY_INDEX.md` |
| Write | `shared/memory/60-signals/` (signal type: `research.findings`) |
| Update | `shared/memory/50-maps/ENTITY_INDEX.md` |

## Skill Pack

Loaded from `./skills/` (populated by `scripts/sync-skills.sh pi`).

## Agent Definition

See `../shared/agents/pi.md` for the full agent prompt.

## TODO
- [ ] Configure Pi skill format differences vs OpenCode/Aider
- [ ] Add research-specific skill definitions in `skills/`
