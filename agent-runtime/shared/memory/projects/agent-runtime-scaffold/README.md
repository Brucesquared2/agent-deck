# Project Pack: agent-runtime-scaffold

#active #agent #memory

## Overview

| Field | Value |
|-------|-------|
| Name | agent-runtime-scaffold |
| Status | In Progress |
| Owner | Planner + Implementer |
| Started | 2026-04-29 |

## Goal

Build the full `agent-runtime/` monorepo scaffold, including:
- Shared agents, skills, memory
- OpenCode, Aider, Pi adapter configs
- Agent Deck integration
- Operational scripts

## Progress

See `ops/task-queue.md`.

## Architecture

```
agent-runtime/
  shared/
    agents/        # Agent prompts
    skills/        # Reusable capability modules
    memory/        # This memory system
  opencode/        # OpenCode adapter
  aider/           # Aider adapter
  pi/              # Pi adapter
  agent-deck/      # Agent Deck config
  scripts/         # Operational scripts
```

## Decisions

- [DECISION-001](../../maps/DECISION_LOG.md): Signal-lang format
- [DECISION-002](../../maps/DECISION_LOG.md): Memory zone taxonomy
