# Shared Memory

This directory is the persistent knowledge base shared across all agents and all
runtime adapters.

## Files

| File | Purpose |
|------|---------|
| `scratchpad.md` | Short-lived working notes — cleared between major milestones |
| `decisions.md` | Permanent record of architectural and product decisions (ADRs) |
| `glossary.md` | Domain terms, abbreviations, and project-specific vocabulary |

## Usage guidelines

- **Scratchpad** — Any agent can write here freely. Treat it as a whiteboard.
  Prune stale entries when they no longer apply.
- **Decisions** — Only the PI or Planner should add entries. Entries are never
  deleted (only superseded). Use the template in `decisions.md`.
- **Glossary** — Any agent can add entries. Entries should be concise (≤ 2 sentences).

## Sync

These files are part of `shared/` and are read directly by all adapters. There is
no need to copy them — the adapters reference this directory path at runtime.
