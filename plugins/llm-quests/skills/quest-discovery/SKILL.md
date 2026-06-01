---
name: quest-discovery
description: Resolve open quest unknowns through source-backed investigation. Use during Discovery to create curated knowledge artifacts, refine the problem definition, and report readiness for Planning.
user-invocable: false
---

Use `quest-state` to load and validate the Quest before starting. Discovery resolves unknowns; it does not transition phases.

1. Read `quest.md` and identify unchecked `## Unknowns`.
2. Select the best source for each unknown: Slack, Jira, Confluence, Glean, GitHub, service code, logs, or local artifacts.
3. Investigate and create focused knowledge artifacts under `knowledge/sources/`, `knowledge/findings/`, or `knowledge/decisions/` as appropriate.
4. Check off resolved unknowns in `quest.md`; add newly discovered unknowns as checkboxes.
5. Refine `## Problem Definition` only when evidence changes the understanding.
6. Update `knowledge/index.md` with added or materially changed artifacts, including provider sync intent.
7. Report unresolved unknowns and whether Discovery is ready for the main session to transition.

Use `references/knowledge-artifact-template.md`.
