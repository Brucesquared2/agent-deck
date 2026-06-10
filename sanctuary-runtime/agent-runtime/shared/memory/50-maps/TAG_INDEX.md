# Tag Index

Canonical tags used across the memory system.  Every memory file should carry
at least one tag from this list.  Add new tags here before using them.

## Format
```
#<tag>  →  <description>  [<example-links>]
```

## Core Tags

| Tag | Description | Example links |
|-----|-------------|---------------|
| `#agent` | Relates to an AI agent definition or behavior | `00-core/charter.md` |
| `#architecture` | System or service architecture | `20-projects/` |
| `#decision` | A recorded design or direction decision | `50-maps/DECISION_LOG.md` |
| `#gpu` | GPU / VRAM / compute topics | `60-signals/` |
| `#incident` | Incident post-mortem | `10-ops/incidents/` |
| `#infra` | Infrastructure, DevOps, containers | `sanctuary-runtime/telemetry/` |
| `#knowledge` | Promoted reusable fact or pattern | `40-knowledge/` |
| `#memory` | Memory system itself | `50-maps/` |
| `#ml` | Machine learning models, inference | |
| `#ops` | Operational runbook or procedure | `10-ops/runbooks/` |
| `#pattern` | Reusable code or design pattern | `40-knowledge/patterns/` |
| `#project` | Project-specific notes | `20-projects/` |
| `#research` | PI research output | `40-knowledge/research/` |
| `#review` | Reviewer findings | `60-signals/` |
| `#security` | Security-relevant item | `00-core/policies.md` |
| `#session` | Session log or summary | `30-sessions/` |
| `#signal` | Signal-Lang signal | `60-signals/` |
| `#skill` | Shared skill definition | `shared/skills/` |
| `#telemetry` | Metrics and monitoring | `sanctuary-runtime/telemetry/` |
| `#vram` | VRAM usage, gate, teleport | `sanctuary-runtime/telemetry/` |

## Adding a Tag
1. Choose a short lowercase slug with no spaces.
2. Add it to this table with a description and at least one example link.
3. Run `scripts/refresh-indexes.sh` to propagate.

## Last Refreshed
<!-- Updated automatically by refresh-indexes.sh -->
_Not yet refreshed._
