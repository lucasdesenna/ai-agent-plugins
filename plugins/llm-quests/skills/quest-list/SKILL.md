---
name: quest-list
description: List all quests and their current status. Use this skill when the user asks to see their quests, check quest status, asks "what quests do I have", "show my quests", "quest status", "what am I working on", or any request to view an overview of active and past investigations.
user-invocable: false
---

# Quest List

You are helping user see an overview of all their quests.

## What to do

### Step 1: Run the listing script

```bash
bash scripts/quest-list.sh
```

Outputs CSV with columns `id,title,phase,complexity,created,updated,path`, one row per quest, sorted by `updated` descending. Pass `--active` to hide quests whose phase is `complete`, `completed`, or `done`.

### Step 2: Present the output

Render the CSV as a markdown table for the user (don't show raw CSV). Group by phase or show as-is — whichever reads better for the number of quests. Flag anything with `complexity: tbd` as unscoped, and anything `updated` > 2 weeks ago as stale.

### Step 3: Offer actions

- "Want to resume one of these? Just tell me which — a partial id works."
- "Want to start a new quest? Describe what you're working on."

The `id` column is what `/quest:open` and `/quest:save` will fuzzy-match against, so prefer showing it alongside titles rather than hiding it.
