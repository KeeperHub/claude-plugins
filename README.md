# KeeperHub Claude Code Plugins

Claude Code plugin marketplace by KeeperHub.

## Install

```
/plugin marketplace add KeeperHub/claude-plugins
```

## Available Plugins

### keeperhub

Build and manage automation workflows from Claude Code. Create workflows that monitor smart contracts, track on-chain events, run scheduled tasks, and send notifications across Discord, Telegram, email, and webhooks. Connects to KeeperHub's remote MCP server with OAuth browser authentication. Includes 4 skills and 2 slash commands.

```
/plugin install keeperhub@keeperhub-plugins
```

After install, run `/mcp` in Claude Code and authorize the keeperhub server via browser.

**Commands:**
- `/keeperhub:login` -- setup guide for connecting to KeeperHub MCP
- `/keeperhub:status` -- check MCP connection status

**Skills (activate automatically):**
- **workflow-builder** -- create workflows from natural language
- **template-browser** -- browse and deploy pre-built workflow templates
- **execution-monitor** -- monitor runs and debug failures
- **plugin-explorer** -- discover available plugins and integrations

**Example use cases:**
- "Create a workflow that monitors a smart contract event every 15 minutes and sends a Telegram alert when a specific condition is met"
- "Show me available workflow templates for on-chain event monitoring"
- "Why did my last workflow execution fail? Show me the logs"
- "What KeeperHub plugins and integrations are available?"
- "Set up an automation that runs a scheduled check hourly and sends a Discord notification when a threshold is crossed"
