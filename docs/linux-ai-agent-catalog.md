# Linux AI Agent Catalog — Sanctuary Cluster Reference

> **Search note:** The underlying GitHub searches used to compile this catalog are broad and skewed toward star count. High-star repos are not always the most production-ready or self-hostable. Treat this as a starting point; verify each tool against your own workloads before deploying.

---

## Part 1 — Triple Catalog

### Catalog A: Top Public GitHub Repos for Linux AI Agent Ecosystems

Curated for self-hostability, active maintenance, and real Linux compatibility. Sorted roughly by relevance to autonomous agent workflows.

| # | Repo | Stars (approx) | Description |
|---|------|----------------|-------------|
| 1 | [AutoGPT/AutoGPT](https://github.com/Significant-Gravitas/AutoGPT) | 170k+ | Pioneering autonomous agent framework; modular, plugin-based, supports local LLMs |
| 2 | [microsoft/autogen](https://github.com/microsoft/autogen) | 40k+ | Multi-agent conversation framework; agents can call tools, write/run code |
| 3 | [langchain-ai/langchain](https://github.com/langchain-ai/langchain) | 95k+ | LLM application framework; chains, agents, tools, memory abstractions |
| 4 | [langchain-ai/langgraph](https://github.com/langchain-ai/langgraph) | 12k+ | Graph-based stateful agent orchestration on top of LangChain |
| 5 | [joaomdmoura/crewAI](https://github.com/joaomdmoura/crewAI) | 28k+ | Role-based multi-agent crews; task delegation between specialized agents |
| 6 | [BerriAI/litellm](https://github.com/BerriAI/litellm) | 15k+ | Unified LLM API proxy; routes to 100+ providers including local Ollama endpoints |
| 7 | [ollama/ollama](https://github.com/ollama/ollama) | 100k+ | Local LLM server; one-command model pull and serve on Linux/macOS |
| 8 | [ggerganov/llama.cpp](https://github.com/ggerganov/llama.cpp) | 70k+ | GGUF inference engine; CPU and CUDA; foundational runtime for local agents |
| 9 | [smol-ai/developer](https://github.com/smol-ai/developer) | 11k+ | "Smol developer" agent that writes a whole codebase from a spec |
| 10 | [Significant-Gravitas/Auto-GPT-Plugins](https://github.com/Significant-Gravitas/Auto-GPT-Plugins) | 5k+ | Plugin collection for AutoGPT — web, memory, shell exec |
| 11 | [AntonOsika/gpt-engineer](https://github.com/AntonOsika/gpt-engineer) | 52k+ | Prompt → full codebase; interactive clarification loop |
| 12 | [paul-gauthier/aider](https://github.com/paul-gauthier/aider) | 25k+ | AI pair programmer; git-aware, edits real files, works with any model |
| 13 | [OpenDevin/OpenDevin](https://github.com/OpenDevin/OpenDevin) | 35k+ | Open-source Devin clone; sandboxed shell + browser + code agent |
| 14 | [princeton-nlp/SWE-agent](https://github.com/princeton-nlp/SWE-agent) | 14k+ | Solves GitHub issues end-to-end; ACR interface for agent-computer interaction |
| 15 | [AgentOps-AI/agentops](https://github.com/AgentOps-AI/agentops) | 3k+ | Agent observability SDK; traces, replays, cost tracking |
| 16 | [e2b-dev/e2b](https://github.com/e2b-dev/E2B) | 7k+ | Cloud sandboxes for AI code execution; self-hostable runtime |
| 17 | [mem0ai/mem0](https://github.com/mem0ai/mem0) | 22k+ | Persistent memory layer for LLM agents; vector + graph + key-value |
| 18 | [phidatahq/phidata](https://github.com/phidatahq/phidata) | 16k+ | Agent framework with built-in memory, storage, and knowledge tools |
| 19 | [superagent-ai/superagent](https://github.com/superagent-ai/superagent) | 5k+ | Deployable AI agents with API, tools, memory; Docker-native |
| 20 | [TaskingAI/TaskingAI](https://github.com/TaskingAI/TaskingAI) | 6k+ | Self-hosted AI agent platform; REST API, multiple model backends |

---

### Catalog B: Top Runnable Linux Apps / Tools

These can be installed and run directly on a Linux desktop or server with minimal setup.

| # | Tool | Install method | Description |
|---|------|----------------|-------------|
| 1 | **Ollama** | `curl -fsSL https://ollama.com/install.sh \| sh` | Pull and serve any GGUF/GGML model locally |
| 2 | **Aider** | `pip install aider-chat` | Git-integrated AI coding assistant; terminal-first |
| 3 | **OpenCode** | `npm i -g opencode` / binary release | TUI-based AI coding assistant; multi-profile; MCP-native |
| 4 | **LiteLLM Proxy** | `pip install litellm` | Drop-in OpenAI-compatible proxy; routes to any backend |
| 5 | **Open WebUI** | Docker | Full web chat UI; works with Ollama, LiteLLM, OpenAI API |
| 6 | **Qdrant** | Docker / binary | Vector database; REST + gRPC; collections, filtering, payloads |
| 7 | **Redis Stack** | Docker | Key-value + RedisSearch + RedisJSON; fast agent state/cache |
| 8 | **Langflow** | `pip install langflow` | Visual LangChain flow builder; Docker-ready |
| 9 | **Flowise** | `npm i -g flowise` | Visual agent builder; LangChain/LlamaIndex backends |
| 10 | **AnythingLLM** | Docker / AppImage | All-in-one document chat + RAG; Qdrant, Weaviate, Chroma support |
| 11 | **LocalAI** | Docker | OpenAI-compatible inference server; llama.cpp, whisper, stable diffusion |
| 12 | **Jan** | AppImage / deb | Desktop LLM client with local model management |
| 13 | **SHARK / IREE** | pip / source | AMD/NVIDIA-portable ML compiler; useful for non-CUDA inference |
| 14 | **vLLM** | `pip install vllm` | High-throughput LLM serving; PagedAttention; great for A100/H100/consumer GPUs |
| 15 | **Text Generation WebUI** | git + pip | Feature-rich Gradio UI for local model inference; plugins for agents |
| 16 | **LlamaIndex** | `pip install llama-index` | RAG + agent framework; connectors for 100+ data sources |
| 17 | **Crawl4AI** | `pip install crawl4ai` | LLM-friendly async web crawler; structured extraction |
| 18 | **SearXNG** | Docker | Self-hosted meta-search engine; privacy-respecting; REST API |
| 19 | **Prometheus + Grafana** | Docker Compose | Time-series metrics + dashboards; foundational for GPU telemetry |
| 20 | **DCGM Exporter** | Docker (`nvcr.io/nvidia/k8s/dcgm-exporter`) | Exposes NVIDIA GPU metrics to Prometheus |

---

### Catalog C: Connected Stack / Tools That Work Well Together

Groups of tools that compose naturally into real agent pipelines.

#### C1 — Local LLM Inference Stack
```
Ollama / LocalAI / vLLM  →  LiteLLM Proxy  →  OpenCode / Aider / LangChain agents
```
- Ollama or vLLM serves models; LiteLLM normalises the API; coding tools and agents consume it.
- LiteLLM lets you swap backends without touching agent config.

#### C2 — RAG / Memory Pipeline
```
Crawl4AI / SearXNG  →  LlamaIndex / LangChain  →  Qdrant  →  mem0 / AnythingLLM
```
- Crawl4AI or SearXNG ingests web content; LlamaIndex chunks and embeds; Qdrant stores vectors; mem0 adds agent-level memory on top.

#### C3 — Multi-Agent Orchestration
```
CrewAI / AutoGen / LangGraph  →  Redis (task queue + state)  →  Qdrant (shared knowledge)
```
- CrewAI or AutoGen runs role-based agents; Redis holds fast-path state and pub/sub channels; Qdrant holds shared semantic memory.

#### C4 — Telemetry + Observability
```
DCGM Exporter  →  Prometheus  →  Grafana
AgentOps SDK   →  custom dashboards
```
- DCGM Exporter feeds GPU metrics (VRAM, utilisation, temp) to Prometheus; Grafana visualises; AgentOps traces agent decisions.

#### C5 — Coding Agent Pipeline
```
Aider / OpenCode  →  local Ollama or remote API  →  SWE-agent / OpenDevin (for issue resolution)
```
- Aider/OpenCode for interactive pair programming; SWE-agent or OpenDevin for autonomous issue-solving in sandboxed containers.

#### C6 — Document / Research Ingestion
```
SearXNG  →  Crawl4AI  →  LlamaIndex  →  Qdrant
                                      →  AnythingLLM (for chat over docs)
```

---

## Part 2 — Top 25 Best for the Sanctuary Cluster

Tailored for: **Agent Deck cockpit · OpenCode/Aider runtimes · Qdrant/Redis/Docker · Linux desktop+server split · telemetry-minded orchestration**

Favouring: self-hostable, Linux-native, GPU-aware, production-stable.

### Cockpit & Session Management

| # | Tool | Role | Why it fits |
|---|------|------|-------------|
| 1 | **Agent Deck** | Cockpit / tmux orchestrator | Native to your stack; multi-session, tmux-backed, telemetry-aware |
| 2 | **OpenCode** | Primary coding runtime | Multi-profile, MCP-native, TUI; pairs with Aider for coverage |
| 3 | **Aider** | Secondary coding runtime | Git-aware, model-agnostic, scriptable; strong benchmark results |

### Coding Runtimes & Agents

| # | Tool | Role | Why it fits |
|---|------|------|-------------|
| 4 | **SWE-agent** | Autonomous issue resolution | Sandboxed shell + git; complements Aider for hands-off tasks |
| 5 | **OpenDevin** | Full-autonomy code agent | Browser + shell + code in Docker; self-hostable |
| 6 | **Smol Developer** | Scaffolding from spec | Good for bootstrapping new services/modules quickly |

### Orchestration

| # | Tool | Role | Why it fits |
|---|------|------|-------------|
| 7 | **CrewAI** | Multi-agent crew runner | Role-based crews; integrates with LangChain tools and Qdrant memory |
| 8 | **AutoGen** | Conversation-based multi-agent | Flexible agent graph; code execution; good for research automation |
| 9 | **LangGraph** | Stateful agent workflows | Fine-grained control over agent loop; persists state to Redis/Postgres |
| 10 | **LiteLLM Proxy** | Unified LLM gateway | Normalises OpenCode, Aider, CrewAI calls to any local or remote model |

### Memory & RAG

| # | Tool | Role | Why it fits |
|---|------|------|-------------|
| 11 | **Qdrant** | Primary vector store | Already in your stack; collections, filtering, payload metadata |
| 12 | **mem0** | Agent memory layer | Abstracts short/long-term memory over Qdrant; drop-in for agents |
| 13 | **LlamaIndex** | RAG + data connectors | 100+ source connectors; Qdrant integration is first-class |
| 14 | **AnythingLLM** | Document chat / knowledge base | Self-hosted; Qdrant backend; good for project documentation RAG |

### Inference Backends

| # | Tool | Role | Why it fits |
|---|------|------|-------------|
| 15 | **Ollama** | Local model server | One-command; Linux-native; CUDA support; used by OpenCode natively |
| 16 | **vLLM** | High-throughput GPU serving | PagedAttention; best for Foundry (Threadripper + 4070 Ti) workloads |
| 17 | **LocalAI** | OpenAI-compatible fallback | Runs whisper, stable diffusion, code models; useful on low-VRAM nodes |

### Telemetry & Infra

| # | Tool | Role | Why it fits |
|---|------|------|-------------|
| 18 | **DCGM Exporter** | GPU metrics exporter | Feeds VRAM/utilisation to Prometheus; already in your deployment plan |
| 19 | **Prometheus** | Metrics collection | Scrapes DCGM, Redis, Qdrant, node exporters; backbone of VRAM gate |
| 20 | **Grafana** | Metrics visualisation | Dashboards for VRAM, agent activity, Redis queues |
| 21 | **AgentOps** | Agent tracing & observability | SDK-level tracing; cost tracking; LangChain/CrewAI native |

### Ingestion & Research

| # | Tool | Role | Why it fits |
|---|------|------|-------------|
| 22 | **SearXNG** | Self-hosted search | Privacy-respecting meta-search; REST API for agents; Docker-native |
| 23 | **Crawl4AI** | Web ingestion for RAG | Async, LLM-structured output; feeds Qdrant pipeline |
| 24 | **Redis Stack** | Task queues + fast state | Already in your stack; pub/sub for agent coordination; RedisSearch |
| 25 | **Open WebUI** | Human-in-the-loop chat | Connects to Ollama/LiteLLM; good for reviewing agent outputs |

---

## Part 3 — Compatibility Matrix

> **Legend:** ✅ Yes — native / documented integration · ⚠️ Partial — works with glue code or indirect support · ❌ No — not supported or not relevant

| Tool / Repo | Best use | OpenCode | Aider | Qdrant | Redis | Docker | Linux Desktop | Linux Server | Notes |
|-------------|----------|----------|-------|--------|-------|--------|---------------|--------------|-------|
| **Ollama** | Local model serving | ✅ | ✅ | ❌ | ❌ | ✅ | ✅ | ✅ | OpenCode and Aider both support Ollama as a model backend natively |
| **vLLM** | High-throughput GPU inference | ⚠️ | ⚠️ | ❌ | ❌ | ✅ | ✅ | ✅ | Partial: OpenCode/Aider can point at vLLM's OpenAI-compatible endpoint via LiteLLM |
| **LiteLLM Proxy** | Unified LLM API gateway | ✅ | ✅ | ❌ | ⚠️ | ✅ | ✅ | ✅ | Redis can back LiteLLM's cache layer; acts as a transparent intermediary |
| **Aider** | Git-integrated pair programmer | ⚠️ | — | ❌ | ❌ | ✅ | ✅ | ✅ | Partial with OpenCode: different UX model; can be run side-by-side on same repo |
| **OpenCode** | TUI coding runtime | — | ⚠️ | ❌ | ❌ | ✅ | ✅ | ✅ | Multi-profile; works with any OpenAI-compatible endpoint including LiteLLM |
| **CrewAI** | Multi-agent crews | ⚠️ | ❌ | ✅ | ✅ | ✅ | ✅ | ✅ | Partial with OpenCode: OpenCode runs the coding agent; CrewAI orchestrates around it. Qdrant memory tool available |
| **AutoGen** | Conversation-based multi-agent | ⚠️ | ⚠️ | ✅ | ✅ | ✅ | ✅ | ✅ | Agents can call Aider/OpenCode as tools; Qdrant + Redis used for memory/cache |
| **LangGraph** | Stateful agent workflows | ⚠️ | ⚠️ | ✅ | ✅ | ✅ | ✅ | ✅ | Nodes can wrap Aider/OpenCode subprocess calls; Redis for checkpointing |
| **Qdrant** | Vector database | ⚠️ | ⚠️ | — | ⚠️ | ✅ | ✅ | ✅ | No native OpenCode/Aider integration; glue required via LangChain/LlamaIndex; Partial Redis: no built-in Qdrant-Redis bridge |
| **mem0** | Agent persistent memory | ⚠️ | ⚠️ | ✅ | ✅ | ✅ | ✅ | ✅ | SDK-level; wrap around any agent via Python; Qdrant + Redis backends supported |
| **LlamaIndex** | RAG + data ingestion | ⚠️ | ❌ | ✅ | ✅ | ✅ | ✅ | ✅ | Partial with OpenCode: can feed Qdrant collections OpenCode retrieves at query time |
| **AnythingLLM** | Document chat / knowledge base | ⚠️ | ❌ | ✅ | ❌ | ✅ | ✅ | ✅ | Qdrant as vector backend; no Aider integration; useful for human-readable doc search |
| **SWE-agent** | Autonomous issue resolution | ❌ | ⚠️ | ❌ | ❌ | ✅ | ✅ | ✅ | Partial with Aider: different frameworks; can be sequenced (SWE-agent explores, Aider edits) |
| **OpenDevin** | Full-autonomy code agent | ❌ | ⚠️ | ❌ | ❌ | ✅ | ✅ | ✅ | Sandboxed Docker container; partial Aider overlap — run separately or sequence tasks |
| **AgentOps** | Agent tracing & observability | ⚠️ | ⚠️ | ❌ | ❌ | ✅ | ✅ | ✅ | SDK wraps LangChain/CrewAI; partial for OpenCode/Aider (requires manual instrumentation) |
| **SearXNG** | Self-hosted meta-search | ⚠️ | ⚠️ | ❌ | ❌ | ✅ | ✅ | ✅ | REST API; agents call it as a tool; no native OpenCode/Aider plugin — needs MCP wrapper |
| **Crawl4AI** | Web ingestion for RAG | ⚠️ | ❌ | ✅ | ❌ | ✅ | ✅ | ✅ | Python library; feeds structured content to Qdrant; no direct Aider/OpenCode integration |
| **Redis Stack** | Task queues + fast state | ⚠️ | ❌ | ⚠️ | — | ✅ | ✅ | ✅ | Partial with OpenCode: agent sessions can use Redis for state if MCP is configured; no Qdrant bridge |
| **Prometheus** | Metrics collection | ❌ | ❌ | ⚠️ | ⚠️ | ✅ | ✅ | ✅ | Qdrant and Redis both expose Prometheus-compatible metrics endpoints |
| **DCGM Exporter** | GPU metrics to Prometheus | ❌ | ❌ | ❌ | ❌ | ✅ | ✅ | ✅ | Infra-only; no agent integration; feeds the VRAM gate via Prometheus queries |
| **Grafana** | Metrics dashboards | ❌ | ❌ | ⚠️ | ⚠️ | ✅ | ✅ | ✅ | Qdrant and Redis data can be exposed via Prometheus → Grafana |
| **LocalAI** | OpenAI-compat fallback server | ✅ | ✅ | ❌ | ❌ | ✅ | ✅ | ✅ | Drop-in OpenAI API; OpenCode and Aider work without changes |
| **Open WebUI** | Human-in-the-loop chat UI | ⚠️ | ❌ | ❌ | ❌ | ✅ | ✅ | ✅ | Connects to Ollama/LiteLLM; no Aider integration; useful for reviewing agent outputs |
| **Langflow** | Visual flow builder | ⚠️ | ❌ | ✅ | ✅ | ✅ | ✅ | ✅ | No direct OpenCode integration; useful for prototyping pipelines that feed into agent stacks |

---

## Quick-Reference: Sanctuary Activation Order

```
1. EPYC Spine: Redis + Qdrant + Prometheus + DCGM Exporter
2. Memory agent (Qdrant-backed via mem0 / LlamaIndex)
3. Reviewer VRAM gate check  →  prometheus query on DCGM_FI_DEV_FB_USED
4. Builder / OpenCode (Planner)
5. Explorer / Aider (Implementer)
6. Trader (last — highest external I/O load)
```

No heavy agent starts until telemetry is live and the VRAM gate passes.

---

*Last updated: 2026-05-12 — Sanctuary cluster v1 build*
