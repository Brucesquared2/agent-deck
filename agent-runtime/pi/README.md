# Pi Adapter

This directory contains the Pi coding-agent runtime adapter for the agent-runtime system.

## What is Pi?

Pi is an experimental, extensible coding-agent runtime. It is designed to be
customised and extended — making it ideal for novel agent configurations, research,
and specialised workflows that don't fit neatly into OpenCode or Aider.

In this system, Pi is used for the **PI (Principal Investigator)** agent role:
research, specification writing, and product intelligence.

## Directory structure

```
pi/
├── README.md      ← this file
├── AGENTS.md      ← Pi agent definitions (Pi-native format)
├── prompts/       ← Pi prompt templates
├── skills/        ← skill packs (copied from shared/skills by sync-skills.sh)
└── scripts/
    └── pi-run.sh  ← convenience launch script
```

## Setup

1. Install Pi (see your Pi distribution or `pi-mono` for installation instructions).
2. Sync shared assets:
   ```sh
   bash ../scripts/sync-skills.sh
   ```
3. Set your API key:
   ```sh
   export ANTHROPIC_API_KEY=sk-ant-...
   ```
4. Run:
   ```sh
   bash scripts/pi-run.sh
   # or
   bash ../scripts/run-pi.sh
   ```

## Configuration

Edit `AGENTS.md` to define Pi agent personas and capabilities.
Add prompt templates to `prompts/` and reference them from `AGENTS.md`.

## Notes

- Skills in `skills/` are auto-synced from `shared/skills/`. Do not edit them here.
- Pi's exact configuration format depends on the Pi distribution you are using.
  The files here are placeholders — adapt them to your Pi version.
- See `shared/agents/pi.md` for the canonical PI agent prompt.
