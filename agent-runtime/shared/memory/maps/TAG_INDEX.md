# Tag Index

Tags are used across all memory files to make content searchable and linkable.

## Tag Format

```
#tag-name
```

- Lowercase, hyphen-separated
- Applied inline in any `.md` file
- Can be combined: `#api #authentication #oauth2`

## Canonical Tags

### Domain Tags
| Tag | Meaning |
|-----|---------|
| `#agent` | Relates to agent behavior or configuration |
| `#memory` | Relates to the memory system itself |
| `#planner` | Planner-specific content |
| `#implementer` | Implementer-specific content |
| `#reviewer` | Reviewer-specific content |
| `#pi` | PI agent content |
| `#opencode` | OpenCode runtime |
| `#aider` | Aider runtime |
| `#pi-runtime` | Pi coding agent runtime |
| `#agent-deck` | Agent Deck cockpit |

### Status Tags
| Tag | Meaning |
|-----|---------|
| `#active` | Currently being worked on |
| `#done` | Completed |
| `#stale` | May be outdated; verify before using |
| `#blocked` | Waiting on something |
| `#archived` | Moved to archive; kept for reference |

### Content Tags
| Tag | Meaning |
|-----|---------|
| `#decision` | A decision was made |
| `#runbook` | Operational procedure |
| `#fact` | Verified fact |
| `#assumption` | Assumed true but not verified |
| `#lesson` | Lesson learned from experience |
| `#signal` | A signal-lang entry |
| `#template` | A reusable template |
| `#reference` | External reference/link |

## How to Maintain This Index

1. When adding a new tag, add it to the table above.
2. Run `scripts/memory-tag-refresh.sh` to scan all `.md` files and generate the full tag → file list.
3. The script appends a "Generated Tag Map" section below (do not edit manually).

---

## Generated Tag Map

_Run `scripts/memory-tag-refresh.sh` to regenerate this section._

<!-- TAG_MAP_START -->
| Tag | Files |
|-----|-------|
| `#active` | maps/TAG_INDEX.md, projects/agent-runtime-scaffold/README.md |
| `#agent` | maps/ENTITY_INDEX.md, maps/TAG_INDEX.md, projects/agent-runtime-scaffold/README.md |
| `#agent-deck` | maps/ENTITY_INDEX.md, maps/TAG_INDEX.md |
| `#aider` | maps/ENTITY_INDEX.md, maps/TAG_INDEX.md |
| `#api` | maps/TAG_INDEX.md |
| `#architecture` | maps/DECISION_LOG.md, maps/TAG_INDEX.md |
| `#archived` | maps/TAG_INDEX.md |
| `#assumption` | maps/TAG_INDEX.md |
| `#authentication` | maps/TAG_INDEX.md |
| `#blocked` | maps/TAG_INDEX.md |
| `#cockpit` | maps/ENTITY_INDEX.md, maps/TAG_INDEX.md |
| `#coding-agent` | maps/ENTITY_INDEX.md, maps/TAG_INDEX.md |
| `#decision` | maps/DECISION_LOG.md, maps/TAG_INDEX.md |
| `#decision-001-signal-lang-format` | maps/TAG_INDEX.md, sessions/2026-04-29-001/summary.md |
| `#decision-002-memory-zone-taxonomy` | maps/TAG_INDEX.md, sessions/2026-04-29-001/summary.md |
| `#done` | maps/TAG_INDEX.md |
| `#fact` | knowledge/glossary.md, knowledge/lessons-learned.md, maps/TAG_INDEX.md, projects/sample-project/context.md |
| `#file-editing` | maps/ENTITY_INDEX.md, maps/TAG_INDEX.md |
| `#implementer` | maps/ENTITY_INDEX.md, maps/TAG_INDEX.md |
| `#lesson` | knowledge/lessons-learned.md, maps/TAG_INDEX.md |
| `#memory` | maps/DECISION_LOG.md, maps/TAG_INDEX.md, projects/agent-runtime-scaffold/README.md |
| `#oauth2` | maps/TAG_INDEX.md |
| `#opencode` | maps/ENTITY_INDEX.md, maps/TAG_INDEX.md |
| `#pi` | maps/ENTITY_INDEX.md, maps/TAG_INDEX.md |
| `#pi-runtime` | maps/ENTITY_INDEX.md, maps/TAG_INDEX.md |
| `#planner` | maps/ENTITY_INDEX.md, maps/TAG_INDEX.md |
| `#reference` | knowledge/glossary.md, maps/TAG_INDEX.md, projects/sample-project/context.md |
| `#reviewer` | maps/ENTITY_INDEX.md, maps/TAG_INDEX.md |
| `#runbook` | maps/TAG_INDEX.md |
| `#runtime` | maps/ENTITY_INDEX.md, maps/TAG_INDEX.md |
| `#sample-project` | maps/TAG_INDEX.md, projects/sample-project/context.md |
| `#session-manager` | maps/ENTITY_INDEX.md, maps/TAG_INDEX.md |
| `#signal` | maps/DECISION_LOG.md, maps/TAG_INDEX.md |
| `#stale` | maps/TAG_INDEX.md |
| `#tag-name` | maps/TAG_INDEX.md |
| `#tag1` | maps/ENTITY_INDEX.md, maps/TAG_INDEX.md |
| `#tag2` | maps/ENTITY_INDEX.md, maps/TAG_INDEX.md |
| `#template` | maps/TAG_INDEX.md |
<!-- TAG_MAP_END -->
