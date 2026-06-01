---
name: quest-start
description: Start a new throughly defined Quest by scaffolding files and setting its initial state. Use when the user asks for a new Quest and is able to provide `quest-id`, `title` and `problem-definition`.
user-invocable: false
---

1. Capture proposed title and quest id. Confirm them with user.
2. Scaffold files with `bash scripts/quest-scaffold.sh <quest-id> <title> <problem-definition>`.
3. Use `quest-state` for validation and `quest-knowledge` for knowledge provider sync.
