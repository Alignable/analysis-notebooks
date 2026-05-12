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

Each contributor gets their own directory under `notebooks/`. Create `notebooks/<your-name>/` the first time you add work. Notebook filenames must follow `YYYY-MM-DD_short-description.ipynb` so they sort chronologically within a directory. This is enforced by a pre-commit hook (`bin/check-notebook-filename.sh`) and a CI backstop in `.github/workflows/check-notebooks.yml`.

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

## Adding dependencies

Use `uv add <package>` for runtime dependencies and `uv add --dev <package>` for tooling. Commit `pyproject.toml` and `uv.lock` together.

## Why nbstripout

Notebook outputs — plots, large dataframes, base64-encoded images — produce huge, noisy diffs and bloat the repository over time. `nbstripout` removes outputs at commit time so only the source cells are tracked. The pre-commit hook is the primary line of defense; the GitHub Actions workflow at `.github/workflows/check-notebooks.yml` is a backstop that fails CI if someone forgets to run `pre-commit install` and pushes a notebook with outputs intact.

## Troubleshooting

- **"My commit was modified by the hook."** Expected on the first commit of a notebook with outputs. The hook strips them and aborts the commit so you can review. Just `git add` the file again and re-commit.
- **"CI is failing on my PR with a notebook outputs error."** You forgot to run `pre-commit install`. Run it, then `pre-commit run --all-files`, commit the result, and push.
- **"VSCode can't find the kernel."** Make sure `uv sync` succeeded and explicitly pick `.venv/bin/python` in the interpreter and kernel pickers.
