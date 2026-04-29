# Sample Project: hello-agent

This is a sample project memory pack demonstrating the format for `projects/<project>/`.

## Overview

| Field | Value |
|-------|-------|
| Name | hello-agent |
| Status | Example only |
| Owner | Implementer |
| Started | 2026-04-29 |
| Completed | — |

## Goal

Build a minimal "hello world" CLI tool that each of the four agents (Planner, Implementer, Reviewer, PI) can use to verify their environment is working.

## Architecture

```
hello-agent/
  main.go        # Entry point
  README.md      # User-facing docs
```

## Current Status

In progress. See `ops/task-queue.md` for active tasks.

## Gotchas

- Go version must be 1.24.0 (see `CLAUDE.md`)
- No external dependencies allowed for this sample

## Key Contacts / Entities

See `memory/maps/ENTITY_INDEX.md`.

## Decisions

| ID | Summary |
|----|---------|
| (none yet) | — |
