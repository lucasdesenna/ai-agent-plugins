#!/usr/bin/env bash
# Resolve a quest identifier to a single quest row from quest-list.sh.
# Output is the CSV row without the header: id,title,phase,complexity,created,updated,path
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
skill_dir="${CLAUDE_SKILL_DIR:-${CODEX_SKILL_DIR:-${SKILL_DIR:-$(cd "$script_dir/.." && pwd)}}}"
skills_dir="$(cd "$skill_dir/.." && pwd)"
quest_list_script="$skills_dir/quest-list/scripts/quest-list.sh"

query="${1:-}"

if [ -z "$query" ]; then
  echo "usage: quest-resolve.sh <id-or-query>" >&2
  exit 2
fi

rows="$(bash "$quest_list_script" | tail -n +2)"
if [ -z "$rows" ]; then
  echo "no quests found" >&2
  exit 1
fi

match_rows() {
  local mode="$1"
  awk -F',' -v q="$query" -v mode="$mode" '
    BEGIN { ql=tolower(q) }
    {
      id=tolower($1)
      if ((mode == "exact" && id == ql) ||
          (mode == "prefix" && index(id, ql) == 1) ||
          (mode == "substring" && index(id, ql) > 0)) {
        print
      }
    }
  ' <<< "$rows"
}

for mode in exact prefix substring; do
  matches="$(match_rows "$mode")"
  count="$(grep -c . <<< "$matches" || true)"
  if [ "$count" -eq 1 ]; then
    printf '%s\n' "$matches"
    exit 0
  fi
  if [ "$count" -gt 1 ]; then
    echo "ambiguous quest identifier: $query" >&2
    printf '%s\n' "$matches" >&2
    exit 3
  fi
done

echo "no quest matched: $query" >&2
exit 1
