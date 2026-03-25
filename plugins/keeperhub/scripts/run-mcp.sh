#!/bin/bash
# Launch the KeeperHub MCP server via the kh CLI.
# Reads configuration from env vars, kh CLI config, or ~/.claude/keeperhub/config.json.
# Used by .mcp.json as the MCP server entrypoint.

set -euo pipefail

CONFIG_FILE="$HOME/.claude/keeperhub/config.json"

# Check if kh CLI is available
if ! command -v kh &>/dev/null; then
  echo "ERROR: kh CLI not found. Install it with: brew install keeperhub/tap/kh" >&2
  echo "Or see https://github.com/KeeperHub/cli#install for other options." >&2
  exit 1
fi

# Build args for kh serve
ARGS=("serve" "--mcp")

# Read base URL: env var first, then config file
BASE_URL="${KEEPERHUB_API_URL:-}"
if [ -z "$BASE_URL" ] && [ -f "$CONFIG_FILE" ]; then
  BASE_URL=$(grep -o '"baseUrl"[[:space:]]*:[[:space:]]*"[^"]*"' "$CONFIG_FILE" | head -1 | sed 's/.*"baseUrl"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/')
fi

# Only pass --host if a non-default URL is configured
if [ -n "$BASE_URL" ] && [ "$BASE_URL" != "https://app.keeperhub.com" ]; then
  ARGS+=("--host" "$BASE_URL")
fi

# If KEEPERHUB_API_KEY is set in env or config, export it for the CLI
API_KEY="${KEEPERHUB_API_KEY:-}"
if [ -z "$API_KEY" ] && [ -f "$CONFIG_FILE" ]; then
  API_KEY=$(grep -o '"apiKey"[[:space:]]*:[[:space:]]*"[^"]*"' "$CONFIG_FILE" | head -1 | sed 's/.*"apiKey"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/')
fi

if [ -n "$API_KEY" ]; then
  export KH_API_KEY="$API_KEY"
fi

exec kh "${ARGS[@]}"
