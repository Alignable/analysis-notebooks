# Claude guidance for analysis-notebooks

## Working on notebooks

This repo supports agentic notebook editing through the DatalayerJupyter MCP server (configured in `.mcp.json`). When the user asks to read, edit, or run cells in a notebook:

1. **Check that the MCP is available.** The relevant tools are named `mcp__DatalayerJupyter__*` (e.g. `use_notebook`, `insert_execute_code_cell`). If they aren't present in your tool list, the MCP server isn't connected.
2. **If the MCP isn't connected,** tell the user to run `./bin/jupyter-mcp-setup.sh` first (one-time prereq check) and then `./bin/jupyter-mcp-start.sh` in a dedicated terminal. They'll also need to point VS Code at `http://localhost:8888/?token=token` via the kernel picker — the setup script prints the full instructions. Don't try to run `jupyter-mcp-start.sh` yourself: it's a long-running foreground process that has to live in its own terminal.
3. **Once connected,** call `mcp__DatalayerJupyter__use_notebook` with the path the user named (relative to the repo root). For new notebooks, default to `notebooks/<user>/YYYY-MM-DD_short-description.ipynb` — each contributor has their own subdirectory.

## Conventions specific to this repo

- **Notebooks must commit without outputs.** `nbstripout` runs as a pre-commit hook and CI fails on outputs. If you're creating cells programmatically and the user is going to commit, that's fine — the hook handles it on commit. Don't suggest disabling the hook.
- **Dependencies live in `pyproject.toml`** and are managed with `uv`. If a notebook needs a new package, run `uv add <pkg>`, not `pip install`. Mention to the user that they'll need to commit the updated `pyproject.toml` and `uv.lock` together.
- **The kernel** is `.venv/bin/python` via `uv`. If the user reports "module not found" errors when running cells, it's almost always that the kernel they picked (in VS Code's kernel picker, or in JupyterLab's "Change Kernel" menu) isn't the uv-managed one.

## Reference

- The README has the user-facing setup walkthrough — point the user there if they want the full story rather than a step-by-step from you.
- The Datalayer MCP server docs: https://github.com/datalayer/jupyter-mcp-server
