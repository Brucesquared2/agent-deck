# Inventory Reconciliation Review

**ID:** `inventory-reconciliation-review`  
**Type:** operational  
**Status:** candidate  
**Owner agent:** AGT-SKIL-0001  
**Overlap group:** factory-inventory  
**Promotion threshold:** 33 uses/day

---

## Purpose

Detects quantity deltas between BOM-expected stock and physically counted inventory. Emits corrective events, pauses blocking factory jobs, and opens incidents for unresolved shortfalls.

## Triggers

| Source | Event / Command |
|---|---|
| Event bus | `inventory.short` |
| Event bus | `inventory.counted` |
| CLI | `aiw reconcile inventory` |

## Inputs

| Path | Description |
|---|---|
| `memory/L0_raw_events/events.jsonl` | Raw event stream |
| `memory/L1_materialized_state/inventory_state.json` | Current materialized inventory |
| `factory/bom/*.json` | BOM expected quantities |

## Outputs

| Path | Description |
|---|---|
| `memory/L6_compiled/factory_brief.md` | Human-readable brief |
| `memory/L6_compiled/proposed_events.jsonl` | Events proposed for commit |
| `memory/L6_compiled/cockpit_state.json` | Cockpit fault/clear state |

## Procedure

1. Validate inventory events for schema correctness.
2. Compare claimed quantity against counted quantity.
3. Generate `inventory.short` event if delta is negative.
4. Pause the affected factory job if the shortfall is blocking.
5. Open an incident if the shortfall remains unresolved.

## Promotion gate (golden fixture)

Before this skill is promoted from `candidate` to `active`, the following fixture must pass exactly once:

```
inventory.counted  actual=4
BOM expected=5
compile detects delta=-1
proposed inventory.short created
reconciler appends signed inventory.short
factory.job.paused appears
incident.opened appears
cockpit_state.json shows fault state
```

## Review

- Cadence: daily
- Human sign-off required: yes
- Retirement condition: unused for ≥ 30 days

---

*This file is the human playbook. The canonical source is `skill.yaml`. The compiled machine form is `skill.json`.*
