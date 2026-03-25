# KeeperHub Plugin for Claude Code

Manage KeeperHub workflows, execute automations, and browse templates directly from Claude Code.

## Quick Start

**1. Install the `kh` CLI**

```
brew install keeperhub/tap/kh
```

Or see [CLI installation options](https://github.com/KeeperHub/cli#install) for other platforms.

**2. Install the plugin**

```
/plugin marketplace add KeeperHub/claude-plugins
/plugin install keeperhub@keeperhub-plugins
```

**3. Run setup**

```
/keeperhub:login
```

This walks you through:
- Authenticating with your KeeperHub account via browser login
- Verifying API connectivity
- Configuring the MCP server

**4. Restart Claude Code** for the MCP tools to become available.

That's it. Try asking Claude to "create a workflow that monitors a wallet" or run `/keeperhub:status` to verify.

## Commands

| Command | Description |
|---------|-------------|
| `/keeperhub:login` | Set up authentication and verify MCP server |
| `/keeperhub:status` | Check auth status, API connectivity, and MCP availability |

## Skills

- **workflow-builder** -- Create workflows from natural language. Triggered by "create a workflow", "monitor contract", "set up automation".
- **template-browser** -- Browse and deploy pre-built workflow templates. Triggered by "show templates", "find a workflow for".
- **execution-monitor** -- Monitor executions and debug failures. Triggered by "check execution", "why did my workflow fail".
- **plugin-explorer** -- Discover available plugins and integrations. Triggered by "what plugins are available", "show integrations".

## MCP Tools

This plugin uses `kh serve --mcp` to provide MCP tools for full API access: workflow CRUD, execution management, template operations, plugin discovery, and integration queries. See the [kh CLI documentation](https://github.com/KeeperHub/cli) for details.

## Requirements

- A KeeperHub account at https://app.keeperhub.com
- The `kh` CLI ([install instructions](https://github.com/KeeperHub/cli#install))
