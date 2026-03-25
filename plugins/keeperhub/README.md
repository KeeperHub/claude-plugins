# KeeperHub Plugin for Claude Code

Manage KeeperHub workflows, execute automations, and browse templates directly from Claude Code.

## Quick Start

**1. Install the plugin**

```
/plugin marketplace add KeeperHub/claude-plugins
/plugin install keeperhub@keeperhub-plugins
```

**2. Authorize**

Run `/mcp` in Claude Code, find "keeperhub" in the server list, and authorize via browser. That's it.

For headless/CI environments, set `KH_API_KEY` with an organization API key (`kh_` prefix) instead.

**3.** Try asking Claude to "create a workflow that monitors a wallet" or run `/keeperhub:status` to verify.

## Commands

| Command | Description |
|---------|-------------|
| `/keeperhub:login` | Setup guide for connecting to KeeperHub MCP |
| `/keeperhub:status` | Check MCP connection status and authentication |

## Skills

- **workflow-builder** -- Create workflows from natural language. Triggered by "create a workflow", "monitor contract", "set up automation".
- **template-browser** -- Browse and deploy pre-built workflow templates. Triggered by "show templates", "find a workflow for".
- **execution-monitor** -- Monitor executions and debug failures. Triggered by "check execution", "why did my workflow fail".
- **plugin-explorer** -- Discover available plugins and integrations. Triggered by "what plugins are available", "show integrations".

## MCP Server

This plugin connects to KeeperHub's remote MCP server at `app.keeperhub.com/mcp` via HTTP. Authentication is handled via OAuth (browser) or API key (headless). No local CLI or process needed.

See the [MCP server documentation](https://docs.keeperhub.com/ai-tools/mcp-server) for details on available tools.

## Requirements

- A KeeperHub account at https://app.keeperhub.com
- A browser (for OAuth authorization)
