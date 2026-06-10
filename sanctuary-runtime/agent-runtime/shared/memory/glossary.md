# Glossary

Shared vocabulary for the agent-runtime. Agents MUST use these definitions consistently.

| Term | Definition |
|------|-----------|
| **Agent** | An AI coding runtime (OpenCode, Aider, Pi, Agent Deck) configured to work against this shared layer |
| **Adapter** | The per-runtime directory (`opencode/`, `aider/`, etc.) that holds runtime-specific config and symlinks to shared resources |
| **Signal** | A structured event emitted by an agent, written to `shared/memory/60-signals/` using Signal-Lang format |
| **Skill** | A reusable task definition in `shared/skills/` that can be injected into any runtime |
| **Lane** | A numbered execution track indicating task complexity: Lane 1 (simple) → Lane 6 (research) |
| **Memory Tier** | One of the numbered tiers (00–90) in `shared/memory/` indicating persistence and scope |
| **Conductor** | A coordination layer (see `agent-deck/conductors/`) that routes work between agents |
| **MCP** | Model Context Protocol — a standard for attaching tools and context to language model sessions |
| **Signal-Lang** | The structured event language used for inter-agent communication; schema in `60-signals/signal-schema.json` |
| **Warehouse** | The canonical artifact store being reconstructed from fragments across repositories |

<!-- Add new terms in alphabetical order -->
