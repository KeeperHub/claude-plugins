---
description: Set up KeeperHub -- API key, CLI check, and config. Run this once to get started.
allowed-tools: [Bash, Read, Glob]
---

<security>
Minimize API key exposure:
- NEVER use `echo`, `cat`, or `printf` to display the key after saving it
- NEVER use the Write tool for config.json (Write output displays file contents)
- NEVER read or cat the config file in subsequent commands (it contains the key)
- Save config via a single Bash heredoc command, then use verify-auth.sh for all checks
- Dynamic context must only return YES/NO, never key material
</security>

<objective>
Set up the KeeperHub plugin by:
1. Verifying the `kh` CLI is installed
2. Obtaining and verifying an organization API key
3. Saving everything to ~/.claude/keeperhub/config.json so the MCP server starts automatically
</objective>

<context>
kh CLI installed: !`command -v kh &>/dev/null && echo "YES" || echo "NO"`
kh CLI version: !`kh --version 2>/dev/null || echo "NOT_INSTALLED"`
API key env var set: !`[ -n "${KEEPERHUB_API_KEY:-}" ] && echo "YES" || echo "NO"`
API key prefix valid: !`[[ "${KEEPERHUB_API_KEY:-}" == kh_* ]] && echo "YES" || echo "NO"`
Config file exists: !`test -f ~/.claude/keeperhub/config.json && echo "YES" || echo "NO"`
Config has apiKey field: !`test -f ~/.claude/keeperhub/config.json && grep -q '"apiKey"' ~/.claude/keeperhub/config.json && echo "YES" || echo "NO"`
Config key prefix valid: !`test -f ~/.claude/keeperhub/config.json && grep -o '"apiKey"[[:space:]]*:[[:space:]]*"[^"]*"' ~/.claude/keeperhub/config.json | grep -q 'kh_' && echo "YES" || echo "NO"`
Verify script exists: !`test -x "${CLAUDE_PLUGIN_ROOT}/scripts/verify-auth.sh" && echo "YES" || echo "NO"`
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

2. **Check existing authentication** by examining the context above:
   - If API key env var is "YES" AND prefix valid is "YES", skip to step 3
   - If config file exists is "YES" AND config has apiKey field is "YES" AND config key prefix valid is "YES", skip to step 3
   - If neither, proceed to step 4

3. **Verify existing key** using the verify-auth.sh script:
   - Run via Bash:
     ```bash
     bash "${CLAUDE_PLUGIN_ROOT}/scripts/verify-auth.sh"
     ```
   - If output contains "OK": report "Already authenticated" and skip to step 7
   - If output contains "ERROR": warn the key is invalid or revoked, proceed to step 4

4. **Guide user to create a new key** (if needed):
   - KeeperHub uses organization-scoped API keys with the `kh_` prefix
   - Tell the user:
     a. Log in to https://app.keeperhub.com in their browser
     b. Click their avatar in the top-right corner of the toolbar to open the user menu
     c. Click "API Keys" from the menu
     d. Make sure the "Organisation" tab is selected (not "User")
     e. Click "New API Key" and name it "Claude Code Plugin"
     f. Copy the key immediately (it starts with `kh_` and is only shown once)
   - Ask the user to paste their key (it starts with `kh_`)
   - Validate it starts with `kh_`
   - If the key starts with `wfb_`, inform the user that KeeperHub MCP requires
     organization-scoped keys (kh_ prefix), not user-scoped keys (wfb_ prefix)

5. **Save the config file** with the key the user provided:
   - Write config and set permissions in a SINGLE Bash command using heredoc
     (do NOT use the Write tool -- it displays file contents in output):
     ```bash
     mkdir -p ~/.claude/keeperhub && cat > ~/.claude/keeperhub/config.json << 'KEEPERHUB_EOF'
     {
       "apiKey": "THE_KEY_FROM_USER",
       "baseUrl": "https://app.keeperhub.com"
     }
     KEEPERHUB_EOF
     chmod 600 ~/.claude/keeperhub/config.json && echo "CONFIG_SAVED"
     ```
   - After saving, do NOT read or cat the config file

6. **Verify the key works** using verify-auth.sh:
   ```bash
   bash "${CLAUDE_PLUGIN_ROOT}/scripts/verify-auth.sh"
   ```
   - If "OK": proceed to step 7
   - If "ERROR": tell the user the key may be wrong, ask them to paste a new one

7. **Report setup status**:
   - Show a summary (NEVER include any part of the API key):
     ```
     KeeperHub Setup Complete
     ------------------------
     kh CLI:     Installed (VERSION)
     API Key:    Configured (verified)
     MCP Server: kh serve --mcp (via kh CLI)
     Config:     ~/.claude/keeperhub/config.json (saved, 600 perms)
     ```
   - Tell the user to restart Claude Code for the MCP tools to become available
   - The MCP server will start automatically via `kh serve --mcp`
</process>

<success_criteria>
- kh CLI is installed and on PATH
- API key verified via verify-auth.sh (not via separate inline curl)
- Key saved to config via Bash heredoc (not Write tool)
- No commands echo, cat, or display the key after saving
- Key uses the kh_ prefix (organization-scoped)
- Config file exists at ~/.claude/keeperhub/config.json with 600 permissions
- User informed to restart Claude Code for MCP tools
</success_criteria>
