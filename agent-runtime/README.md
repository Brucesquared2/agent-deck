# agent-runtime

**Agent Deck is the missing cockpit layer.**

This directory is the shared monorepo for the Agent Deck runtime system. It provides a
*canonical brain* (agents / skills / memory / MCP) and three runtime adapters:

| Adapter | Purpose |
|---------|---------|
| `opencode/` | Primary coding-agent runtime (OpenCode) |
| `aider/` | Focused file-editing / code-patch runtime (Aider) |
| `pi/` | Experimental / custom coding-agent runtime (Pi) |

Agent Deck itself (`agent-deck/`) is the cockpit that manages all three sessions,
worktrees, conductors, watchers, and MCP servers.

---

## Architecture

```
You
 └─► Agent Deck cockpit   (agent-deck/)
      ├─► OpenCode session  (opencode/)
      ├─► Aider session     (aider/)
      └─► Pi session        (pi/)
            │
            └─► shared/
                 ├── agents/    ← canonical agent prompts
                 ├── skills/    ← reusable skill packs
                 ├── memory/    ← scratchpad / decisions / glossary
                 └── mcp/       ← MCP server definitions
```

### The four agents

| Agent | Role |
|-------|------|
| **Planner** | Breaks goals into ordered tasks; owns the roadmap |
| **Implementer** | Writes and edits code; handles the inner loop |
| **Reviewer** | Checks code quality, docs, risk, and correctness |
| **PI** | Principal Investigator — research, specs, product intelligence |

---

## Quick start

```sh
# 1. Sync shared agents/skills into each adapter folder
bash scripts/sync-skills.sh

# 2. Launch Agent Deck cockpit
bash scripts/launch-deck.sh

# 3. (Optional) Launch individual runtimes
bash scripts/run-opencode.sh
bash scripts/run-aider.sh
bash scripts/run-pi.sh

# 4. (Optional) Launch everything at once
bash scripts/run-all.sh
```

---

## Directory reference

```
agent-runtime/
├── README.md                 ← you are here
├── shared/
│   ├── agents/               ← canonical agent prompts (.md)
│   ├── skills/               ← shared skill packs
│   ├── memory/               ← scratchpad, decisions, glossary
│   └── mcp/                  ← MCP server definitions & README
├── opencode/
│   ├── README.md
│   ├── opencode.config.json  ← OpenCode config
│   ├── agents/               ← copied from shared/agents by sync-skills.sh
│   ├── skills/               ← copied from shared/skills by sync-skills.sh
│   └── workflows/            ← OpenCode workflow templates
├── aider/
│   ├── README.md
│   ├── aider.conf.yml        ← Aider config
│   ├── prompts/              ← aider prompt files
│   ├── skills/               ← copied from shared/skills by sync-skills.sh
│   └── scripts/
│       └── aider-run.sh
├── pi/
│   ├── README.md
│   ├── AGENTS.md             ← Pi agent definitions
│   ├── prompts/
│   ├── skills/               ← copied from shared/skills by sync-skills.sh
│   └── scripts/
│       └── pi-run.sh
├── agent-deck/
│   ├── README.md
│   ├── config.toml           ← Agent Deck config
│   ├── worktree-setup.sh     ← sets up git worktrees per session
│   └── conductors/
│       └── README.md
└── scripts/
    ├── sync-skills.sh        ← copy shared → adapter folders
    ├── run-opencode.sh
    ├── run-aider.sh
    ├── run-pi.sh
    ├── launch-deck.sh
    └── run-all.sh
```

---

## How to extend

### Add a new agent prompt

1. Create `shared/agents/<name>.md` following the template in any existing agent file.
2. Run `bash scripts/sync-skills.sh` to push it into all adapter folders.

### Add a new skill

1. Create a folder under `shared/skills/<category>/` with a `README.md` and any
   supporting files.
2. Run `bash scripts/sync-skills.sh`.

### Register an MCP server

Edit `shared/mcp/README.md` (or add a JSON/TOML definition there) and update
`opencode/opencode.config.json` accordingly.

### Add a new runtime adapter

1. Create a new top-level folder (e.g. `codex/`).
2. Copy the `pi/` structure as a starting point.
3. Update `scripts/sync-skills.sh` to include the new adapter.
4. Update `scripts/run-all.sh`.

---

## Install Agent Deck

```sh
# Linux / WSL (one-liner)
curl -fsSL https://raw.githubusercontent.com/asheshgoplani/agent-deck/main/install.sh | bash

# Then launch
agent-deck
```

See the [Agent Deck docs](https://agent-deck.com) for Homebrew / Go install paths.

---

## License

See the repository root `LICENSE` file.
