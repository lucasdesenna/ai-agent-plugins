# Quest Framework

Quests are structured investigations for everyday software engineering work: technical research, cross-team coordination, feature development, bug fixes, and documentation. A quest starts from a vague trigger such as a Jira card, Slack thread, meeting note, or idea, then moves through lifecycle phases until it reaches a delivered and documented outcome.

The framework is distributed as portable skill packages. Each skill is self-contained: its `SKILL.md`, `scripts/`, and `references/` stay together so Claude Code, Codex, OpenCode, and compatible agents can resolve supporting files reliably.

## Lifecycle

The default lifecycle is:

1. Scouting
2. Discovery
3. Planning
4. Formalization
5. Execution
6. Documentation
7. Improvement
8. Complete

Use `quest-state/references/lifecycle.md` for the authoritative phase rules and transition criteria.

## Source And Distribution

Human-edited source lives under `llm-quests/` on the `main` branch.

Generated installer-facing output is produced under `dist/` by default:

- `plugins/llm-quests/` contains the full plugin bundle.
- `.claude-plugin/marketplace.json` exposes the Claude Code marketplace entry.
- `.agents/plugins/marketplace.json` exposes the Codex-style marketplace entry.
- `.claude/skills/` mirrors the plugin skills for Claude-compatible and OpenCode-compatible loaders.

Run `npm run build` to generate `dist/` from source. Run `npm run validate` before publishing. Run `npm run publish` to copy `dist/` to a versioned `/tmp` release directory, replace the generated `releases` branch contents, commit `release: <version>`, and push to GitHub.

## Installation

Claude Code:

```bash
claude plugin marketplace add lucasdesenna/llm-quests@releases
```

Codex:

```bash
codex plugin marketplace add lucasdesenna/llm-quests --ref releases
```
