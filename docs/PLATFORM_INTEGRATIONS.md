# Agent Deck Platform Integrations

Agent Deck is the operator cockpit. Integrations remain separate services or adapters with explicit contracts, health checks, permissions, and provenance.

## Design principles

- **Agent Deck owns sessions and operator UX.** It does not become a second inference server, vector database, or video editor.
- **Adapters over forks.** Prefer HTTP, MCP, CLI, or event-based integration over copying upstream code.
- **Local-first by default.** Bind local services to loopback or a private network; require explicit configuration for remote access.
- **Human approval for side effects.** Publishing, credential use, browser actions, destructive filesystem operations, and financial actions require policy gates.
- **License-aware composition.** Every integration records its license and integration mode. AGPL services remain process-separated unless reviewed.
- **One source of truth per capability.** Avoid running competing memory, gateway, or observability systems without a defined boundary.

## Recommended platform map

| Capability | Canonical choice | Agent Deck integration |
|---|---|---|
| Agent session cockpit | Agent Deck | Native |
| Durable agent runtime | OpenGeni | HTTP/SDK service adapter |
| Shared agent prompts and memory | agent-runtime + agent-vault | Mounted library / sync adapter |
| Model gateway | LiteLLM | OpenAI-compatible API adapter |
| GPU inference | vLLM or SGLang | OpenAI-compatible API adapter |
| Vector retrieval | Qdrant | HTTP client / MCP |
| Long-term memory | Mem0 | REST/MCP adapter |
| Code intelligence | ops-codegraph-tool | MCP server |
| Skills | agent-skills-manager | CLI/filesystem adapter |
| Development guardrails | agent-harness | Project bootstrap adapter |
| Video production | OpenMontage | External service adapter; AGPL boundary |
| Conversational editing | FireRed-OpenStoryline | External service adapter |
| ComfyUI generation | comfyui-bridge | HTTP adapter |
| Workflow durability | Temporal | Worker/service integration |
| Events | NATS | Event adapter |
| Policy | OPA | Policy decision point |
| Observability | Langfuse or Opik | Trace/export adapter |

## Integrations from Brucesquared2's collection

### Tier 1: integrate first

- [agent-vault](https://github.com/Brucesquared2/agent-vault): persistent skills, knowledge, and living documents.
- [opengeni](https://github.com/Brucesquared2/opengeni): durable sessions, approvals, governed credentials, and connected machines.
- [agent-harness](https://github.com/Brucesquared2/agent-harness): OpenCode/OpenSpec workflow bootstrap and guardrails.
- [ops-codegraph-tool](https://github.com/Brucesquared2/ops-codegraph-tool): local code graph and MCP tools.
- [agent-skills-manager](https://github.com/Brucesquared2/agent-skills-manager): skill discovery and cross-agent installation.
- [litellm](https://github.com/Brucesquared2/litellm): model gateway reference and local deployment.

### Tier 2: creator/video platform

- [OpenMontage](https://github.com/Brucesquared2/OpenMontage): end-to-end video production pipelines. Keep process-separated because it is AGPL-3.0.
- [FireRed-OpenStoryline](https://github.com/Brucesquared2/FireRed-OpenStoryline): conversational video editing and MCP/skill surface.
- [comfyui-bridge](https://github.com/Brucesquared2/comfyui-bridge): ComfyUI generation bridge.
- [last30days-skill](https://github.com/Brucesquared2/last30days-skill): trend and topic research.
- [taste-skill](https://github.com/Brucesquared2/taste-skill): creative quality and anti-slop review.
- [G-skills](https://github.com/Brucesquared2/G-skills): Google tooling skills, enabled selectively.

### Tier 3: optional platform adapters

- [setec](https://github.com/Brucesquared2/setec): secrets service using Tailscale access control.
- [ego-lite](https://github.com/Brucesquared2/ego-lite): browser-agent execution surface; use only with explicit account/session approval.
- [opik](https://github.com/Brucesquared2/opik): evaluation and tracing.
- [posthog](https://github.com/Brucesquared2/posthog): product analytics; keep user telemetry opt-in.
- [sdl-mcp](https://github.com/Brucesquared2/sdl-mcp): context budget and symbol intelligence.
- [OpenClaw-bot-review](https://github.com/Brucesquared2/OpenClaw-bot-review): optional agent fleet dashboard.
- [open-deep-research](https://github.com/Brucesquared2/open-deep-research): research adapter.
- [chonkie](https://github.com/Brucesquared2/chonkie): ingestion/chunking adapter.
- [understory](https://github.com/Brucesquared2/understory): alternative markdown/MCP memory adapter; do not make it a second canonical memory store initially.

## Integration contract

Every adapter should expose:

1. `health` — liveness and readiness checks.
2. `capabilities` — machine-readable operations and required resources.
3. `config` — non-secret configuration and secret references, never plaintext credentials.
4. `events` — correlation IDs, task IDs, and idempotency keys.
5. `permissions` — read/write/destructive scopes.
6. `artifacts` — input/output manifests, checksums, and provenance.
7. `failure` — typed errors, retry policy, and human-escalation state.

Recommended correlation fields:

```json
{
  "request_id": "req_...",
  "workflow_id": "wf_...",
  "session_id": "session_...",
  "agent_id": "agent_...",
  "adapter": "comfyui",
  "operation": "generate",
  "idempotency_key": "..."
}
```

## Video workflow boundary

Agent Deck should orchestrate this lifecycle, not reimplement each tool:

```text
research → proposal → script → approval → storyboard → assets → voice
→ captions → compose → QA → approval → upload → analytics → memory update
```

OpenMontage, FireRed-OpenStoryline, ComfyUI, Remotion, FFmpeg, WhisperX, and YouTube adapters should communicate through artifact manifests and workflow events.

## Security baseline

- Keep tokens in Setec, an OS secret store, or environment injection; never commit them.
- Default MCP servers to read-only and loopback/private-network binding.
- Require approval before browser publishing, YouTube upload, external messages, or destructive tools.
- Run untrusted code and browser sessions in a sandbox or isolated connected machine.
- Record source URLs, asset licenses, model IDs, prompts, and approvals for every generated video.
- Treat third-party skills as executable supply-chain inputs; scan them before activation.

## Adoption sequence

1. Add the catalog and adapter contracts.
2. Integrate LiteLLM, Qdrant, codegraph, and Agent Vault.
3. Add OpenGeni sessions and approval events.
4. Add video adapters behind the artifact/workflow contract.
5. Add Temporal/NATS/OPA when the first end-to-end workflow is stable.
6. Add distributed GPU scheduling only after one-node production tests pass.
