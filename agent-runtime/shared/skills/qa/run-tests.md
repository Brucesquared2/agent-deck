---
id: qa/run-tests
description: Run the project test suite and report results
inputs:
  - filter: string (optional, test name pattern)
  - race: bool (default true for Go projects)
outputs:
  - passed: int
  - failed: int
  - output: string
---

# Skill: run-tests

## Prompt

Run the test suite for the current project.

Steps:
1. Detect runtime: Go (`go test`), Node (`npm test`), Python (`pytest`), etc.
2. Run with race detection if `race` is true and runtime supports it.
3. Apply `filter` if provided.
4. Parse output and return counts.

## Example

```
@skill qa/run-tests
filter: TestMemory
race: true
```
