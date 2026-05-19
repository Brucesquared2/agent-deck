---
id: code/apply-patch
description: Apply a unified diff patch to the working tree
inputs:
  - patch: string (unified diff)
  - dry_run: bool (default false)
outputs:
  - applied: bool
  - rejected_hunks: list of strings
---

# Skill: apply-patch

## Prompt

Apply the provided unified diff to the working tree.

Steps:
1. Validate the patch is well-formed.
2. If `dry_run` is true, report what would change without modifying files.
3. Apply with `git apply --3way`.
4. Report any rejected hunks.

## Example

```
@skill code/apply-patch
dry_run: true
patch: |
  --- a/src/main.go
  +++ b/src/main.go
  @@ -10,6 +10,7 @@
     fmt.Println("hello")
  +  fmt.Println("world")
```
