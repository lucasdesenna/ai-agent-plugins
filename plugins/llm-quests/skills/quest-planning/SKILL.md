---
name: quest-planning
description: Synthesize quest findings into an approved execution plan. Use during Planning to read knowledge artifacts and draft concrete tasks with dependencies, knowledge links, and parallelization guidance.
user-invocable: false
---

Planning is read-only until user approves the plan. Use `quest-state` first, then read all relevant artifacts.

1. Read `quest.md`, `knowledge/index.md`, and every relevant file under `knowledge/`.
2. Verify Discovery exit criteria are met or explicitly deferred.
3. Draft an execution plan grouped into dependency-aware batches.
4. Each task must state the work, knowledge artifacts, dependencies, parallelization, and suggested agent.
5. Present the plan for approval. Do not edit `quest.md` until approved.
6. After approval, the main session can paste the plan into `## Execution Plan`, bump `updated`, and transition forward.

Use `references/execution-plan-template.md`.
