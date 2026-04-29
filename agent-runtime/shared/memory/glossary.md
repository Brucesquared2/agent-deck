# Glossary

Domain terms, abbreviations, and project-specific vocabulary.

---

| Term | Definition |
|------|-----------|
| **Agent Deck** | The cockpit / TUI session manager that sits above all runtime adapters. |
| **Adapter** | A runtime folder (opencode/, aider/, pi/) that wraps a specific AI coding tool. |
| **Canonical brain** | The `shared/` directory — single source of truth for agents, skills, memory, and MCP definitions. |
| **Conductor** | A persistent supervisor agent in Agent Deck that watches and coordinates other sessions. |
| **MCP** | Model Context Protocol — a standard for attaching tools/context servers to LLM sessions. |
| **PI** | Principal Investigator — the research and product-intelligence agent. |
| **Scratchpad** | Short-lived working memory in `shared/memory/scratchpad.md`. |
| **Skill** | A reusable, packaged capability (prompt template + optional tooling) that agents can invoke. |
| **Sync script** | `scripts/sync-skills.sh` — copies shared agents/skills into each adapter folder. |
| **Worktree** | A git worktree allowing multiple agents to work on the same repo simultaneously without conflicts. |
| **Watcher** | An Agent Deck component that listens to external events (GitHub, Slack, webhooks) and triggers agents. |
