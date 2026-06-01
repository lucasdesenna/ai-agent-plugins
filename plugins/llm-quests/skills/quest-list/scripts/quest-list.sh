#!/usr/bin/env bash
# Lists quests from YAML frontmatter in quests/*/quest.md.
# Output is CSV, sorted by `updated` descending.
# Usage: quest-list.sh [--active]
#   --active  filter out completed quests (phase=complete|completed|done)
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
skill_dir="${CLAUDE_SKILL_DIR:-${CODEX_SKILL_DIR:-${SKILL_DIR:-$(cd "$script_dir/.." && pwd)}}}"

QUESTS_DIR="${QUESTS_DIR:-$PWD/quests}"
active_only=0

for arg in "$@"; do
  case "$arg" in
    --active) active_only=1 ;;
    -h|--help)
      sed -n '2,5p' "$0" | sed 's/^# \?//'
      exit 0
      ;;
    *) echo "unknown flag: $arg" >&2; exit 2 ;;
  esac
done

# Read a scalar from the first YAML frontmatter block.
# Strips surrounding double quotes if present.
yaml_get() {
  local file="$1" key="$2"
  awk -v k="$key" '
    /^---$/ { blocks++; if (blocks == 2) exit; next }
    blocks == 1 && $0 ~ "^"k": " {
      sub("^"k": *", "")
      if (substr($0,1,1) == "\"" && substr($0,length($0),1) == "\"") {
        $0 = substr($0, 2, length($0)-2)
      }
      print
      exit
    }
  ' "$file"
}

rows=()
for qf in "$QUESTS_DIR"/*/quest.md; do
  [ -f "$qf" ] || continue
  dir="$(basename "$(dirname "$qf")")"

  if [ "$(head -1 "$qf")" != "---" ]; then
    echo "warning: skipping $qf (no frontmatter)" >&2
    continue
  fi

  id="$(yaml_get "$qf" id)"
  title="$(yaml_get "$qf" title)"
  phase="$(yaml_get "$qf" phase)"
  complexity="$(yaml_get "$qf" complexity)"
  created="$(yaml_get "$qf" created)"
  updated="$(yaml_get "$qf" updated)"

  if [ "$id" != "$dir" ]; then
    echo "warning: id/dir mismatch in $qf (id=$id, dir=$dir)" >&2
  fi

  if [ "$active_only" -eq 1 ]; then
    case "$phase" in
      complete|completed|done) continue ;;
    esac
  fi

  # CSV-escape title: wrap in quotes, double any embedded quotes.
  title_csv="\"${title//\"/\"\"}\""
  # Prefix with updated for sorting, then strip before printing.
  rows+=("$updated|$id,$title_csv,$phase,$complexity,$created,$updated,$qf")
done

printf 'id,title,phase,complexity,created,updated,path\n'
if [ "${#rows[@]}" -gt 0 ]; then
  printf '%s\n' "${rows[@]}" | sort -t'|' -k1,1r | cut -d'|' -f2-
fi
