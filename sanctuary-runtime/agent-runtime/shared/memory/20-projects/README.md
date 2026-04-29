# 20-projects — Project Packs

Per-repository project packs containing requirements, decisions, and architecture notes.

## Structure
```
20-projects/
└── <repo-name>/
    ├── requirements.md
    ├── architecture.md
    └── decisions.md
```

## Rules
- One subfolder per repo, named after the GitHub `<owner>/<repo>` slug (slashes replaced with `_`).
- Architecture diagrams go in `architecture.md` as Mermaid or ASCII.
- Decisions reference entries in `50-maps/DECISION_LOG.md`.
