# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this directory.

## Directory Overview

Main TypeScript source code for the Claudish CLI and proxy server.

## Key Files

| File | Purpose |
|------|---------|
| `index.ts` | Entry point - orchestrates CLI, proxy server, and Claude runner |
| `cli.ts` | CLI argument parsing (42KB) - handles 20+ flags, env vars, profile management |
| `proxy-server.ts` | Hono-based HTTP proxy server on localhost |
| `transform.ts` | Anthropic ↔ OpenAI API format translation |
| `claude-runner.ts` | Spawns Claude Code with custom settings and env vars |
| `model-loader.ts` | Fetches model metadata from OpenRouter API |
| `model-selector.ts` | Interactive terminal UI for model selection |
| `profile-config.ts` | Profile storage/retrieval for model mappings |
| `profile-commands.ts` | CLI commands for profile management |
| `mcp-server.ts` | Model Context Protocol server implementation |
| `config.ts` | Constants, defaults, environment variable names |
| `types.ts` | Shared TypeScript interfaces |
| `logger.ts` | Debug logging system with file output |
| `port-manager.ts` | Finds available ports in 3000-9000 range |
| `update-checker.ts` | Checks for new Claudish versions |
| `utils.ts` | Utility functions |

## Subdirectories

- `adapters/` - Model-specific adapters (Grok, Gemini, OpenAI, etc.)
- `handlers/` - Request handlers (OpenRouter, Native passthrough)
- `middleware/` - Request/response middleware pipeline
- `validation/` - Input validation and reporting

## Request Flow

```
index.ts (entry)
    ↓
cli.ts (parse args)
    ↓
proxy-server.ts (start Hono server)
    ↓
handlers/ (route to OpenRouter or Native)
    ↓
adapters/ (model-specific transformations)
    ↓
transform.ts (API format conversion)
```

## Adding New Features

1. **New CLI flag**: Add to `cli.ts`, update types in `types.ts`
2. **New model adapter**: Create in `adapters/`, register in `adapter-manager.ts`
3. **New middleware**: Create in `middleware/`, register in `manager.ts`
4. **New handler**: Create in `handlers/`, add routing in `proxy-server.ts`
