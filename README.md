# KeeperHub Claude Code Plugins

Claude Code plugin marketplace by KeeperHub.

## Install

```
/plugin marketplace add KeeperHub/claude-plugins
```

## Available Plugins

### keeperhub

Manage KeeperHub workflows, execute automations, and browse templates from Claude Code.

```
/plugin install keeperhub@keeperhub-plugins
```

Run `/keeperhub:login` after install to set up your API key.

Adds:
- `/keeperhub:login` command -- set up API key and configure the MCP server
- `/keeperhub:status` command -- check auth and connectivity
- 4 skills -- workflow-builder, template-browser, execution-monitor, plugin-explorer
- Full MCP tool access via the `kh` CLI
