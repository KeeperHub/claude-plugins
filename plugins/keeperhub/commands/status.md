---
description: Check KeeperHub authentication status, API connectivity, and MCP server availability.
allowed-tools: [Bash, Read]
---

<objective>
Show the current status of the KeeperHub plugin: kh CLI availability, authentication state,
and MCP readiness. Provide actionable next steps if anything is misconfigured.
</objective>

<context>
kh CLI installed: !`command -v kh &>/dev/null && echo "YES" || echo "NO"`
kh CLI version: !`kh --version 2>/dev/null || echo "NOT_INSTALLED"`
kh auth status: !`kh auth status --json 2>/dev/null || echo "NOT_AUTHENTICATED"`
KH_API_KEY env var set: !`[ -n "${KH_API_KEY:-}" ] && echo "YES" || echo "NO"`
</context>

<process>
1. **Check kh CLI** from context:
   - If installed: note the version
   - If not installed: flag as the primary issue

2. **Parse auth status** from the `kh auth status` context:
   - If valid JSON: extract user (email), organization, role, auth method, host
   - If "NOT_AUTHENTICATED": user needs to log in
   - If KH_API_KEY env var is set: note that auth uses the environment variable

3. **Present a status summary**:
   ```
   KeeperHub Status
   ----------------
   kh CLI:       [Installed (VERSION) / Not installed]
   Auth:         [Authenticated as EMAIL / Not authenticated]
   Organization: [ORG_NAME / n/a]
   Auth method:  [browser / api-key / env var / none]
   MCP server:   [Ready (kh serve --mcp) / Not ready]
   Host:         [HOST_URL]
   ```

4. **Suggest next steps** if anything is wrong:
   - kh CLI missing: `brew install keeperhub/tap/kh`
   - Not authenticated: run `/keeperhub:login`
   - Auth expired: run `kh auth login` to re-authenticate
</process>

<success_criteria>
- Clear status summary displayed
- kh CLI presence and version reported
- Auth state shown with user and org info
- Actionable suggestions for any issues found
</success_criteria>
