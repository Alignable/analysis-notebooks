# analysis-notebooks

## Purpose

This repo stores exploratory Jupyter notebooks shared across the engineering org for later reference. The goal is for ad-hoc analyses remain readable and re-runnable long after the original author has moved on.

## Quick start

1. Install [`uv`](https://docs.astral.sh/uv/getting-started/installation/).
2. Clone the repo and `cd` into it.
3. Run `uv sync`. This installs Python 3.12 and all dependencies into `.venv/`.
4. Run `git config --local core.hooksPath bin/git-hooks`. This points git at the repo's committed pre-commit hook (filename-format check at `bin/git-hooks/pre-commit`).
5. Run `uv run nbstripout --install`. This registers a Git `clean`/`smudge` filter so notebook outputs are stripped from commits but preserved in your local working tree across re-runs. **This step is required, not optional.** Without it, your commits will leak notebook outputs and CI will fail your PR. (`.gitattributes` is already committed; this just wires up the filter in your local `.git/config`.)
6. Start working in `notebooks/<your-name>/`.

## Adding notebooks

Each contributor gets their own directory under `notebooks/`. Create `notebooks/<your-name>/` the first time you add work. Notebook filenames must follow `YYYY-MM-DD_short-description.ipynb` so they sort chronologically within a directory. This is enforced by `bin/git-hooks/pre-commit` (which calls `bin/check-notebook-filename.sh`) and a CI backstop in `.github/workflows/check-notebooks.yml`.

## Editing notebooks

### VSCode

Open the repo in VSCode. It should auto-detect `.venv/` as the Python interpreter; if it doesn't, open the command palette and run "Python: Select Interpreter", then pick `.venv/bin/python`. When you open an `.ipynb` file, use the kernel picker in the top right of the notebook to select the same interpreter as the kernel.

### Jupyter Lab

From the repo root, run `uv run jupyter lab`.

## Agentic notebook editing with Claude Code

This repo is configured so Claude Code can read, write, and execute notebook cells while you watch them update live in either **VS Code** or **JupyterLab in the browser**. The setup is one-time; afterwards, "use notebooks/yourname/foo.ipynb" is enough to point Claude at a notebook.

### One-time setup

1. Make sure Docker Desktop is installed and running.
2. From the repo root, run:

   ```
   ./bin/jupyter-mcp-setup.sh
   ```

   It verifies prerequisites and prints the next steps.
3. Follow the printed instructions to connect your notebook client of choice (VS Code and/or browser — see below) and confirm `claude mcp list` shows `DatalayerJupyter ✓ Connected`.

### Daily use

Open two terminals in the repo root:

```
# Terminal 1 — keep this running while editing notebooks with Claude
./bin/jupyter-mcp-start.sh

# Terminal 2 — your normal Claude Code session
claude
```

Then open the notebook in whichever client you prefer. Both work simultaneously — you can even have VS Code and the browser open on the same notebook at once.

**Option A — Browser (JupyterLab).** Simpler, and the most reliable view of live edits (JupyterLab is the native client for the realtime-collaboration protocol the MCP uses). Just open:

```
http://localhost:8888/lab?token=token
```

Navigate to the notebook and start working. No additional setup.

**Option B — VS Code.** One-time per machine: open any `.ipynb`, click the kernel picker (top right of the notebook), select **"Select Another Kernel..." → "Existing Jupyter Server..." → "Enter URL"**, paste `http://localhost:8888/?token=token`, and pick the Python kernel that appears. VS Code remembers the server for future sessions. Note that VS Code can lag on structural changes (new cells, reordering) — if you find this disruptive, switch to the browser.

Once your client is connected, tell Claude things like:

- "use notebooks/garrett/foo.ipynb"
- "add a markdown cell at the top explaining what this notebook does"
- "load data from /path/to/file.csv and show a sample"

Cells Claude adds or edits will appear live in whichever client you have open.

### How it works (short version)

- `.mcp.json` registers the [Datalayer Jupyter MCP server](https://github.com/datalayer/jupyter-mcp-server) at project scope. When you launch `claude` from this repo, it spawns a Docker container running the MCP server.
- The MCP container connects over HTTP to the Jupyter server you start with `bin/jupyter-mcp-start.sh`.
- The token is the literal string `token` — local-dev only, never exposed beyond `localhost:8888`.
- The `jupyter-collaboration` package (in `pyproject.toml`) enables the realtime-collaboration protocol that the MCP and VS Code both use to stay in sync.

## Scratch outputs (`private/`)

Anything under `private/` is gitignored (except `private/README.md`). Use it for CSVs, markdown, or other artifacts your notebooks produce that you want on disk but don't want to commit. A common pattern is writing to `private/<notebook-name>/` from a notebook so each analysis keeps its own outputs together.

## Adding dependencies

Use `uv add <package>` for runtime dependencies and `uv add --dev <package>` for tooling. Commit `pyproject.toml` and `uv.lock` together.

## Why nbstripout

Notebook outputs — plots, large dataframes, base64-encoded images — produce huge, noisy diffs and bloat the repository over time. `nbstripout` removes outputs at commit time so only the source cells are tracked.

We wire it up as a Git `clean`/`smudge` filter (via `nbstripout --install`) rather than a pre-commit hook. The difference matters: a pre-commit hook would rewrite your working file, so you'd lose outputs every time you commit. The filter operates on the blob going into the index instead, leaving your working tree alone. Net effect: the repo stays clean, and your local notebook keeps its outputs across `commit`/`push`/edit cycles.

**Caveat — outputs only live in your working tree, never in git.** Any operation that re-materializes a notebook from git's object store will restore the stripped version (the smudge filter is `cat`, a no-op). That includes `git stash`, `git reset --hard`, `git checkout HEAD -- <file>`, and branch switches when the notebook differs between branches. Re-running the cells is the only way to regenerate outputs in those cases.

The GitHub Actions workflow at `.github/workflows/check-notebooks.yml` is a backstop that fails CI if someone forgets to run `nbstripout --install` and pushes a notebook with outputs intact.

We use a plain git hook (`bin/git-hooks/pre-commit`, wired up via `core.hooksPath`) rather than the [`pre-commit`](https://pre-commit.com) framework. The framework's stash-and-restore around hook execution is incompatible with our clean/smudge filter — when a notebook has unstaged changes, the framework's stash captures unfiltered bytes and can't re-apply them after its internal `git checkout` runs the smudge filter. A plain hook avoids that whole dance.

## Troubleshooting

- **"CI is failing on my PR with a notebook outputs error."** You forgot to run `uv run nbstripout --install` after cloning. Run it, then re-commit any notebooks that already went in with outputs (e.g. `git add notebooks/... && git commit --amend --no-edit` or a new commit).
- **"My filename-format pre-commit hook isn't running."** You forgot `git config --local core.hooksPath bin/git-hooks` after cloning. Run it and try again.
- **"VSCode can't find the kernel."** Make sure `uv sync` succeeded and explicitly pick `.venv/bin/python` in the interpreter and kernel pickers.
