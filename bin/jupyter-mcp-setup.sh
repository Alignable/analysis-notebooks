#!/usr/bin/env bash
# One-time setup for the agentic Jupyter MCP integration.
# Verifies prerequisites and prints the commands to run next.
# Safe to re-run.

set -euo pipefail

cd "$(dirname "$0")/.."

red()   { printf "\033[31m%s\033[0m\n" "$*"; }
green() { printf "\033[32m%s\033[0m\n" "$*"; }
yellow(){ printf "\033[33m%s\033[0m\n" "$*"; }

fail() { red "✗ $*"; exit 1; }
ok()   { green "✓ $*"; }

# 1. Docker running
docker info >/dev/null 2>&1 || fail "Docker isn't running. Open Docker Desktop and re-run this script."
ok "Docker is running"

# 2. uv environment present
[ -d .venv ] || fail ".venv/ not found. Run 'uv sync' first."
ok "uv environment present"

# 3. jupyter-collaboration installed (required for the MCP to edit notebooks via RTC)
if ! uv pip list 2>/dev/null | grep -qi '^jupyter-collaboration'; then
  yellow "jupyter-collaboration is not installed."
  echo "  Run: uv add jupyter-collaboration"
  echo "  Then re-run this script."
  exit 1
fi
ok "jupyter-collaboration installed"

# 4. MCP server image pulled
echo "Pulling datalayer/jupyter-mcp-server:latest (cached if already present)..."
docker pull datalayer/jupyter-mcp-server:latest >/dev/null
ok "MCP image present"

cat <<'EOF'

Setup is complete. Three things left, all manual:

  1. Start the Jupyter server in a dedicated terminal (keep it running):

       ./bin/jupyter-mcp-start.sh

  2. Open the notebook in whichever client you prefer (both work, even
     simultaneously):

     a. Browser (simplest, most reliable for live edits):

           http://localhost:8888/lab?token=token

     b. VS Code (one-time per machine):

           - Open any .ipynb in this repo.
           - Click the kernel picker (top right of the notebook).
           - "Select Another Kernel..." → "Existing Jupyter Server..." → "Enter URL".
           - Paste:  http://localhost:8888/?token=token
           - Pick the Python kernel that appears.

  3. Verify Claude Code sees the MCP server:

       claude mcp list

     Look for:  DatalayerJupyter  ✓ Connected
     (If Claude Code was already running, restart it once after first setup.)

After that, you can tell Claude things like:
  "use notebooks/<yourname>/foo.ipynb"
  "add a code cell that loads X and run it"
EOF
