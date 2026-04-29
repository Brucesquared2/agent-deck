# Shared Skills Library

This directory holds reusable skill definitions for OpenCode, Aider, and Pi.

## Structure

```
shared/skills/
├── README.md          ← this file
├── _template.md       ← copy when adding a new skill
└── <category>/
    └── <skill-name>.md
```

## Skill Categories

| Category | Description |
|----------|-------------|
| `git/`   | Git workflow helpers |
| `code/`  | Code generation / editing patterns |
| `infra/` | Infrastructure and DevOps tasks |
| `ml/`    | ML/AI model management |
| `memory/`| Memory hygiene helpers |
| `review/`| Review and quality gate patterns |

## Adding a Skill

1. Copy `_template.md` to the appropriate category folder.
2. Fill in `name`, `description`, `inputs`, `steps`, and `outputs`.
3. Run `scripts/sync-skills.sh` to propagate it to adapter dirs.

## TODO
- Populate categories with real skill files (placeholder only)
