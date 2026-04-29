# OpenCode Adapter

This directory contains the OpenCode runtime adapter for the agent-runtime system.

## What is OpenCode?

[OpenCode](https://opencode.ai) is the primary AI coding-agent runtime. It provides
a terminal and API interface for running LLM-powered coding sessions with support for
MCP servers, skills, multi-session workflows, and local/remote providers.

## Directory structure

```
opencode/
├── README.md               ← this file
├── opencode.config.json    ← OpenCode configuration
├── agents/                 ← agent prompts (copied from shared/agents by sync-skills.sh)
├── skills/                 ← skill packs (copied from shared/skills by sync-skills.sh)
└── workflows/              ← OpenCode workflow templates
```

## Setup

1. Install OpenCode (see https://opencode.ai for instructions).
2. Sync shared assets:
   ```sh
   bash ../scripts/sync-skills.sh
   ```
3. Configure your provider API keys in `opencode.config.json` (or via environment
   variables — see the OpenCode docs).
4. Run:
   ```sh
   bash ../scripts/run-opencode.sh
   ```

## Configuration

Edit `opencode.config.json` to:
- Set your LLM provider and model.
- Register MCP servers (see `shared/mcp/README.md`).
- Point to the `agents/` and `skills/` directories.

## Adding workflows

Place OpenCode workflow template files (`.json` or `.yaml`) in `workflows/`.
See the [OpenCode workflow docs](https://opencode.ai/docs/workflows) for the format.

## Notes

- Agent prompt files in `agents/` are auto-synced from `shared/agents/`.
  Edit the originals in `shared/agents/` — do not edit the copies here directly.
- The same applies to `skills/`.
