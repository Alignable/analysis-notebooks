#!/usr/bin/env bash
# Starts a Jupyter server configured for the Datalayer MCP.
# Keep this terminal open while you want Claude to interact with notebooks.
#
# Flags explained:
#   --IdentityProvider.token=token       Shared with .mcp.json and VS Code kernel URL.
#   --ServerApp.allow_remote_access=True Required: the MCP container reaches the server
#                                        via host.docker.internal, which Jupyter treats
#                                        as a remote origin and would otherwise refuse.
#   --ServerApp.allow_origin='*'         Same reason, for cross-origin requests from the
#                                        container.
#   --ServerApp.root_dir=.               Serve files relative to the repo root, so
#                                        DOCUMENT_ID paths like "notebooks/foo.ipynb"
#                                        resolve correctly.

set -euo pipefail

cd "$(dirname "$0")/.."

exec uv run jupyter server \
  --port 8888 \
  --IdentityProvider.token=token \
  --ServerApp.allow_remote_access=True \
  --ServerApp.allow_origin='*' \
  --ServerApp.root_dir=.
