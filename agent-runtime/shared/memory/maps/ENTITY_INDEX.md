# Entity Index

All significant people, tools, repositories, and components referenced in the agent memory system.

## Format

```
## <Entity Name>
Type: person | tool | repo | component | service
Tags: #tag1 #tag2
Description: One-line description.
Links:
  - [label](url-or-path)
Last updated: YYYY-MM-DD
```

---

## Agent Deck
Type: tool  
Tags: #agent-deck #cockpit #session-manager  
Description: Terminal/TUI cockpit for managing multiple AI coding agent sessions.  
Links:
  - [GitHub](https://github.com/Brucesquared2/agent-deck)
  - [Docs](../../agent-deck/README.md)
Last updated: 2026-04-29

---

## OpenCode
Type: tool  
Tags: #opencode #coding-agent #runtime  
Description: Primary coding agent runtime; supports multi-session, LSP, local/remote providers.  
Links:
  - [GitHub](https://github.com/opencode-ai/opencode)
  - [Adapter config](../../opencode/)
Last updated: 2026-04-29

---

## Aider
Type: tool  
Tags: #aider #coding-agent #runtime #file-editing  
Description: Focused file-editing and code-patch agent runtime.  
Links:
  - [GitHub](https://github.com/Aider-AI/aider)
  - [Adapter config](../../aider/)
Last updated: 2026-04-29

---

## Pi (Pi Coding Agent)
Type: tool  
Tags: #pi-runtime #coding-agent #runtime  
Description: Experimental / custom coding-agent runtime.  
Links:
  - [Adapter config](../../pi/)
Last updated: 2026-04-29

---

## Planner Agent
Type: component  
Tags: #agent #planner  
Description: Decomposes goals into tasks; owns the roadmap and task queue.  
Links:
  - [Prompt](../../agents/planner.md)
Last updated: 2026-04-29

---

## Implementer Agent
Type: component  
Tags: #agent #implementer  
Description: Executes tasks; writes code and files.  
Links:
  - [Prompt](../../agents/implementer.md)
Last updated: 2026-04-29

---

## Reviewer Agent
Type: component  
Tags: #agent #reviewer  
Description: Reviews output for correctness, security, and quality.  
Links:
  - [Prompt](../../agents/reviewer.md)
Last updated: 2026-04-29

---

## PI Agent
Type: component  
Tags: #agent #pi  
Description: Principal Investigator; conducts research and maintains the knowledge base.  
Links:
  - [Prompt](../../agents/pi.md)
Last updated: 2026-04-29
