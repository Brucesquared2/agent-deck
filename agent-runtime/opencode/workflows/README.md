# OpenCode Workflows

Place OpenCode workflow template files here.

A workflow is a multi-step sequence of agent actions that OpenCode can execute
automatically. See the [OpenCode docs](https://opencode.ai/docs/workflows) for
the workflow file format.

## Example workflow structure

```json
{
  "name": "feature-workflow",
  "steps": [
    { "agent": "pi",          "task": "Research and spec the feature" },
    { "agent": "planner",     "task": "Break the spec into tasks" },
    { "agent": "implementer", "task": "Implement the tasks" },
    { "agent": "reviewer",    "task": "Review the implementation" }
  ]
}
```

## Adding workflows

1. Create a `.json` or `.yaml` file in this directory.
2. Reference the agent names defined in `opencode.config.json`.
3. Run the workflow with: `opencode workflow run <name>`
