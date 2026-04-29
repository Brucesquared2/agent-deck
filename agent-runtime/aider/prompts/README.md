# Aider Prompts

Place custom system message or prompt template files (`.md`) here.

These are referenced from `aider.conf.yml` via the `read` or `system-prompt` keys,
or passed directly on the command line with `--read prompts/<file>.md`.

## Provided prompts

_None yet — add your own here._

## Example: using a prompt file

```sh
aider --config aider.conf.yml --read prompts/implementer-context.md
```

Or add to `aider.conf.yml`:

```yaml
read:
  - prompts/implementer-context.md
  - ../shared/memory/decisions.md
```
