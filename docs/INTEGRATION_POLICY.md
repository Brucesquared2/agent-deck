# Integration and contribution policy

## Scope

This repository is the Agent Deck cockpit and control surface. It is not a dumping ground for every useful AI repository. New integrations must improve the cockpit, its orchestration, or an explicitly supported workflow.

## Integration modes

Choose one mode, in this order of preference:

1. **MCP** for agent tools and code intelligence.
2. **HTTP/SDK adapter** for independent services.
3. **CLI adapter** for local tools with stable command contracts.
4. **Filesystem/library sync** for skills, prompts, and curated memory.
5. **Vendored code** only when the license, ownership, update path, and tests are clear.

## Required adapter behavior

Adapters must be:

- deterministic where possible;
- idempotent for retried requests;
- bounded by timeouts and cancellation;
- explicit about read/write/destructive permissions;
- observable with request and workflow IDs;
- testable without requiring live provider credentials;
- documented in `docs/PLATFORM_INTEGRATIONS.md` and `configs/platform-integrations.yaml`.

## Third-party review checklist

Before enabling a repository:

- confirm the upstream URL and commit/tag;
- record the license and notices;
- inspect install scripts and dependency hooks;
- scan for secrets and unsafe subprocess behavior;
- define network and filesystem scope;
- define rollback and upgrade behavior;
- add a health check and a smoke test;
- document whether it is canonical, optional, or experimental.

## License boundary

Do not copy AGPL code into Agent Deck's MIT codebase without legal review. Run AGPL components as separate services or adapters and preserve their source notices. OpenMontage is currently classified as an external process-boundary integration.

## Pull-request quality bar

A platform integration PR should include:

- adapter or manifest changes;
- focused unit tests;
- a credential-free smoke test;
- documentation;
- provenance and license metadata;
- an explicit failure and approval policy.

Use the existing repository-specific test mandates in `CLAUDE.md`. Do not weaken lifecycle, watcher, feedback, or evaluator coverage to make an integration pass.
