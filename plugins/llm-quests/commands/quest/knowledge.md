Use the `quest-knowledge` skill to inspect, sync, search, or export quest knowledge through the configured provider.

Arguments: $ARGUMENTS

Supported intents:

- `status {id}`: inspect `knowledge/index.md` and provider sync intent.
- `sync {id|all}`: sync stable quest identity and provider-ready knowledge artifacts.
- `search {query}`: search the configured provider when available.
- `export {id}`: produce or refresh a federation bundle when the provider supports it.

basic-memory is the default provider when configured. Keep local quest files authoritative.

## Knowledge Provider Sync

Knowledge providers index, link, search, or federate selected quest knowledge. They are derived layers over local quest files, not state storage.

Provider capabilities may include:

- `index_quest_identity`: index stable quest identity and problem context.
- `index_artifact`: index selected files under `knowledge/`.
- `search`: find quests or artifacts by semantic query.
- `link_related_items`: record relationships between quests, artifacts, services, teams, or decisions.
- `export_federation_bundle`: produce portable inter-quest knowledge.

Include by default:

- Note title: quest title.
- Tags: `quest`, the quest id, and stable domain tags.
- Frontmatter pointer: `quest-id`, `quest-path`, `created`.
- Body sections: `## Trigger` and `## Problem Definition`.
- Curated `knowledge/` artifacts whose frontmatter or `knowledge/index.md` marks `provider_sync: pending` or `provider_sync: stale`.

Exclude by default:

- `phase`, `updated`, `complexity`.
- Unknown checkboxes, execution progress, Jira status tables.
- Full quest body.
- Scratch work, raw dumps, and task handoff files unless curated into `knowledge/`.

Sync after Scouting has a real Problem Definition, after changing `title`, `id`, `## Trigger`, or `## Problem Definition`, or after adding or materially changing provider-ready artifacts under `knowledge/`.

Use `/quest:reindex {id}` for provider sync. Do not write ad hoc provider notes from phase skills.
