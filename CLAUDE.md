# Claude guidance for analysis-notebooks

## Working on notebooks

This repo supports agentic notebook editing through the DatalayerJupyter MCP server (configured in `.mcp.json`).

**When to prefer the MCP over the built-in tools:**

- The user wants you to **run/execute** cells, or inspect a live kernel's state — the built-in `Read`/`NotebookEdit` tools can't do this.
- The notebook is **too large for `Read`** (it refuses files past ~25K tokens, which hits some of the existing notebooks in this repo). The MCP can read cells one at a time.

For small, static read-only inspection or simple cell edits, the built-in `Read` and `NotebookEdit` tools are fine and don't require setup. Suggest the MCP only when one of the cases above applies.

When you do need the MCP:

1. **Check that the MCP is available.** The relevant tools are named `mcp__DatalayerJupyter__*` (e.g. `use_notebook`, `insert_execute_code_cell`). If they aren't present in your tool list, the MCP server isn't connected.
2. **If the MCP isn't connected,** tell the user to run `./bin/jupyter-mcp-setup.sh` first (one-time prereq check) and then `./bin/jupyter-mcp-start.sh` in a dedicated terminal. They'll also need to point VS Code at `http://localhost:8888/?token=token` via the kernel picker — the setup script prints the full instructions. Don't try to run `jupyter-mcp-start.sh` yourself: it's a long-running foreground process that has to live in its own terminal.
3. **Once connected,** call `mcp__DatalayerJupyter__use_notebook` with the path the user named (relative to the repo root). For new notebooks, default to `notebooks/<user>/YYYY-MM-DD_short-description.ipynb` — each contributor has their own subdirectory.

## Conventions specific to this repo

- **Notebooks must commit without outputs.** `nbstripout` runs as a pre-commit hook and CI fails on outputs. If you're creating cells programmatically and the user is going to commit, that's fine — the hook handles it on commit. Don't suggest disabling the hook.
- **Dependencies live in `pyproject.toml`** and are managed with `uv`. If a notebook needs a new package, run `uv add <pkg>`, not `pip install`. Mention to the user that they'll need to commit the updated `pyproject.toml` and `uv.lock` together.
- **The kernel** is `.venv/bin/python` via `uv`. If the user reports "module not found" errors when running cells, it's almost always that the kernel they picked (in VS Code's kernel picker, or in JupyterLab's "Change Kernel" menu) isn't the uv-managed one.
- **Scratch outputs go in `private/`.** Anything a notebook writes that the user doesn't want committed (CSVs, intermediate markdown, sample payloads) belongs under `private/` — it's gitignored except for its README. When writing a cell that exports a file, default to `private/<notebook-name>/<file>` unless the user says otherwise. Don't write scratch outputs next to the notebook in `notebooks/<user>/`; those get committed.

## Querying Snowflake

Most analysis in this repo runs against Alignable's Snowflake. **Default to suggesting Snowflake** when a contributor asks for data — that's where the warehouses live.

Use the shared helper rather than re-creating the connection params:

```python
from analysis_notebooks.snowflake import connect
conn = connect()           # or: connect(schema="OTHER_SCHEMA", warehouse="DEV_LARGE")
cursor = conn.cursor()
```

`connect()` resolves the connecting user from `$SNOWFLAKE_USER`, falling back to `git config user.email`. All other params (account, role, warehouse, database, schema, authenticator) live in `analysis_notebooks/snowflake.py` and can be overridden per-call. **Don't paste the raw `conn_params = {...}` dict into new notebooks** — extend the helper instead.

## Reference

- The README has the user-facing setup walkthrough — point the user there if they want the full story rather than a step-by-step from you.
- The Datalayer MCP server docs: https://github.com/datalayer/jupyter-mcp-server
