# Principles

## 1. Write First, Code Second
Before writing code, write what you intend to do in `ops/task-queue.md` or `sessions/<session>/log.md`.

## 2. One Source of Truth
Facts live in `knowledge/`. Do not duplicate facts in session logs; reference them.

## 3. Decisions Are Sacred
Every non-trivial decision gets an entry in `maps/DECISION_LOG.md`. Future agents will thank you.

## 4. Signals Are Cheap, Confusion Is Expensive
Emit a signal when:
- Starting a task
- Completing a task
- Hitting a blocker
- Handing off to another agent

## 5. Scratch Is Ephemeral
`scratch/` is a whiteboard. It will be cleaned. Never put permanent facts there.

## 6. Hygiene Is a Team Responsibility
Every agent is responsible for not leaving stale data. Archive, promote, or delete.

## 7. Backward Compatibility
Never delete existing files without leaving a redirect or alias.
