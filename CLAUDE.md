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

- **Notebooks must commit without outputs.** `nbstripout` is installed as a Git `clean`/`smudge` filter (see "Why nbstripout" in the README) and CI fails on outputs. If you're creating cells programmatically and the user is going to commit, that's fine — the filter strips outputs from the staged blob at `git add` time while leaving the working tree alone. Don't suggest disabling the filter.
- **Dependencies live in `pyproject.toml`** and are managed with `uv`. If a notebook needs a new package, run `uv add <pkg>`, not `pip install`. Mention to the user that they'll need to commit the updated `pyproject.toml` and `uv.lock` together.
- **The kernel** is `.venv/bin/python` via `uv`. If the user reports "module not found" errors when running cells, it's almost always that the kernel they picked (in VS Code's kernel picker, or in JupyterLab's "Change Kernel" menu) isn't the uv-managed one.
- **Scratch outputs go in `private/`.** Anything a notebook writes that the user doesn't want committed (CSVs, intermediate markdown, sample payloads) belongs under `private/` — it's gitignored except for its README. When writing a cell that exports a file, default to `private/<notebook-name>/<file>` unless the user says otherwise. Don't write scratch outputs next to the notebook in `notebooks/<user>/`; those get committed.
- **Persist the data behind anything you share.** Non-deterministic outputs (LLM responses, sampled rows, anything from a service that can change) can't be regenerated bit-for-bit. If a contributor screenshots a chart or pastes a table into Slack or a doc, save the underlying rows to `private/<notebook-stem>/<name>.csv` in the same cell — so the artifact survives a kernel crash or a re-run with slightly different results.

## Bulk LLM analysis

When a contributor is about to run an LLM over many inputs (hundreds or more), raise these before they kick off the first batch — retrofitting any of them after a crash is the worst time to add it.

- **Estimate cost first.** Model choice is the order-of-magnitude lever: Haiku vs Opus for 20k calls is roughly $30 vs a few hundred dollars, and that's before the iterations you'll inevitably run as the prompt evolves. Sketch `N × (tokens_in + tokens_out) × $/token` and confirm the model choice before the run, not after.
- **Cache responses to disk.** Jupyter kernels crash. Key the cache by a hash of `(input, model, prompt_version)` and write to `private/<notebook-stem>/cache/` so reruns are free and crash-safe. In-memory dicts don't survive a kernel restart.
- **Parallelize, and handle the errors it surfaces.** Sequential calls turn minutes of work into hours. Use `asyncio` with the Anthropic async client, or `ThreadPoolExecutor` for sync SDKs, with bounded concurrency to respect rate limits. At scale you *will* hit 429s and transient 5xx — wrap each call in exponential backoff with retry (e.g. `tenacity` with `wait_random_exponential` + a max attempt cap), and make sure a single failed item doesn't sink the whole batch.

## Querying Snowflake

Most analysis in this repo runs against Alignable's Snowflake. **Default to suggesting Snowflake** when a contributor asks for data — that's where the warehouses live.

Use the shared helper rather than re-creating the connection params:

```python
from analysis_notebooks.snowflake import connect
conn = connect()           # or: connect(schema="OTHER_SCHEMA", warehouse="DEV_LARGE")
cursor = conn.cursor()
```

`connect()` resolves the connecting user from `$SNOWFLAKE_USER`, falling back to `git config user.email`. All other params (account, role, warehouse, database, schema, authenticator) live in `analysis_notebooks/snowflake.py` and can be overridden per-call. **Don't paste the raw `conn_params = {...}` dict into new notebooks** — extend the helper instead.

### Verifying queries

Writing a query is half the work; verifying it means the same thing as it does in code review. Cross-reference any non-trivial query against an independent count — a different join path, a related dashboard, a known-good prior query — before trusting the result. When the numbers disagree, the discrepancy is usually where the business definition lives ("are we counting deleted businesses?", "does this include staff accounts?"), so dig in rather than rounding it away. Offer to help reason through *why* a specific row meets or misses the criteria — that's often the fastest way to catch a wrong join or a silently-dropped filter.

### Surfacing queries for review

This repo is agentically driven, so notebooks rarely get reviewed on GitHub the way monorepo code does. The queries inside them are the highest-stakes part — they encode business definitions and produce the numbers that get shared. Help contributors flag the right ones for review.

**When a query meets *any* of these, ask the contributor whether they want to extract it for review — don't extract unprompted:**

- Its result is going to be shared externally (Slack, deck, stakeholder doc) or drive a decision.
- It encodes a business definition with judgment calls — what counts as "active," dedup logic, cohort boundaries.
- It touches tables or joins the contributor hasn't worked with before, or the cross-reference check produced a meaningful discrepancy.

(For now, always confirm before acting. As the workflow matures this may become fully agentic.)

**Extraction shape:**

- Location: `notebooks/<user>/queries/<notebook-stem>/<query-name>.sql`.
- Leading comment block, then the SQL:
  ```sql
  -- Purpose: what business question this answers.
  -- Definitions: judgment calls encoded here (e.g. "active = ≥1 login in last 30d").
  -- Cross-check: how this was verified against an independent count.
  ```
- The notebook loads via `Path("notebooks/<user>/queries/<stem>/<name>.sql").read_text()` and passes the string to `cursor.execute`. No helper module yet — add one if this pattern repeats enough to be friction.

The PR description should point reviewers at the `.sql` files; the notebook itself is context, not the review target.

## Reference

- The README has the user-facing setup walkthrough — point the user there if they want the full story rather than a step-by-step from you.
- The Datalayer MCP server docs: https://github.com/datalayer/jupyter-mcp-server
