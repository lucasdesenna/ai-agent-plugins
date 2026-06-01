#!/usr/bin/env bash
# Validate quest frontmatter and basic lifecycle fields.
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
skill_dir="${CLAUDE_SKILL_DIR:-${CODEX_SKILL_DIR:-${SKILL_DIR:-$(cd "$script_dir/.." && pwd)}}}"

QUESTS_DIR="${QUESTS_DIR:-$PWD/quests}"

target="${1:-}"
valid_phases="scouting discovery planning formalization execution documentation improvement complete"
valid_complexities="tbd simple medium complex"

if [ -z "$target" ]; then
  echo "usage: quest-validate.sh <quest-id|quest.md|all>" >&2
  exit 2
fi

yaml_get() {
  local file="$1" key="$2"
  awk -v k="$key" '
    /^---$/ { blocks++; if (blocks == 2) exit; next }
    blocks == 1 && $0 ~ "^"k": " {
      sub("^"k": *", "")
      sub(" *#.*$", "")
      gsub(/^"|"$/, "")
      print
      exit
    }
  ' "$file"
}

validate_file() {
  local file="$1" dir id title phase complexity created updated failures=0
  dir="$(basename "$(dirname "$file")")"

  if [ ! -f "$file" ]; then
    echo "missing quest file: $file" >&2
    return 1
  fi
  if [ "$(head -1 "$file")" != "---" ]; then
    echo "$file: missing YAML frontmatter" >&2
    return 1
  fi

  id="$(yaml_get "$file" id)"
  title="$(yaml_get "$file" title)"
  phase="$(yaml_get "$file" phase)"
  complexity="$(yaml_get "$file" complexity)"
  created="$(yaml_get "$file" created)"
  updated="$(yaml_get "$file" updated)"

  for key in id title phase complexity created updated; do
    if [ -z "${!key}" ]; then
      echo "$file: missing frontmatter field '$key'" >&2
      failures=1
    fi
  done

  if [ "$id" != "$dir" ]; then
    echo "$file: id '$id' does not match directory '$dir'" >&2
    failures=1
  fi
  if ! grep -qw "$phase" <<< "$valid_phases"; then
    echo "$file: invalid phase '$phase'" >&2
    failures=1
  fi
  if ! grep -qw "$complexity" <<< "$valid_complexities"; then
    echo "$file: invalid complexity '$complexity'" >&2
    failures=1
  fi
  if ! [[ "$created" =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; then
    echo "$file: created is not YYYY-MM-DD: '$created'" >&2
    failures=1
  fi
  if ! [[ "$updated" =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; then
    echo "$file: updated is not YYYY-MM-DD: '$updated'" >&2
    failures=1
  fi

  return "$failures"
}

if [ "$target" = "all" ]; then
  failures=0
  for file in "$QUESTS_DIR"/*/quest.md; do
    [ -f "$file" ] || continue
    validate_file "$file" || failures=1
  done
  exit "$failures"
fi

if [ -f "$target" ]; then
  validate_file "$target"
else
  validate_file "$QUESTS_DIR/$target/quest.md"
fi
