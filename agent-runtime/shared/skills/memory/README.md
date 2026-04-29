# Skill: memory

Read from and write to the shared memory files (scratchpad, decisions, glossary).

## Prompts

### read-scratchpad

```
Read the current contents of shared/memory/scratchpad.md and summarise the active context.
```

### write-scratchpad

```
Append the following note to shared/memory/scratchpad.md under "Active context":
{{note}}
```

### record-decision

```
Add a new entry to shared/memory/decisions.md using the decision template.
Fill in the fields as follows:
- Title: {{title}}
- Context: {{context}}
- Decision: {{decision}}
- Rationale: {{rationale}}
```

### add-glossary-term

```
Add the following term to shared/memory/glossary.md:
- Term: {{term}}
- Definition: {{definition}}
```
