# Pi Prompts

Place Pi-native prompt template files (`.md`) here.

These are referenced from `AGENTS.md` via the `System prompt file` field.

## Provided prompts

_None yet — add your own here._

## Example: PI agent system prompt file

Create `prompts/pi-system.md` with content like:

```markdown
You are the PI (Principal Investigator) agent. Your role is to research
unknowns, synthesise information, and produce actionable specifications.

Always cite sources. Record decisions in shared/memory/decisions.md.
```

Then in `AGENTS.md` set:

```
**System prompt file**: prompts/pi-system.md
```
