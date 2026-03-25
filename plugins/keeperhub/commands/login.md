---
description: Set up KeeperHub -- install the kh CLI and authenticate. Run this once to get started.
allowed-tools: [Bash, Read]
---

<objective>
Set up the KeeperHub plugin by:
1. Verifying the `kh` CLI is installed
2. Authenticating via browser login or API key
3. Confirming the MCP server can start
</objective>

<context>
kh CLI installed: !`command -v kh &>/dev/null && echo "YES" || echo "NO"`
kh CLI version: !`kh --version 2>/dev/null || echo "NOT_INSTALLED"`
kh auth status: !`kh auth status --json 2>/dev/null || echo "NOT_AUTHENTICATED"`
KH_API_KEY env var set: !`[ -n "${KH_API_KEY:-}" ] && echo "YES" || echo "NO"`
</context>

<process>
1. **Check the kh CLI** by examining the context above:
   - If kh CLI installed is "NO":
     - Tell the user the `kh` CLI is required for this plugin
     - Provide install instructions:
       - macOS: `brew install keeperhub/tap/kh`
       - Go: `go install github.com/keeperhub/cli/cmd/kh@latest`
       - Or download from https://github.com/KeeperHub/cli/releases
     - Do not proceed until the user confirms they have installed it

2. **Check existing authentication** from the context above:
   - If kh auth status returned valid JSON with a "user" field, the user is already authenticated
   - Report "Already authenticated as EMAIL (ORG)" and skip to step 5
   - If KH_API_KEY env var is set, note that auth will use the environment variable
   - If not authenticated, proceed to step 3

3. **Authenticate** using the kh CLI:
   - Tell the user you will open a browser window for authentication
   - Run via Bash:
     ```bash
     kh auth login
     ```
   - This opens a browser for device code authentication
   - The CLI handles the OAuth flow and stores the token in the OS keyring
   - If browser login is not possible (headless environment, CI), tell the user:
     a. Create an organization API key at https://app.keeperhub.com
        - Click avatar > API Keys > Organisation tab > New API Key
        - Copy the key (starts with `kh_`, shown only once)
     b. Set the `KH_API_KEY` environment variable with the key

4. **Verify authentication**:
   ```bash
   kh auth status
   ```
   - If it shows user, organization, and role: authentication succeeded
   - If it shows "not authenticated": something went wrong, ask the user to try again

5. **Report setup status**:
   - Show a summary:
     ```
     KeeperHub Setup Complete
     ------------------------
     kh CLI:     Installed (VERSION)
     Auth:       Authenticated as EMAIL (ORG)
     MCP Server: kh serve --mcp (starts automatically)
     ```
   - Tell the user to restart Claude Code for the MCP tools to become available
   - The MCP server starts automatically via `kh serve --mcp` when Claude Code loads the plugin
</process>

<success_criteria>
- kh CLI is installed and on PATH
- User is authenticated (kh auth status shows user info)
- User informed to restart Claude Code for MCP tools
</success_criteria>
