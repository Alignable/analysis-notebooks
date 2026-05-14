#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

if ! command -v uv >/dev/null 2>&1; then
  echo "uv is not installed."
  read -r -p "Install it now? [Y/n] " ans
  case "${ans:-Y}" in
    [Yy]*|"")
      if command -v brew >/dev/null 2>&1; then
        echo "==> Installing uv via Homebrew"
        brew install uv
      else
        echo "==> Installing uv via Astral's installer (https://astral.sh/uv/install.sh)"
        curl -LsSf https://astral.sh/uv/install.sh | sh
        export PATH="$HOME/.local/bin:$PATH"
      fi
      ;;
    *)
      echo "Skipping. Install uv manually: https://docs.astral.sh/uv/getting-started/installation/" >&2
      exit 1
      ;;
  esac
  if ! command -v uv >/dev/null 2>&1; then
    echo "uv still isn't on PATH. Open a new shell and re-run this script." >&2
    exit 1
  fi
fi

echo "==> [1/3] uv sync (Python + dependencies into .venv/)"
uv sync

echo
echo "==> [2/3] git config core.hooksPath bin/git-hooks (filename-format pre-commit hook)"
git config --local core.hooksPath bin/git-hooks

echo
echo "==> [3/3] uv run nbstripout --install (clean/smudge filter for notebook outputs)"
uv run nbstripout --install

echo
echo "Done. Start working in notebooks/<your-name>/."
