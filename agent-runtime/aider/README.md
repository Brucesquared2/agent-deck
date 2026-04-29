# Aider Adapter

Aider runtime adapter for the agent-runtime monorepo.

## Configuration

`aider.conf.yml` — configures model, system prompt, and memory context files.

## Active Agent

Aider runs one agent at a time. By default it loads the **Implementer** system prompt.

To switch agents, change `system-prompt` in `aider.conf.yml`:

```yaml
system-prompt: ../shared/agents/planner.md    # Planner mode
system-prompt: ../shared/agents/reviewer.md   # Reviewer mode
system-prompt: ../shared/agents/pi.md         # PI mode
```

## Memory Context

Aider reads the following memory files at session start:
- `memory/maps/INDEX.md`
- `memory/core/MISSION.md`
- `memory/core/PRINCIPLES.md`

## Running

```sh
# From agent-runtime/aider/:
aider --config aider.conf.yml

# Or from repo root:
cd agent-runtime && aider --config aider/aider.conf.yml
```

## Scripts

```sh
# Run aider with the implementer role (default):
../scripts/run-aider.sh

# Run aider with a different role:
AIDER_AGENT=planner ../scripts/run-aider.sh
```
