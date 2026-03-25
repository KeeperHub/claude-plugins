---
description: Check KeeperHub authentication status, API connectivity, and MCP server availability.
allowed-tools: [Bash, Read]
---

<security>
CRITICAL: NEVER read, cat, echo, or display the config file contents or the API key.
NEVER construct Bash commands that contain the API key literal.
Use verify-auth.sh for all API connectivity checks -- it handles the key internally.
</security>

<objective>
Show the current status of the KeeperHub plugin: kh CLI availability, authentication state,
API connectivity, and MCP readiness. Provide actionable next steps if anything is misconfigured.
</objective>

<context>
kh CLI installed: !`command -v kh &>/dev/null && echo "YES" || echo "NO"`
kh CLI version: !`kh --version 2>/dev/null || echo "NOT_INSTALLED"`
API key env var set: !`[ -n "${KEEPERHUB_API_KEY:-}" ] && echo "YES" || echo "NO"`
API key prefix valid: !`[[ "${KEEPERHUB_API_KEY:-}" == kh_* ]] && echo "YES" || echo "NO"`
Config file exists: !`test -f ~/.claude/keeperhub/config.json && echo "YES" || echo "NO"`
Config has valid key: !`test -f ~/.claude/keeperhub/config.json && grep -q '"apiKey".*"kh_' ~/.claude/keeperhub/config.json && echo "YES" || echo "NO"`
Base URL: !`echo ${KEEPERHUB_API_URL:-https://app.keeperhub.com}`
Verify script exists: !`test -x "${CLAUDE_PLUGIN_ROOT}/scripts/verify-auth.sh" && echo "YES" || echo "NO"`
</context>

<process>
1. **Check kh CLI** from context:
   - If installed: note the version
   - If not installed: flag as a problem, suggest `brew install keeperhub/tap/kh`

2. **Determine auth source** from context:
   - If `KEEPERHUB_API_KEY` env var is "YES", note "Auth source: environment variable"
   - Else if config file exists is "YES" and config has valid key is "YES", note "Auth source: config file"
   - Else report "Not authenticated" and suggest running `/keeperhub:login`

3. **Test API connection** using verify-auth.sh (NEVER use inline curl with the key):
   ```bash
   bash "${CLAUDE_PLUGIN_ROOT}/scripts/verify-auth.sh"
   ```
   - If output contains "OK": API is connected and key is valid
   - If output contains "ERROR": report the specific error (invalid key, connection failed, etc.)

4. **Present a status summary** (NEVER include any part of the API key):
   ```
   KeeperHub Status
   ----------------
   kh CLI:     [Installed (VERSION) / Not installed]
   Auth:       [Authenticated / Not authenticated]
   Key source: [env var / config file / none]
   Key:        [Configured / Not configured]
   API:        [Connected / Unreachable / Auth failed]
   MCP server: [Ready (kh serve --mcp) / Not ready (kh CLI missing)]
   Base URL:   https://app.keeperhub.com
   Config:     ~/.claude/keeperhub/config.json
   ```

5. **Suggest next steps** if anything is wrong:
   - kh CLI missing: `brew install keeperhub/tap/kh`
   - No auth: run `/keeperhub:login`
   - Auth failed: key may be revoked, run `/keeperhub:login` to set up a new one
</process>

<success_criteria>
- Clear status summary displayed
- API key NEVER displayed in any form (no prefix, no characters, no partial mask)
- API connectivity tested via verify-auth.sh only (not inline curl)
- kh CLI presence and version reported
- Actionable suggestions for any issues found
</success_criteria>
