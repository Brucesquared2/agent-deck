# Sanctuary Runtime

> Memory-first Agentic OS scaffold for the Agent Deck cluster.

The Sanctuary Runtime lives under `sanctuary-runtime/` in this repository.
It provides the **Unified Intelligence Layer** on top of Agent Deck: a shared
memory substrate, Signal-Lang for deterministic agent handoffs, a DCGM-first
GPU telemetry stack, and bridge helpers for Windows/WSL and Android/Termux.

---

## Architecture Overview

```
sanctuary-runtime/
├── agent-runtime/          ← Memory layer + agent roles + scripts
│   ├── shared/
│   │   ├── agents/         ← Planner, Implementer, Reviewer, PI runbooks
│   │   ├── skills/         ← Shared skill library (synced to adapters)
│   │   └── memory/         ← Numbered taxonomy (00-core … 90-archive)
│   │       ├── 00-core/    ← Principles, policies, charter
│   │       ├── 10-ops/     ← Runbooks, incidents, maintenance
│   │       ├── 20-projects/← Per-repo project packs
│   │       ├── 30-sessions/← Dated session logs + summaries
│   │       ├── 40-knowledge/← Curated facts and reusable patterns
│   │       ├── 50-maps/    ← Index, memory map, tag/entity indexes, decisions
│   │       ├── 60-signals/ ← Signal-Lang spec, examples, schema
│   │       └── 90-archive/ ← Frozen, immutable history
│   ├── opencode/           ← OpenCode adapter placeholder
│   ├── aider/              ← Aider adapter placeholder
│   ├── pi/                 ← Pi adapter placeholder
│   └── scripts/            ← Maintenance scripts
│       ├── sync-skills.sh
│       ├── new-session.sh
│       ├── summarize-session.sh
│       ├── refresh-indexes.sh
│       └── vram_teleport.py
├── telemetry/              ← DCGM-first GPU telemetry stack
│   ├── docker-compose.dcgm-node.yml
│   ├── docker-compose.prometheus-hub.yml
│   ├── prometheus.yml
│   ├── reviewer-vram-check.sh
│   ├── docs/
│   │   └── GPU_TELEMETRY_LAYER.md
│   └── scripts/
│       └── install-nvidia-container-toolkit.sh
└── bridge/
    ├── powershell/
    │   └── profile-snippets.ps1   ← Windows/WSL wrappers
    └── termux/
        └── install-termux-bridge.sh ← Android Termux SSH bridge
```

### The Tri-Arch

| Layer | Component | Role |
|-------|-----------|------|
| **Cockpit** | Agent Deck | TUI mission control; manages worktrees, monitors nodes |
| **Brain** | Signal-Lang + memory taxonomy | Deterministic handoffs and durable context |
| **Runtimes** | OpenCode / Aider / Pi | Task executors (complex archi / surgical edits / research) |

---

## Memory Taxonomy

The memory system is organized into numbered folders under `shared/memory/`:

| Folder | Purpose |
|--------|---------|
| `00-core/` | Identity, principles, policies — changes rarely |
| `10-ops/` | Runbooks, incidents, maintenance procedures |
| `20-projects/` | Per-repo project packs (requirements, architecture, decisions) |
| `30-sessions/` | Dated session raw logs and summaries |
| `40-knowledge/` | Curated facts and patterns promoted from sessions |
| `50-maps/` | Index files: INDEX, MEMORY_MAP, TAG_INDEX, ENTITY_INDEX, DECISION_LOG |
| `60-signals/` | Signal-Lang spec, examples, JSON schema |
| `90-archive/` | Frozen, immutable history |

### Lifecycle

```
Raw session log (30-sessions/*/raw.md)
       ↓  summarize-session.sh
Session summary (30-sessions/*/summary.md)
       ↓  promote
Curated knowledge (40-knowledge/)
       ↓  refresh-indexes.sh
Updated indexes (50-maps/)
       ↓  when old
Archive (90-archive/)
```

### Memory Maps (50-maps)

| File | Description |
|------|-------------|
| `INDEX.md` | Human front door — start here |
| `MEMORY_MAP.md` | Rules for what belongs where |
| `TAG_INDEX.md` | Canonical tags → file links |
| `ENTITY_INDEX.md` | People, tools, repos, components → file links |
| `DECISION_LOG.md` | ADR-lite record of all significant decisions |

---

## Signal-Lang

Signal-Lang is a YAML-in-Markdown micro-language for agent handoffs.

### Quick Example

```yaml
signal: task.plan
id: 2026-04-29T1200Z_add_vram_gate
lane: 7
from: planner
to: implementer
intent: "Add VRAM gate to reviewer workflow"
constraints:
  - "POSIX sh"
  - "No extra pip dependencies"
outputs_expected:
  - "sanctuary-runtime/telemetry/reviewer-vram-check.sh"
```

### Key Files

| File | Description |
|------|-------------|
| `shared/memory/60-signals/signal-lang.md` | Full specification |
| `shared/memory/60-signals/examples.md` | One example per signal type |
| `shared/memory/60-signals/signal-schema.json` | JSON Schema for validation |

### Supported Signal Types

`task.plan` · `task.progress` · `task.complete` · `review.findings` ·
`research.findings` · `constraint.vram` · `constraint.generic` · `system.alert`

---

## Quickstart: Telemetry (GPU nodes)

### 1. Install NVIDIA Container Toolkit (each GPU node)

```sh
sudo bash sanctuary-runtime/telemetry/scripts/install-nvidia-container-toolkit.sh
```

### 2. Start DCGM exporter (each GPU node)

```sh
cd sanctuary-runtime/telemetry
docker compose -f docker-compose.dcgm-node.yml up -d
# Verify:
curl http://localhost:9400/metrics | grep DCGM_FI_DEV_FB_USED
```

### 3. Configure and start Prometheus hub (Cockpit node)

```sh
# Edit prometheus.yml — replace TODO-*-NODE-IP with actual IPs
vim sanctuary-runtime/telemetry/prometheus.yml

cd sanctuary-runtime/telemetry
docker compose -f docker-compose.prometheus-hub.yml up -d
# Open: http://localhost:9090
```

### 4. Run VRAM gate check

```sh
bash sanctuary-runtime/telemetry/reviewer-vram-check.sh
# exit 0 = safe  |  exit 1 = blocked
```

See `telemetry/docs/GPU_TELEMETRY_LAYER.md` for full documentation.

---

## Quickstart: Adapters (OpenCode / Aider / Pi)

```sh
cd sanctuary-runtime/agent-runtime

# Sync shared skills to all adapters
bash scripts/sync-skills.sh

# Start a new session
bash scripts/new-session.sh my-task-slug

# Summarize a finished session
bash scripts/summarize-session.sh shared/memory/30-sessions/2026/04/2026-04-29_1200Z_my-task-slug

# Refresh tag and entity indexes
bash scripts/refresh-indexes.sh
```

Configure each adapter by reading its README:

- `opencode/README.md`
- `aider/README.md`
- `pi/README.md`

---

## Bridge Helpers

### Windows / WSL

Add the PowerShell snippets to your `$PROFILE`:

```powershell
. "C:\path\to\sanctuary-runtime\bridge\powershell\profile-snippets.ps1"
```

This gives you `opencode`, `omo`, `teleport-agent`, and `agent-deck` commands
that transparently run inside WSL.

### Android / Termux

```sh
bash sanctuary-runtime/bridge/termux/install-termux-bridge.sh <remote-host> <remote-user>
```

This configures an `ssh sanctuary` alias and shell functions `teleport`,
`vram-check`, and `sanctuary-deck` for remote control from your phone.

---

## Agent Roles

| Agent | Runtime | Lane | Runbook |
|-------|---------|------|---------|
| Planner | any | 2 | `shared/agents/planner.md` |
| Implementer | OpenCode (L3) / Aider (L4) | 3–4 | `shared/agents/implementer.md` |
| Reviewer | any | 5 | `shared/agents/reviewer.md` |
| PI | Pi | 6 | `shared/agents/pi.md` |

---

## TODO / Placeholders

- [ ] Fill in `opencode/`, `aider/`, `pi/` adapter config files
- [ ] Populate `shared/skills/` with real skill stubs
- [ ] Add `00-core/principles.md`, `policies.md`, `charter.md`
- [ ] Replace `TODO-*-NODE-IP` in `prometheus.yml` with real addresses
- [ ] Add Grafana dashboard JSON for GPU overview
- [ ] Add Prometheus alerting rules for VRAM > 80% and temp > 80°C
