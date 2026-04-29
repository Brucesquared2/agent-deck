# Shared Skills

Skills are reusable capability modules that any agent (Planner, Implementer, Reviewer, PI) can invoke.

## Structure

```
skills/
  memory/         # Memory read/write helpers
  code/           # Code generation, linting, patching
  repo/           # Git operations, PR creation, branch management
  qa/             # Test running, coverage checks, diff review
```

## Skill Format

Each skill is a Markdown file with:

1. **Frontmatter** (YAML): `id`, `description`, `inputs`, `outputs`
2. **Prompt block**: the actual instruction template
3. **Examples**: sample invocations

## Using a Skill

Reference a skill by its path from any agent prompt:

```
@skill memory/write-session-log
@skill code/apply-patch
@skill repo/create-pr
```

## Adding a Skill

1. Create `skills/<category>/<skill-name>.md`
2. Fill in the frontmatter and prompt block
3. Add an entry to this README
4. Run `scripts/sync-skills.sh` to propagate to adapter runtimes
