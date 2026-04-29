# Skill: repo

Git repository management skills — branching, committing, and PR workflows.

## Prompts

### create-branch

```
Create a new git branch named {{branch_name}} from {{base_branch}}.
Use a conventional name format: <type>/<short-description>
(e.g. feat/add-login, fix/null-pointer, chore/update-deps)
```

### write-commit-message

```
Write a conventional commit message for the following change:
{{diff_summary}}

Format: <type>(<scope>): <short description>
Types: feat, fix, docs, style, refactor, test, chore
Keep the subject line under 72 characters.
```

### create-pr-description

```
Write a pull request description for the following change:
- Branch: {{branch}}
- Summary of changes: {{summary}}
- Related issue (if any): {{issue}}

Include: What, Why, How, and Testing sections.
```

### review-diff

```
Review the following git diff and identify:
1. Any bugs or logic errors
2. Missing tests
3. Security concerns
4. Style violations

{{diff}}
```
