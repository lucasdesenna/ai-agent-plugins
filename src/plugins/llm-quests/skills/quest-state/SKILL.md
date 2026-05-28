---
name: quest-state
description: Resolve, load, validate, update, and transition quest state. Use for any quest command or phase handoff that reads quest.md, changes phase/updated frontmatter, or validates lifecycle rules.
user-invocable: false
---

# Quest State

This skill owns quest identity and lifecycle state. Use it before phase work and again before final state changes.

## Workflow

1. Resolve a quest id with `bash scripts/quest-resolve.sh <query>`. If no query was provided, run the quest-list skill. If script resolution is ambiguous, show the candidates and stop.
2. Load `quests/{id}/quest.md`. Read frontmatter first, then the relevant body sections for the current phase.
3. Validate structure with `bash scripts/quest-validate.sh {id}` before acting on the quest.
4. Route phase work to the appropriate phase skill or agent:
   - `scouting` -> `quest-scouting`
   - `discovery` -> `quest-discovery`
   - `planning` -> `quest-planning`
   - `formalization` -> `quest-formalization`
   - `execution` -> `quest-execution`
   - `documentation` -> `quest-documentation`
   - `improvement` -> `quest-improvement`
5. Apply final phase transitions only from the main session after reviewing phase output. Check `references/lifecycle.md`, then run `bash scripts/quest-transition.sh <from> <to>` for forward transitions.
6. When changing the quest body or phase, bump `updated:` to today's `YYYY-MM-DD`.

## State Contract

- `quest.md` is the source of truth.
- Subagents may produce phase artifacts, but the main session owns phase transitions and final frontmatter updates.
- Do not skip phases unless user explicitly directs it or the skip is recorded with a reason in `quest.md`.

See `references/lifecycle.md` for phases and exit criteria.
