# Shared MCP (Model Context Protocol)

This directory contains Model Context Protocol server definitions and documentation
for the agent-runtime system.

## What is MCP?

MCP (Model Context Protocol) is a standard that allows AI coding agents to connect
to external tool servers — providing capabilities like file system access, web search,
database queries, and more — in a structured, permission-controlled way.

## Adding an MCP server

1. Define the server in the appropriate runtime config:
   - OpenCode: add to `opencode/opencode.config.json` under the `mcpServers` key
   - Aider: MCP support depends on the Aider version — check the Aider docs
   - Pi: check `pi/AGENTS.md` for Pi's MCP integration path
2. Document the server here with name, purpose, and connection details (no secrets).

## Common MCP servers

| Server | Purpose | Notes |
|--------|---------|-------|
| `filesystem` | Read/write local files with path restrictions | Built-in to many agents |
| `git` | Git operations (log, diff, blame) | Useful for Reviewer agent |
| `brave-search` | Web search | Useful for PI agent research |
| `github` | GitHub API (issues, PRs, repos) | Requires `GITHUB_TOKEN` env var |
| `postgres` | PostgreSQL queries | Requires DB connection string |

## Environment variables

MCP servers typically require credentials via environment variables. Store these in
a `.env` file at `agent-runtime/` root (never commit it — it is in `.gitignore`).

```sh
# agent-runtime/.env (DO NOT COMMIT)
GITHUB_TOKEN=ghp_...
BRAVE_API_KEY=BSA...
DATABASE_URL=postgres://...
```

Load with `source .env` or use a tool like `direnv`.
