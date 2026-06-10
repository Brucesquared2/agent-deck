# Conductors

Conductor definitions orchestrate multi-agent workflows.

## Format

Each conductor is a TOML file describing a workflow:

```toml
name        = "my-workflow"
description = "What this conductor does"

[[steps]]
agent  = "opencode"          # which runtime handles this step
prompt = "Implement X"       # task prompt
lane   = 3                   # complexity lane (1–6)

[[steps]]
agent  = "aider"
prompt = "Refactor Y into Z"
lane   = 2
```

## Available Conductors

| File | Description |
|------|-------------|
| *(none yet)* | — |

## TODO
- [ ] Add example conductor for a full plan → implement → review workflow
