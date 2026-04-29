# Pi Adapter

Pi (Pi coding agent) runtime adapter for the agent-runtime monorepo.

## Configuration

See `AGENTS.md` for agent roster and prompt paths.

## Memory Context

Pi loads the following at session start:
- `memory/maps/INDEX.md`
- `memory/core/MISSION.md`
- `memory/core/PRINCIPLES.md`

## Running

```sh
# From agent-runtime/pi/:
../scripts/run-pi.sh

# With explicit agent:
PI_AGENT=planner ../scripts/run-pi.sh
```
