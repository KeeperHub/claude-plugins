# Security Policy

## Reporting Vulnerabilities

If you discover a security vulnerability in this project, please report it responsibly.

- **Email**: security@keeperhub.com
- **Expected response time**: 48 hours
- **Do not** open public GitHub issues for security vulnerabilities.

Please include a description of the vulnerability, steps to reproduce, and any relevant context.

## Supported Versions

| Version | Supported          |
| ------- | ------------------ |
| 3.0.x   | Yes                |
| < 3.0   | No                 |

## Security Practices

- **HTTPS only**: All communication with the remote MCP server uses HTTPS with TLS 1.2 or higher.
- **OAuth 2.0 authentication**: The plugin uses browser-based OAuth 2.0 flows. No credentials are stored in the plugin configuration files.
- **No hardcoded secrets**: API keys and tokens are provided exclusively via environment variables. They are never committed to the repository.
- **No executable code**: This plugin consists entirely of markdown and JSON configuration files. There is no executable code to audit or exploit.
- **Server-side reviews**: The remote MCP server at `app.keeperhub.com` undergoes regular security reviews and penetration testing.

## Scope

### In scope

- Plugin configuration files in this repository (markdown and JSON)
- Behavior of the MCP endpoint at `app.keeperhub.com/mcp`
- OAuth flow and token handling between Claude and the MCP server

### Out of scope

- The KeeperHub web application itself (report separately at security@keeperhub.com)
- Third-party dependencies or services not maintained by KeeperHub
- Claude Desktop or Claude Code client vulnerabilities (report to Anthropic)
