---
name: quest-documentation
description: Produce a quest summary from completed quest artifacts. Use during Documentation to read quest.md, knowledge files, task outputs, PRs, and session transcripts before writing summary.md.
user-invocable: false
---

Use `quest-state` first. Documentation writes `summary.md`; it should not modify existing quest artifacts.

1. Read `quest.md`, `knowledge/index.md`, all relevant files under `knowledge/`, and `agent-tasks/`.
2. Review associated session transcripts when available.
3. Compile `summary.md` with final problem statement, key findings, decisions, delivered changes, links, and timeline.
4. Present the draft for review.
5. After approval, report readiness for the main session to transition.

Use `references/summary-template.md`.
