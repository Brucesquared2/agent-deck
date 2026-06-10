# 30-sessions — Agent Session Logs

Dated session folders: raw logs and summaries.

## Structure
```
30-sessions/
└── YYYY/
    └── MM/
        └── YYYY-MM-DD_HHMMZ_<slug>/
            ├── raw.md      ← raw conversation / command log
            └── summary.md  ← concise summary + promoted items
```

## Creating a Session
Use the helper script:
```sh
bash ../../scripts/new-session.sh <slug>
```

## Summarizing a Session
```sh
bash ../../scripts/summarize-session.sh <session-path>
```

## Rules
- `raw.md` is write-once; never edit it after the session ends.
- `summary.md` must include: goal, outcome, promoted items, next actions.
- Sessions older than 90 days with no references are candidates for `90-archive/`.
