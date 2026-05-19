# OpenCode Adapter

OpenCode runtime adapter for the agent-runtime monorepo.

## Configuration

`opencode.config.json` — configures agents, model, skills directory, and memory directory.

## Agents

All four agents (Planner, Implementer, Reviewer, PI) are loaded from `../shared/agents/`.

## Skills

Skills are loaded from `../shared/skills/`. Run `../scripts/sync-skills.sh` if you need to copy them to a local format.

## Memory

Memory lives in `../shared/memory/`. OpenCode reads/writes it directly.

## Running

```sh
# From the opencode/ directory:
opencode --config opencode.config.json

# Or from the repo root:
cd agent-runtime && opencode --config opencode/opencode.config.json
```

## MCP

Add MCP servers to the `mcp.servers` block in `opencode.config.json`.
