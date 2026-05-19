# Runbook Template

> Copy this file to `10-ops/<YYYY-MM-DD>-<slug>.md` and fill in every section.

---

```yaml
---
author: <agent-id>
date: <YYYY-MM-DD>
session: <session-id>
tags: [runbook, ops, <domain>]
status: draft | active | deprecated
---
```

## Overview

**Goal:** _What this runbook achieves._

**Trigger:** _When to run this runbook (manual / automated / alert)._

**Owner:** _Which agent or human is responsible._

**Estimated duration:** _How long the procedure takes._

---

## Prerequisites

- [ ] Access to `<system>`
- [ ] Environment variable `<VAR>` is set
- [ ] Previous runbook `<link>` has completed (if applicable)

---

## Steps

### Step 1 — <Name>

```sh
# Command to run
```

**Expected output:**

```
<expected output>
```

**If this fails:** _Recovery action or escalation path._

---

### Step 2 — <Name>

_(Repeat structure above for each step.)_

---

## Verification

- [ ] _Check 1 that confirms success._
- [ ] _Check 2._

---

## Rollback

If the procedure must be reversed:

```sh
# Rollback command
```

---

## Notes

_Any caveats, environment differences, or known issues._
