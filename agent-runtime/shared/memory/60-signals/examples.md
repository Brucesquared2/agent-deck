# Signal-Lang Examples

> Worked examples for each signal type defined in `signal-lang.md`.
> Copy and adapt these into your session files.

---

## Example 1 — Task Request (Planner → Implementer)

```yaml signal
version: "1.0"
type: "task-request"
id: "20260429-planner-init-memory-layer"
from: "planner"
to: "implementer"
session: "2026-04-29-bootstrap"
timestamp: "2026-04-29T04:51:00Z"
payload:
  title: "Scaffold agent-runtime memory layer"
  description: >
    Create the full shared/memory/ taxonomy under agent-runtime/ including
    all folders, templates, map files, and the signal-lang spec.
  priority: "high"
  deadline: null
  context_refs:
    - "shared/memory/00-core/policies.md"
    - "shared/memory/50-maps/MEMORY_MAP.md"
  acceptance_criteria:
    - "All 8 taxonomy folders exist with at least one file each"
    - "50-maps/ contains MEMORY_MAP, INDEX, TAG_INDEX, ENTITY_INDEX, DECISION_LOG"
    - "60-signals/ contains signal-lang.md, examples.md, signal-schema.json"
    - "scripts/new-session.sh and scripts/refresh-indexes.sh are executable"
tags: ["bootstrap", "memory", "task-request"]
```

---

## Example 2 — Handoff (Implementer → Reviewer)

```yaml signal
version: "1.0"
type: "handoff"
id: "20260429-implementer-memory-layer-done"
from: "implementer"
to: "reviewer"
session: "2026-04-29-bootstrap"
timestamp: "2026-04-29T05:30:00Z"
payload:
  summary: >
    Memory layer scaffold is complete. All folders, templates, map files,
    signal-lang spec, and scripts have been created under agent-runtime/.
  artefacts:
    - "agent-runtime/shared/memory/00-core/policies.md"
    - "agent-runtime/shared/memory/50-maps/MEMORY_MAP.md"
    - "agent-runtime/shared/memory/60-signals/signal-lang.md"
    - "agent-runtime/shared/memory/60-signals/signal-schema.json"
    - "scripts/new-session.sh"
    - "scripts/refresh-indexes.sh"
    - "scripts/reviewer-vram-check.sh"
    - "agent-runtime/README.md"
  next_action: >
    Review the signal-lang spec and schema for correctness, then
    check that all scripts are POSIX-sh compatible and executable.
  open_questions:
    - "Should signal blocks be validated in CI? If so, which workflow?"
tags: ["bootstrap", "handoff", "memory"]
```

---

## Example 3 — Constraint

```yaml signal
version: "1.0"
type: "constraint"
id: "20260429-planner-posix-sh-constraint"
from: "planner"
to: "broadcast"
session: "2026-04-29-bootstrap"
timestamp: "2026-04-29T04:52:00Z"
payload:
  constraint: "All scripts under scripts/ MUST be POSIX sh compatible."
  scope: "global"
  rationale: >
    The system must run on Linux, macOS, and WSL without requiring bash 4+
    or GNU-only utilities. POSIX sh is the lowest common denominator.
  override_by: null
tags: ["constraint", "global", "scripts"]
```

---

## Example 4 — Memory Write Intent

```yaml signal
version: "1.0"
type: "memory-write"
id: "20260429-pi-adr-signal-lang"
from: "pi"
to: "planner"
session: "2026-04-29-bootstrap"
timestamp: "2026-04-29T06:00:00Z"
payload:
  target_path: "shared/memory/50-maps/DECISION_LOG.md"
  operation: "append"
  summary: >
    Appending ADR-001: decision to use YAML-in-Markdown as the
    signal-lang format instead of a terse .signal log format.
  rationale: >
    The PI agent researched the trade-offs between YAML-in-Markdown,
    TOML, and a custom .signal format. YAML-in-Markdown has the best
    tooling support and is already used in the existing codebase.
tags: ["adr", "decision-log", "memory-write", "signal-lang"]
```

---

## Example 5 — Review Request

```yaml signal
version: "1.0"
type: "review-request"
id: "20260429-implementer-review-scripts"
from: "implementer"
to: "reviewer"
session: "2026-04-29-bootstrap"
timestamp: "2026-04-29T05:45:00Z"
payload:
  artefacts:
    - "scripts/new-session.sh"
    - "scripts/refresh-indexes.sh"
    - "scripts/reviewer-vram-check.sh"
    - "scripts/run-all.sh"
  review_type: "code"
  vram_required_gb: null
  checklist:
    - "Scripts use #!/bin/sh shebang (not bash)"
    - "No GNU-only flags (e.g., date -Iseconds is GNU-only; use date -u +%Y-%m-%dT%H:%M:%SZ)"
    - "Scripts exit non-zero on error"
    - "All scripts are chmod +x"
tags: ["bootstrap", "review-request", "scripts"]
```
