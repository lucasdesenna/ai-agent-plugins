Use `quest-state` to update approved quest frontmatter fields.

Arguments: $ARGUMENTS (optional quest id; infer from the current quest when available)

Scope: frontmatter only. Do not change phase here. Bump `updated:` when applying approved metadata edits. If `title` or `id` changes, run `/quest:reindex {id}` afterward.
