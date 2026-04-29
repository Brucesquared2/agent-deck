# Shared Skills

This directory contains reusable skill packs shared across all runtime adapters.

## Structure

```
skills/
├── README.md       ← this file
├── memory/         ← memory management skills
├── code/           ← code generation / editing skills
├── repo/           ← git / repo management skills
└── qa/             ← quality assurance / testing skills
```

## What is a skill?

A skill is a packaged, reusable capability. Each skill folder contains:

- `README.md` — describes what the skill does and how to invoke it
- One or more prompt template files (`.md`)
- Optional supporting scripts or config fragments

## How skills are distributed

Run `bash scripts/sync-skills.sh` from the `agent-runtime/` root to copy the
contents of this directory into each adapter's `skills/` folder. The sync is a
plain file copy (no symlinks) so it works on any platform.

## Adding a skill

1. Create a new folder under the appropriate category (or add a new category folder).
2. Add a `README.md` explaining the skill's purpose, inputs, and expected outputs.
3. Add prompt template(s) as `.md` files.
4. Run `bash scripts/sync-skills.sh`.

## Skill categories

| Category | Purpose |
|----------|---------|
| `memory/` | Read/write scratchpad, decisions, glossary |
| `code/` | Code generation, refactoring, explanation |
| `repo/` | Git operations, PR creation, branch management |
| `qa/` | Test generation, test review, coverage analysis |
