# Signal-Lang Specification

Signal-Lang is a **YAML-in-Markdown** micro-language for deterministic agent
handoffs and constraint records.  It is intentionally minimal: fixed required
fields, strict enums, and machine-parseable blocks embedded in human-readable
Markdown.

## Design Goals
1. **Human-readable** — Markdown prose can surround signal blocks.
2. **Machine-parseable** — every signal block is valid YAML and validates against
   `signal-schema.json`.
3. **Deterministic** — required fields and enum constraints eliminate ambiguity.
4. **Agent-agnostic** — works with OpenCode, Aider, Pi, and any future runtime.

## Signal Block Syntax

Signal blocks are fenced YAML code blocks with the language tag `yaml`:

````
```yaml
signal: <signal-type>
id: <id>
... fields ...
```
````

Blocks MUST appear at the start of a document (first code block) or after a
`## Signal` heading.

## Required Fields (all signals)

| Field | Type | Description |
|-------|------|-------------|
| `signal` | string (enum) | Signal type — see table below |
| `id` | string | `<ISO8601-compact>_<slug>`, e.g. `2026-04-29T1234Z_agentdeck_plan` |
| `lane` | integer 1–9 | Work lane |
| `from` | string (enum) | Originating agent role |
| `to` | string (enum) | Receiving agent role or `broadcast` |

## Signal Types

| Value | Meaning |
|-------|---------|
| `task.plan` | Planner → Implementer plan handoff |
| `task.progress` | Implementer status update |
| `task.complete` | Implementer signals completion |
| `review.findings` | Reviewer quality gate result |
| `research.findings` | PI research output |
| `constraint.vram` | VRAM / GPU constraint notice |
| `constraint.generic` | Generic runtime constraint |
| `system.alert` | System-level alert (telemetry, maintenance) |

## Agent Roles (enum)

`planner` | `implementer` | `reviewer` | `pi` | `system` | `broadcast`

## Lane Definitions

| Lane | Description |
|------|-------------|
| 1 | Triage / investigation |
| 2 | Design / architecture |
| 3 | Implementation (complex, multi-file) |
| 4 | Implementation (surgical, single-file) |
| 5 | Review / QA |
| 6 | Research / PI |
| 7 | Infra / DevOps |
| 8 | Documentation |
| 9 | Maintenance / housekeeping |

## Optional Fields

| Field | Applicable to | Description |
|-------|--------------|-------------|
| `intent` | task.plan | One-line summary of the task |
| `constraints` | task.plan | Array of free-text constraints |
| `outputs_expected` | task.plan | Array of expected artifacts |
| `status` | task.progress | `in_progress` \| `blocked` \| `complete` |
| `blockers` | task.progress | Array of blockers |
| `artifacts` | task.progress, task.complete | Array of file paths or commit refs |
| `approved` | review.findings | `true` \| `false` |
| `vram_check` | review.findings | `passed` \| `failed` \| `skipped` |
| `findings` | review.findings | Array of finding objects |
| `topic` | research.findings | Research topic string |
| `findings` | research.findings | Array of finding objects |
| `vram_pct` | constraint.vram | VRAM usage percentage |
| `temp_c` | constraint.vram | GPU temperature in Celsius |
| `action` | constraint.vram | `block` \| `warn` \| `throttle` |

## Parsing

Any YAML parser can read signal blocks.  For strict validation, use
`signal-schema.json` with a JSON Schema validator after converting YAML → JSON.

## Versioning

This spec is version **1.0**.  Append `-v<N>` to the `signal` type if you need
a breaking change: `task.plan-v2`.
