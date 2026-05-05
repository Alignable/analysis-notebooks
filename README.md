# analysis-notebooks

## Purpose

This repo stores exploratory Jupyter notebooks shared across the engineering org for later reference. The goal is for ad-hoc analyses remain readable and re-runnable long after the original author has moved on.

## Quick start

1. Install [`uv`](https://docs.astral.sh/uv/getting-started/installation/).
2. Clone the repo and `cd` into it.
3. Run `uv sync`. This installs Python 3.12 and all dependencies into `.venv/`.
4. Run `uv run pre-commit install`. This installs the nbstripout Git hook locally. **This step is required, not optional.** Without it, your commits will leak notebook outputs and CI will fail your PR.
5. Start working in `notebooks/<your-name>/`.

## Adding notebooks

Each contributor gets their own directory under `notebooks/`. Create `notebooks/<your-name>/` the first time you add work. A suggested filename convention is `YYYY-MM-DD_short-description.ipynb` so notebooks sort chronologically within a directory.

## Editing notebooks

### VSCode

Open the repo in VSCode. It should auto-detect `.venv/` as the Python interpreter; if it doesn't, open the command palette and run "Python: Select Interpreter", then pick `.venv/bin/python`. When you open an `.ipynb` file, use the kernel picker in the top right of the notebook to select the same interpreter as the kernel.

### Jupyter Lab

From the repo root, run `uv run jupyter lab`.

## Adding dependencies

Use `uv add <package>` for runtime dependencies and `uv add --dev <package>` for tooling. Commit `pyproject.toml` and `uv.lock` together.

## Why nbstripout

Notebook outputs — plots, large dataframes, base64-encoded images — produce huge, noisy diffs and bloat the repository over time. `nbstripout` removes outputs at commit time so only the source cells are tracked. The pre-commit hook is the primary line of defense; the GitHub Actions workflow at `.github/workflows/check-notebooks.yml` is a backstop that fails CI if someone forgets to run `pre-commit install` and pushes a notebook with outputs intact.

## Troubleshooting

- **"My commit was modified by the hook."** Expected on the first commit of a notebook with outputs. The hook strips them and aborts the commit so you can review. Just `git add` the file again and re-commit.
- **"CI is failing on my PR with a notebook outputs error."** You forgot to run `pre-commit install`. Run it, then `pre-commit run --all-files`, commit the result, and push.
- **"VSCode can't find the kernel."** Make sure `uv sync` succeeded and explicitly pick `.venv/bin/python` in the interpreter and kernel pickers.
