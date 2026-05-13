# Signal-Lang Examples

Concrete examples of every major signal type.

---

## task.plan — Planner → Implementer

```yaml
signal: task.plan
id: 2026-04-29T1200Z_agentdeck_memory_scaffold
lane: 3
from: planner
to: implementer
intent: "Implement sanctuary-runtime memory scaffold in agent-deck repo"
constraints:
  - "POSIX sh for all shell scripts"
  - "No external runtime dependencies"
  - "Do not modify files outside sanctuary-runtime/"
outputs_expected:
  - "sanctuary-runtime/agent-runtime/shared/memory/ taxonomy"
  - "sanctuary-runtime/telemetry/ DCGM stack"
  - "sanctuary-runtime/bridge/ helpers"
  - "sanctuary-runtime/README.md"
```

---

## task.progress — Implementer status update

```yaml
signal: task.progress
id: 2026-04-29T1345Z_agentdeck_memory_scaffold_progress
lane: 3
from: implementer
to: reviewer
status: in_progress
artifacts:
  - "sanctuary-runtime/agent-runtime/shared/memory/50-maps/INDEX.md"
  - "sanctuary-runtime/agent-runtime/shared/memory/60-signals/signal-lang.md"
blockers: []
```

---

## task.complete — Implementer done

```yaml
signal: task.complete
id: 2026-04-29T1500Z_agentdeck_memory_scaffold_complete
lane: 3
from: implementer
to: reviewer
artifacts:
  - "sanctuary-runtime/"
```

---

## review.findings — Reviewer result

```yaml
signal: review.findings
id: 2026-04-29T1530Z_agentdeck_memory_scaffold_review
lane: 5
from: reviewer
to: planner
approved: true
vram_check: skipped
findings:
  - severity: info
    message: "All scripts are POSIX-compatible sh"
  - severity: info
    message: "No external dependencies introduced"
```

---

## review.findings — Reviewer blocks (VRAM failure)

```yaml
signal: review.findings
id: 2026-04-29T1600Z_llm_inference_review
lane: 5
from: reviewer
to: planner
approved: false
vram_check: failed
findings:
  - severity: blocking
    message: "VRAM usage at 87% — teleport blocked until usage drops below 80%"
  - severity: warning
    message: "GPU temp at 82°C — throttle warning active"
```

---

## research.findings — PI output

```yaml
signal: research.findings
id: 2026-04-29T0900Z_awesome_agent_skills_research
lane: 6
from: pi
to: planner
topic: "awesome-agent-skills library evaluation"
findings:
  - entity: "VoltAgent/awesome-agent-skills"
    url: "https://github.com/VoltAgent/awesome-agent-skills"
    relevance: "1000+ curated real-world skills for Stripe, Cloudflare, etc."
    suggested_action: add_skill
  - entity: "joshuadavidthomas/opencode-agent-skills"
    url: "https://github.com/joshuadavidthomas/opencode-agent-skills"
    relevance: "Dynamic plugin for OpenCode skill discovery and context injection"
    suggested_action: evaluate
```

---

## constraint.vram — VRAM constraint notice

```yaml
signal: constraint.vram
id: 2026-04-29T1555Z_vram_gate
lane: 7
from: system
to: broadcast
vram_pct: 87
temp_c: 82
action: block
```
