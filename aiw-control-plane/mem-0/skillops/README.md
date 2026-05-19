# SkillOps

SkillOps is a `mem-0` subsystem that turns repeated operational behaviour into reviewed, non-overlapping, reusable skills.

> **SkillOps does not replace mem-0. It is a mem-0 subsystem.**

## Directory layout

```
skillops/
  agents/              Agent definitions (AGT-SESS-0001, AGT-SKIL-0001, AGT-SIMP-0001)
  dist/                Compiled/distributed artefacts (generated — do not hand-edit)
  events/
    schemas/           JSON Schema v7 event payload schemas
  inbox/
    session-learnings/ Raw session extracts awaiting review
    researcher-suggestions/
    consultant-clips/
    user-ideas/
  registry/
    skills.index.json  Master skill index
    skills/            One sub-folder per skill (skill.yaml + skill.md + skill.json)
  reviews/
    session/           Session review outputs
    daily/             Daily review outputs
    weekly/            Weekly review outputs
  schedules/
    session.yaml       Session lifecycle hooks
    daily.yaml         Daily lifecycle schedule
    thresholds.yaml    Promotion/retirement/overlap thresholds
  templates/
    skill.yaml         Canonical skill template (copy and fill in)
  types/
    operational/
    research/
    consultant/
```

## Source-of-truth rule

| File | Role |
|---|---|
| `skill.yaml` | **Source of truth** — edit this |
| `skill.md`   | Human playbook — generated or reviewed |
| `skill.json` | Compiled machine form — do not hand-edit |

## Skill lifecycle

```
observed → candidate → drafted → reviewed → approved → active → improved / merged / retired
```

## Agents

| ID | Name | Primary responsibility |
|---|---|---|
| AGT-SESS-0001 | Session Reviewer | Extract learnings; generate interview questions |
| AGT-SKIL-0001 | SkillOps Curator | Track usage; detect overlap; draft change orders |
| AGT-SIMP-0001 | Simplifier / Merger | Prune bloat; merge duplicates; refactor wording |

## Key thresholds

See `schedules/thresholds.yaml` for the full set. Summary:

- **Promotion:** ≥ 33 uses/day, ≥ 2 sessions observed, overlap ≤ 0.15, human sign-off required.
- **Retirement:** unused for ≥ 30 days.
- **Overlap:** scores above 0.15 trigger a merge-or-reject operator decision (not an automatic rejection).
