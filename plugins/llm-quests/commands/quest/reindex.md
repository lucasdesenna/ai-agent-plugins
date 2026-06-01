Use `/quest:knowledge sync` rules to re-sync a quest's provider index. basic-memory is the default provider when configured.

Arguments: $ARGUMENTS (quest id required, or `all`)

Only sync stable fields by default: title, quest id/path, created date, `## Trigger`, and `## Problem Definition`. Provider-ready files under `knowledge/` may also be indexed. Never sync phase, updated date, unknowns, execution state, or Jira status as state.
