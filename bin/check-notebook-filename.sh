#!/usr/bin/env bash
# Verifies notebook filenames follow the YYYY-MM-DD_description.ipynb convention
# documented in the README. Pre-commit passes staged notebook paths as args.
# Usage: bin/check-notebook-filename.sh path1.ipynb path2.ipynb ...

set -euo pipefail

# Basename must match: 4-digit year, 2-digit month, 2-digit day, underscore,
# at least one character of description, .ipynb extension.
pattern='^[0-9]{4}-[0-9]{2}-[0-9]{2}_.+\.ipynb$'

bad=()
for path in "$@"; do
  name=$(basename "$path")
  # Skip Jupyter checkpoint files (under .ipynb_checkpoints/ which is gitignored
  # but may slip through if someone force-adds it).
  case "$path" in
    *.ipynb_checkpoints/*) continue ;;
  esac
  if [[ ! $name =~ $pattern ]]; then
    bad+=("$path")
  fi
done

if (( ${#bad[@]} > 0 )); then
  printf '\033[31mNotebook filenames must match YYYY-MM-DD_description.ipynb:\033[0m\n'
  for p in "${bad[@]}"; do
    printf '  ✗ %s\n' "$p"
  done
  printf '\nRename with: git mv <old> notebooks/<user>/YYYY-MM-DD_short-description.ipynb\n'
  exit 1
fi
