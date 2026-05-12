# Sanctuary Cluster — Top 25 Shortlist

**Fast-reference companion to the Linux AI Agent Catalog.**  
Scope: the exact Sanctuary 3-node cluster. Not a general ecosystem survey.

---

## Your Internal Stack (First-Class Components)

These are already running or already built. Every external tool recommendation below is evaluated *relative to* this baseline — not as a replacement for it.

| Component | Role |
|---|---|
| **Agent Deck** | War Room tmux cockpit; session management; 93-skill library |
| **8 Avatar Agents** | Specialised operator personas (Memory, Builder, Explorer, Trader, …) |
| **signal-lang / 12-bit neural lattice** | Custom communication protocol + neural encoding layer |
| **agentmemory** | In-cluster persistent agent memory store |
| **Open WebUI** | Primary LLM chat front-end |
| **Qdrant** | Vector database / semantic memory backplane |
| **Redis** | Fast key-value cache; pub/sub bus between agents |
| **Ollama** | Local model serving |
| **Aider** | CLI-driven AI code editing |
| **OpenCode** | Agent-profile-aware coding runtime |
| **Grafana + Prometheus + DCGM** | Full GPU/system telemetry stack |
| **Docker** | Container runtime across all nodes |
| **ai-warehouse-deploy** | Cluster deployment automation |

---

## 3-Node Role Split

Design principle: **specialised stacks, not identical full copies.**

| Node | Hardware | OS | Primary Role |
|---|---|---|---|
| **Cockpit** | 7800X3D | CachyOS | Brain · UI · Operator cockpit · Agent Deck host |
| **Spine** | EPYC + 4 × RTX 3090 | NixOS | Muscle · Inference · Memory backplane (Qdrant + Redis) |
| **Foundry** | Threadripper (X399M) | TBD | Coder · Runtime lanes · Batch/processing workloads |

### Distribution matrix

| Service | Cockpit (7800X3D) | Spine (EPYC) | Foundry (TR) |
|---|---|---|---|
| Agent Deck / War Room | ✅ primary | — | — |
| Open WebUI | ✅ | — | — |
| Ollama (interactive) | ✅ | — | — |
| Ollama (batch/serve) | — | ✅ primary | ✅ secondary |
| Qdrant | — | ✅ primary | — |
| Redis | — | ✅ primary | — |
| Grafana dashboard | ✅ | — | — |
| Prometheus scrape hub | — | ✅ | — |
| DCGM exporter | — | ✅ (4×3090) | ✅ (if GPU present) |
| Aider / OpenCode | ✅ | — | ✅ primary |
| agentmemory | — | ✅ | — |
| Docker workloads | shared | ✅ heavy | ✅ heavy |

**Shared across all nodes:** SSH fabric, `.env` config, Docker runtime, unified Prometheus targets.  
**Centralised on Spine:** vector DB, cache bus, Prometheus, inference.  
**Role-specific:** Agent Deck cockpit stays on the 7800X3D; heavy code execution lanes belong on the Foundry.

---

## Top 25 Shortlist

Organised by role. Starred items ★ are the highest-priority additions.

### Cockpit

| # | Tool / Repo | Why it belongs here |
|---|---|---|
| 1 | **Agent Deck** *(internal)* | Already your primary cockpit; the anchor for all War Room sessions |
| 2 | **Open WebUI** *(internal)* | Chat front-end tightly paired with Ollama on the same host |
| 3 | **browser-use** ★ | Playwright-backed browser automation; runs well on a desktop GPU node; feeds agents web context |
| 4 | **OpenHands** ★ | Full browser + shell agent IDE; complements Aider/OpenCode for complex tasks; cockpit-hosted |

### Coding / Pair Programming

| # | Tool / Repo | Why it belongs here |
|---|---|---|
| 5 | **Aider** *(internal)* | Already running; git-diff-aware CLI coding agent |
| 6 | **OpenCode** *(internal)* | Profile-driven coding sessions across nodes |
| 7 | **Continue.dev** | VS Code / Neovim extension bridging local Ollama models to the editor without cloud calls |
| 8 | **Cursor** (local-backend) | If you use a GUI IDE; point it at your local Ollama endpoint |

### Orchestration / Multi-Agent

| # | Tool / Repo | Why it belongs here |
|---|---|---|
| 9 | **LangGraph** ★ | Stateful multi-agent graph runtime; pairs with agentmemory and Redis for durable workflows |
| 10 | **CrewAI** | Crew/role-based orchestration; lighter than LangGraph; good for Avatar agent choreography |
| 11 | **AutoGen (Microsoft)** | Conversation-based multi-agent framework; evaluate against CrewAI before committing |
| 12 | **pi-mono / Pi-style runtimes** | Process-isolation agent container model; evaluate for hardening Avatar agent sandboxing |

### Memory / RAG

| # | Tool / Repo | Why it belongs here |
|---|---|---|
| 13 | **Qdrant** *(internal)* | Already the primary vector store; no replacement needed |
| 14 | **agentmemory** *(internal)* | Already your persistent layer; ensure LangGraph and CrewAI can write to it |
| 15 | **mem0** ★ | Drop-in memory layer with auto-summarisation; can write through to Qdrant; low integration friction |
| 16 | **Chroma** | Lighter alternative to Qdrant for ephemeral / prototype contexts; not a replacement |

### Data Ingestion / Pipelines

| # | Tool / Repo | Why it belongs here |
|---|---|---|
| 17 | **Unstructured** | Document ingest (PDF, HTML, DOCX) → chunked vectors → Qdrant |
| 18 | **Docling (IBM)** | High-fidelity PDF/table parsing; feeds the RAG pipeline cleanly |
| 19 | **Airbyte (self-hosted)** | Broad connector library for bulk data ingestion into the warehouse |

### Telemetry / Observability

| # | Tool / Repo | Why it belongs here |
|---|---|---|
| 20 | **Grafana + Prometheus + DCGM** *(internal)* | Already running; add agent-event dashboards alongside GPU metrics |
| 21 | **OpenTelemetry (OTel)** ★ | Instrument LangGraph/CrewAI agent spans; route traces to your existing Prometheus/Grafana stack |
| 22 | **Langfuse (self-hosted)** | LLM trace/eval/cost tracking; lightweight; add alongside OTel for prompt-level observability |

### Infrastructure / Runtime

| # | Tool / Repo | Why it belongs here |
|---|---|---|
| 23 | **Redis** *(internal)* | Already running; ensure LangGraph checkpointer and agent state bus point here |
| 24 | **Podman** | Rootless container alternative; evaluate for Avatar agent sandboxing on Foundry |
| 25 | **Ollama** *(internal)* | Already running; add model routing config so Cockpit → Spine delegation is explicit |

---

## Already Have

Everything in the [Internal Stack](#your-internal-stack-first-class-components) table above. The cluster is already production-capable for multi-agent workloads. The gap is orchestration plumbing and richer observability — not new infrastructure.

---

## Worth Adding Now

| Tool | Rationale |
|---|---|
| **browser-use** | Immediate web-automation capability for cockpit agents; minimal install |
| **mem0** | Drops onto Qdrant with low friction; improves agent memory quality across sessions |
| **LangGraph** | Adds durable, stateful multi-agent workflows; Redis + agentmemory are already the right backends |
| **OpenTelemetry** | Instrument existing agents; the Prometheus/Grafana stack is ready to receive traces |
| **Langfuse** | Self-hosted; adds LLM-level trace visibility to complement Grafana system metrics |

---

## Evaluate Next

| Tool | Notes |
|---|---|
| **OpenHands** | Powerful but heavier; evaluate once LangGraph/CrewAI orchestration is stable |
| **CrewAI** | Natural fit for Avatar agent choreography; compare against LangGraph patterns first |
| **pi-mono** | Agent process isolation model; worth reviewing for hardening Avatar sandbox boundaries |
| **Airbyte** | Only needed when bulk external data ingestion becomes a bottleneck |
| **Podman** | Rootless containers for Foundry lanes; evaluate before the next Foundry redeploy |
| **AutoGen** | Evaluate only if LangGraph and CrewAI don't cover your multi-agent patterns |

---

*This document is scoped to the Sanctuary 3-node cluster. For broader Linux AI agent ecosystem coverage, see the main Linux AI Agent Catalog.*
