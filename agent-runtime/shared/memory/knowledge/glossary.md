# Glossary

Key terms used across the agent-runtime memory system.

#fact #reference

---

## Agent Deck
The terminal/TUI cockpit layer that manages AI coding agent sessions. Sits above OpenCode/Aider/Pi.

## Aider
A focused file-editing and code-patch AI coding agent runtime.

## Implementer
The agent responsible for executing tasks: writing code, applying patches, running commands.

## Memory Zone
One of the eight categorized directories under `shared/memory/`. Each zone has a distinct purpose and retention policy.

## OpenCode
The primary AI coding agent runtime used in this system.

## Pi (Pi Coding Agent)
An experimental/custom AI coding agent runtime.

## PI Agent
Principal Investigator agent. Conducts research, maintains the knowledge base, and validates assumptions.

## Planner
The agent responsible for decomposing goals into ordered tasks and maintaining the roadmap.

## Reviewer
The agent responsible for checking the quality, correctness, and security of Implementer output.

## Signal
A structured message emitted by one agent and consumed by another. See `signals/README.md`.

## Signal-Lang
The lightweight YAML+Markdown format used to write signals. See `signals/README.md`.

## Skill
A reusable capability module that any agent can invoke. Stored in `shared/skills/`.

## Task Queue
The ordered list of work items maintained by the Planner in `ops/task-queue.md`.
