# Decision Log

All non-trivial decisions made by the agent team, in reverse chronological order.

## How to Add an Entry

1. Copy the template below.
2. Assign the next DECISION-NNN number.
3. Fill in all fields.
4. Add a link in `maps/INDEX.md` under "Recent Decisions".

## Template

```
## DECISION-NNN: <title>
Date: YYYY-MM-DD
Made by: <agent>
Context: <why this decision was needed>
Decision: <what was decided>
Alternatives: <what was rejected and why>
Impact: <what this changes>
Outcome: <filled in later — did it work?>
Tags: #decision #<domain>
```

---

## DECISION-002: Memory zone taxonomy
Date: 2026-04-29  
Made by: Planner  
Context: Needed a clear filing system so agents don't lose information between sessions.  
Decision: Use eight zones: core, ops, projects, sessions, knowledge, maps, signals, scratch.  
Alternatives: Flat structure (rejected: too hard to navigate); per-agent zones (rejected: cross-agent sharing is core requirement).  
Impact: All memory filing follows this taxonomy. See `maps/MEMORY_MAP.md`.  
Outcome: (pending)  
Tags: #decision #memory #architecture

---

## DECISION-001: Signal-lang format
Date: 2026-04-29  
Made by: Planner  
Context: Agents needed a lightweight, structured way to communicate task state and hand off work.  
Decision: Use YAML-front-matter Markdown files (`.signal` extension) stored in `memory/signals/`.  
Alternatives: Plain text logs (rejected: not machine-parseable); JSON (rejected: not human-friendly); TOML (rejected: less familiar to most LLMs).  
Impact: All agent handoffs go through signal files. See `memory/signals/README.md`.  
Outcome: (pending)  
Tags: #decision #signal #architecture
