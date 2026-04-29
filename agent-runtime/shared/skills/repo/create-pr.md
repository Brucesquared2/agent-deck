---
id: repo/create-pr
description: Create a GitHub pull request for the current branch
inputs:
  - title: string
  - body: string
  - base: string (default "main")
  - draft: bool (default false)
outputs:
  - pr_url: string
  - pr_number: int
---

# Skill: create-pr

## Prompt

Create a pull request from the current branch to `{base}`.

Steps:
1. Ensure all changes are committed.
2. Push the branch if not already pushed.
3. Create PR with `gh pr create --title "{title}" --body "{body}" --base {base}`.
4. If `draft` is true, add `--draft` flag.
5. Return the PR URL and number.

## Example

```
@skill repo/create-pr
title: "feat: add OAuth2 token refresh"
body: "Implements the token refresh flow. Closes #42."
base: main
draft: false
```
