# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [3.0.0] - 2026-03-25

### Added
- Remote HTTP MCP server connection (app.keeperhub.com/mcp)
- OAuth 2.0 browser-based authentication
- API key fallback for headless/CI environments
- 4 auto-invoked skills: workflow-builder, template-browser, execution-monitor, plugin-explorer
- 2 slash commands: /keeperhub:login, /keeperhub:status
- Marketplace configuration for self-hosted distribution
- CI workflow for automated marketplace registry sync

### Changed
- Migrated from local CLI (`kh serve --mcp`) to remote HTTP MCP endpoint
- Simplified installation to single marketplace add + plugin install

## [2.0.0] - 2026-03-01

### Changed
- Restructured as Claude Code plugin (from standalone MCP config)
- Added skill-based architecture with trigger routing

## [1.0.0] - 2026-02-15

### Added
- Initial release as Claude Code plugin
- Basic workflow management commands
