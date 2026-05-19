# Conductors

Conductors are persistent supervisor agents managed by Agent Deck.

## Purpose

A conductor watches a session and:
- Restarts it if it crashes
- Emits a signal when a session completes
- Routes signals between sessions

## Conductor Files

Each conductor is a TOML file:

```toml
[conductor]
name        = "main-conductor"
watch       = ["opencode", "aider", "pi"]
on_complete = "signal:TASK_DONE"
on_fail     = "signal:INCIDENT"
restart     = true
```

## Adding a Conductor

1. Create `conductors/<name>.toml` using the template above.
2. Ensure your Agent Deck deployment is configured to load conductor files from the `conductors/` directory using its existing config layout.
3. Restart Agent Deck.

> Note: This repository does not define a `[conductors]` section in `config.toml`, so do not add one unless your local Agent Deck configuration schema explicitly supports it.

## Signal Routing

Conductors can route signals between sessions:

```toml
[[conductor.routes]]
from    = "implementer"
signal  = "TASK_DONE"
to      = "reviewer"
```
