# Pi Agent Configuration

This directory configures the Pi coding agent runtime for agent-runtime.

## Active Agents

| Agent | Prompt | Role |
|-------|--------|------|
| Planner | `../shared/agents/planner.md` | Task decomposition |
| Implementer | `../shared/agents/implementer.md` | Code writing |
| Reviewer | `../shared/agents/reviewer.md` | Quality review |
| PI | `../shared/agents/pi.md` | Research & knowledge |

## Memory

Memory lives at `../shared/memory/`. Pi reads it via the `read:` context list.

## Skills

Skills are at `../shared/skills/`. Reference them with `@skill <path>`.

## Running

```sh
../scripts/run-pi.sh
```
