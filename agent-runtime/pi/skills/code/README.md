# Skill: code

Code generation, editing, refactoring, and explanation skills.

## Prompts

### generate-function

```
Write a {{language}} function named {{name}} that:
- Accepts: {{inputs}}
- Returns: {{output}}
- Behaviour: {{description}}
Follow the conventions in the existing codebase.
Include a docstring and unit tests.
```

### explain-code

```
Explain the following code in plain English.
Describe what it does, any edge cases it handles, and any potential issues:

{{code}}
```

### refactor

```
Refactor the following code to improve {{goal}} (e.g. readability, performance, testability).
Do not change the external behaviour.
Explain each change you make:

{{code}}
```

### fix-bug

```
The following code has a bug described as: {{bug_description}}
Fix the bug and explain what caused it:

{{code}}
```
