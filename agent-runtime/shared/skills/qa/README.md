# Skill: qa

Quality assurance and testing skills — test generation, review, and coverage analysis.

## Prompts

### generate-tests

```
Write {{test_framework}} tests for the following code.
Cover: happy path, edge cases, and error conditions.
{{code}}
```

### review-test-coverage

```
Review the test file below and identify:
1. Untested code paths
2. Weak assertions (e.g. assertTrue(true))
3. Missing edge cases
4. Any tests that are brittle or hard to maintain

{{test_code}}
```

### write-test-plan

```
Write a test plan for the following feature:
{{feature_description}}

Include:
- Unit tests (what functions/methods to test)
- Integration tests (what interactions to test)
- Edge cases
- Performance considerations (if any)
```

### analyze-failure

```
A test is failing with the following output:
{{test_output}}

The relevant code is:
{{code}}

Diagnose the failure and suggest a fix.
```
