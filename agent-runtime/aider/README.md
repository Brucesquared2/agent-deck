# Aider Adapter

This directory contains the Aider runtime adapter for the agent-runtime system.

## What is Aider?

[Aider](https://aider.chat) is a focused file-editing and code-patch AI coding tool.
It works directly with your git repository, making precise edits and committing them
with meaningful messages. It is particularly well-suited for the Implementer agent role.

## Directory structure

```
aider/
├── README.md          ← this file
├── aider.conf.yml     ← Aider configuration
├── prompts/           ← aider prompt / system message files
├── skills/            ← skill packs (copied from shared/skills by sync-skills.sh)
└── scripts/
    └── aider-run.sh   ← convenience launch script
```

## Setup

1. Install Aider:
   ```sh
   pip install aider-chat
   # or
   brew install aider
   ```
2. Sync shared assets:
   ```sh
   bash ../scripts/sync-skills.sh
   ```
3. Set your API key:
   ```sh
   export ANTHROPIC_API_KEY=sk-ant-...
   # or OPENAI_API_KEY, GEMINI_API_KEY, etc.
   ```
4. Run:
   ```sh
   bash scripts/aider-run.sh
   # or
   bash ../scripts/run-aider.sh
   ```

## Configuration

Edit `aider.conf.yml` to change the model, enable/disable auto-commits, set the
read-only files list, etc.

## Adding prompts

Place custom system message files (`.md`) in `prompts/`. Reference them from
`aider.conf.yml` via the `system-prompt` or `read` keys.

## Notes

- Skills in `skills/` are auto-synced from `shared/skills/`. Do not edit them here.
- Aider commits changes automatically by default. Set `auto-commits: false` in
  `aider.conf.yml` to review before committing.
