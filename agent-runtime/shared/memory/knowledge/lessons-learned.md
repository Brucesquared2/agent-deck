# Lessons Learned

#lesson #fact

Lessons from past sessions, distilled for future agents.

---

## 2026-04-29 — Memory taxonomy needs a "scratch" zone

**Session:** 2026-04-29-001  
**Lesson:** Without a designated ephemeral zone, agents pollute `knowledge/` with temporary notes that crowd out durable facts.  
**Action:** Added `scratch/` zone with explicit cleanup policy.

---

## 2026-04-29 — Signal-lang needs a Markdown body section

**Session:** 2026-04-29-001  
**Lesson:** YAML-only signals are too terse for complex handoffs. Adding an optional Markdown body allows rich context without breaking machine parseability.  
**Action:** Signal format now: YAML front matter + optional Markdown body.

---

## Template

```
## YYYY-MM-DD — <title>

**Session:** <session-id>
**Lesson:** <what was learned>
**Action:** <what was changed as a result>
```
