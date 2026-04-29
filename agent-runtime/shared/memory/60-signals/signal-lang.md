# Signal-Lang Specification

> Version: 1.0.0
> Status: accepted (see ADR-001)

---

## 1. Overview

Signal-lang is a lightweight, deterministic interchange format for agent-to-agent communication inside `agent-runtime/`.
It uses **YAML blocks embedded in Markdown** so signals are:

- Human-readable in any text editor or on GitHub.
- Parseable with a standard YAML library (no custom parser needed).
- Validatable against `signal-schema.json`.

A signal is **not** a chat message. It is a structured envelope that conveys:

- **What** an agent did or intends to do.
- **Why** (the triggering context).
- **Who** should act next (handoff target).
- **Constraints** on that action.

---

## 2. Signal Anatomy

Every signal is a fenced YAML block with the type tag `signal`:

~~~markdown
```yaml signal
version: "1.0"
type: <signal-type>
id: <uuid-or-slug>
from: <agent-id>
to: <agent-id | broadcast>
session: <session-id>
timestamp: <ISO-8601>
payload:
  # type-specific fields
tags: [<tag>, ...]
```
~~~

### 2.1 Top-level fields

| Field | Required | Type | Description |
|-------|----------|------|-------------|
| `version` | ✓ | string | Always `"1.0"` for this spec version |
| `type` | ✓ | string | One of the signal types defined in §3 |
| `id` | ✓ | string | Unique signal identifier (UUID v4 or `<date>-<slug>`) |
| `from` | ✓ | string | Emitting agent ID (`planner`, `implementer`, `reviewer`, `pi`) |
| `to` | ✓ | string | Receiving agent ID or `broadcast` |
| `session` | ✓ | string | Session ID from `30-sessions/` filename |
| `timestamp` | ✓ | string | ISO-8601 datetime |
| `payload` | ✓ | object | Type-specific content (see §3) |
| `tags` | | array | Optional tags for indexing |

---

## 3. Signal Types

### 3.1 `task-request`

A Planner → any agent task delegation.

**Payload fields:**

| Field | Required | Description |
|-------|----------|-------------|
| `title` | ✓ | Short task title |
| `description` | ✓ | Full task description |
| `priority` | ✓ | `critical` / `high` / `medium` / `low` |
| `deadline` | | ISO-8601 date or `null` |
| `context_refs` | | List of memory paths to read before starting |
| `acceptance_criteria` | ✓ | List of strings: what "done" means |

### 3.2 `handoff`

Signals that one agent has finished its part and another should continue.

**Payload fields:**

| Field | Required | Description |
|-------|----------|-------------|
| `summary` | ✓ | What was accomplished |
| `artefacts` | | List of files or memory paths produced |
| `next_action` | ✓ | What the receiving agent should do first |
| `open_questions` | | List of unresolved items |

### 3.3 `constraint`

Records a hard constraint on a task or system.

**Payload fields:**

| Field | Required | Description |
|-------|----------|-------------|
| `constraint` | ✓ | The constraint statement |
| `scope` | ✓ | What the constraint applies to (task / project / global) |
| `rationale` | ✓ | Why this constraint exists |
| `override_by` | | Agent or role that may override it |

### 3.4 `memory-write`

Declares intent to write to a memory layer before doing so.

**Payload fields:**

| Field | Required | Description |
|-------|----------|-------------|
| `target_path` | ✓ | Relative path under `shared/memory/` |
| `operation` | ✓ | `append` / `create` / `archive` |
| `summary` | ✓ | What will be written |
| `rationale` | ✓ | Why this memory write is needed |

### 3.5 `review-request`

Implementer → Reviewer: asks for a review.

**Payload fields:**

| Field | Required | Description |
|-------|----------|-------------|
| `artefacts` | ✓ | Files or memory paths to review |
| `review_type` | ✓ | `code` / `doc` / `risk` / `full` |
| `vram_required_gb` | | Minimum VRAM in GB (triggers VRAM gate if set) |
| `checklist` | | Review checklist items |

---

## 4. Deterministic Normalisation Rules

When emitting a signal, agents MUST apply these normalisation rules:

1. **Field order** is canonical: `version`, `type`, `id`, `from`, `to`, `session`, `timestamp`, `payload`, `tags`.
2. **`id`** format: `<YYYYMMDD>-<agent-id>-<slug>` (e.g. `20260429-planner-init-task`).
3. **`timestamp`** is always UTC ISO-8601 with seconds: `2026-04-29T04:51:00Z`.
4. **`tags`** are lowercase, hyphen-separated, sorted alphabetically.
5. **String values** use double quotes.
6. No trailing whitespace; signals are terminated by a blank line after the closing fence.

---

## 5. Parsing (Conceptual "12-bit" Determinism)

The name "12-bit parser" refers to a conceptual discipline, not literal bit manipulation.
It means the parser operates on exactly **12 fixed field slots** (the top-level keys in §2.1 plus type-specific payload) with no dynamic schema inference.

**Practical implementation:**

```
parse(block):
  yaml = yaml.safe_load(block)
  validate(yaml, signal-schema.json)
  normalise(yaml)          # apply §4 rules
  dispatch(yaml.type, yaml.payload)
```

No reflection, no dynamic field discovery. If a field is unknown, it is rejected.

---

## 6. Storage

Signals are appended to the current session file in `30-sessions/` under the **Signals Emitted** section.
Optionally, high-importance signals (constraints, ADR-triggering decisions) are also copied to the relevant project pack in `20-projects/`.

---

## 7. Versioning

The spec version is `1.0`. Breaking changes require a new ADR and a version bump.
Additive changes (new signal types, new optional payload fields) are non-breaking and may be released as `1.x` patches.
