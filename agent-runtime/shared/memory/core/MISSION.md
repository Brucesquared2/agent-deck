# Mission

Build a production-quality, multi-agent development system that allows a small team of AI agents to plan, implement, review, and ship software — with full shared memory and minimal human friction.

## Current Focus

- Stabilize the `agent-runtime/` monorepo scaffold
- Implement a robust shared memory layer
- Wire OpenCode, Aider, and Pi adapters into the shared brain
- Validate end-to-end with a real project

## Success Criteria

- Any agent can read the full context of any session from `memory/`
- Decisions are always recorded; facts are never lost
- Signals allow fast, structured handoffs between agents
- Human operators can intervene at any point by reading `maps/INDEX.md`
