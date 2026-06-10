# Shared Memory Layer

This directory is the central memory store for all runtimes in agent-runtime.

## Protocol

All agents read memory on startup and write structured signals on completion.

- **Read** `50-maps/INDEX.md` for a current map of all active context.
- **Write** signals to `60-signals/` using Signal-Lang format (see `60-signals/signal-schema.json`).
- **Append** decisions to `50-maps/DECISION_LOG.md`.
- **Update** `50-maps/ENTITY_INDEX.md` when new named entities (repos, people, concepts) appear.

## Working Documents

| File | Purpose |
|------|---------|
| `scratchpad.md` | Temporary working notes — cleared each session |
| `decisions.md` | Short-form decision log (alias for `50-maps/DECISION_LOG.md`) |
| `glossary.md` | Shared vocabulary and term definitions |

## Tier Structure

```
shared/memory/
├── README.md         ← this file
├── scratchpad.md     ← temporary notes
├── decisions.md      ← short-form decision log
├── glossary.md       ← shared vocabulary
├── 00-core/          ← identity, manifesto, global rules
├── 10-ops/           ← daily ops, priorities, blockers
├── 20-projects/      ← per-project context
├── 30-sessions/      ← session logs
├── 40-knowledge/     ← research, references
├── 50-maps/          ← indexes, entity map, decision log
├── 60-signals/       ← Signal-Lang events and schemas
└── 90-archive/       ← historical records
```

## Signal-Lang

Events and observations are written in Signal-Lang format, defined in
`60-signals/signal-schema.json`. See `60-signals/signal-lang.md` for the
language reference and `60-signals/examples.md` for usage examples.
