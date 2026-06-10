# MCP Server Configurations

This directory holds Model Context Protocol (MCP) server registrations shared across all runtimes.

## What is MCP?

MCP (Model Context Protocol) is an open standard for attaching tools, context, and resources to
language-model sessions. Each MCP server exposes a set of tools that agents can call.

## Structure

```
shared/mcp/
├── README.md         ← this file
└── servers/          ← one config stub per MCP server
    └── <server-name>.json
```

## Server Config Format

```json
{
  "name": "server-name",
  "command": "npx",
  "args": ["-y", "@scope/mcp-server-name"],
  "env": {
    "KEY": "value"
  },
  "description": "What this server provides"
}
```

## Registered Servers

| Server | Description | Status |
|--------|-------------|--------|
| *(none yet)* | — | — |

## Adding a Server

1. Create `servers/<name>.json` following the format above.
2. Reference it in each adapter's runtime config (`opencode.toml`, `.aider.conf.yml`, etc.).
3. Document it in the table above.

## TODO
- [ ] Register filesystem MCP server
- [ ] Register GitHub MCP server
- [ ] Register memory-reader MCP server
