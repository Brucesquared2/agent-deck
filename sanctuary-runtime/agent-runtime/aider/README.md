# Aider Adapter

Adapter configuration for the Aider runtime.

## Purpose
Aider handles fast, surgical code edits and Git-pair programming (Lane 4).

## Setup
<!-- TODO: add aider config file path and format -->

1. Install Aider: `pip install aider-chat`
2. Copy or symlink `../shared/skills/` to your Aider conventions directory.
3. Use `--read` to inject memory map files.

## Sync Skills
```sh
bash ../scripts/sync-skills.sh aider
```

## Suggested Aider Flags
```sh
aider \
  --read ../shared/memory/50-maps/INDEX.md \
  --read ../shared/memory/50-maps/MEMORY_MAP.md
```

## TODO
- [ ] Add `.aider.conf.yml` stub
- [ ] Document which memory files to pass via `--read`
