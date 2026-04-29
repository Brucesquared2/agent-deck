# OpenCode Adapter

Adapter configuration for the OpenCode runtime.

## Purpose
OpenCode handles complex, multi-file architectural tasks (Lane 3).

## Setup
<!-- TODO: add opencode config file path and format -->

1. Install OpenCode: follow upstream docs.
2. Copy or symlink `../shared/skills/` to your OpenCode skills directory.
3. Point OpenCode to `../shared/memory/` for context.

## Sync Skills
```sh
bash ../scripts/sync-skills.sh opencode
```

## Memory Integration
- Read: `../shared/memory/50-maps/INDEX.md` on startup
- Write signals to: `../shared/memory/60-signals/`

## TODO
- [ ] Add `opencode.json` / `opencode.toml` config stub
- [ ] Document skill injection path for this runtime
