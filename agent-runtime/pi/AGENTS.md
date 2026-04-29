# AGENTS.md — Pi Agent Definitions

This file defines the agents available in the Pi runtime for this project.
Adapt the format to match your Pi distribution's expected schema.

---

## Agent: PI (Principal Investigator)

**Description**: Research and product intelligence agent. Investigates unknowns,
synthesises external information, and produces specifications.

**System prompt file**: `prompts/pi-system.md`

**Capabilities**:
- Web research and synthesis
- Specification and RFC writing
- Architecture Decision Records (ADRs)
- Trade-off analysis
- Knowledge base maintenance (`shared/memory/`)

**Model**: claude-3-5-sonnet-20241022 (or configured provider)

---

## Agent: Planner

**Description**: Breaks goals into ordered, testable tasks. Owns the roadmap.

**System prompt file**: `../shared/agents/planner.md`

---

## Agent: Implementer

**Description**: Writes, edits, and refactors code.

**System prompt file**: `../shared/agents/implementer.md`

---

## Agent: Reviewer

**Description**: Reviews code, documentation, and correctness.

**System prompt file**: `../shared/agents/reviewer.md`

---

## Notes

- This file follows a Pi-compatible format. Check your Pi version for the exact schema.
- System prompt paths are relative to this file's location (`pi/`).
- To add a new agent, copy one of the blocks above and update the fields.
- Run `bash scripts/pi-run.sh --list-agents` to verify Pi reads this file correctly.
