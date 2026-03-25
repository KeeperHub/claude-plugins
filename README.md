# KeeperHub Claude Code Plugins

Claude Code plugin marketplace by KeeperHub.

## Install

```
/plugin marketplace add KeeperHub/claude-plugins
```

## Available Plugins

### keeperhub

Build and manage Web3 automation workflows from Claude Code. Create workflows that monitor smart contracts, execute DeFi operations, transfer tokens, and send notifications across Discord, Telegram, email, and webhooks. Connects to KeeperHub's remote MCP server with OAuth browser authentication. Includes 4 skills and 2 slash commands.

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
- "Create a workflow that monitors my Aave health factor every 15 minutes and sends a Telegram alert if it drops below 1.5"
- "Show me available workflow templates for wallet monitoring"
- "Why did my last workflow execution fail? Show me the logs"
- "What KeeperHub plugins and integrations are available?"
- "Set up an automation that checks ETH price hourly and sends a Discord notification when it crosses $3000"
