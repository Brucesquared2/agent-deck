# Conductors

A **conductor** is a persistent supervisor agent in Agent Deck. It watches one or
more sessions, coordinates handoffs between agents, and keeps the overall workflow
moving without manual intervention.

## What conductors do

- Monitor session outputs for completion signals or errors.
- Trigger the next agent in a workflow pipeline.
- Escalate to a human when an agent is blocked.
- Maintain a shared task queue (backed by `shared/memory/scratchpad.md`).

## Adding a conductor

1. Create a conductor config file in this directory (e.g. `pipeline-conductor.toml`).
2. Reference it in `agent-deck/config.toml`:
   ```toml
   [[conductors]]
   name   = "pipeline"
   config = "./agent-deck/conductors/pipeline-conductor.toml"
   ```
3. Start Agent Deck — conductors are launched automatically.

## Example conductor config (placeholder)

```toml
# pipeline-conductor.toml
name = "pipeline"

[[watch]]
session = "planner"
on_complete = "implementer"   # hand off to implementer when planner finishes

[[watch]]
session = "implementer"
on_complete = "reviewer"      # hand off to reviewer when implementer finishes

[[watch]]
session = "reviewer"
on_approve  = "done"          # mark pipeline done on reviewer approval
on_reject   = "implementer"   # send back to implementer on rejection
```

## Notes

- Conductor config format depends on your Agent Deck version.
  Run `agent-deck conductor --help` for the current schema.
- Conductors are optional — Agent Deck works perfectly well in manual mode.
- See the [Agent Deck conductors docs](https://agent-deck.com/docs/conductors) for
  the full feature reference.
