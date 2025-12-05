# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this directory.

## Directory Overview

Documentation for different Claudish usage modes and features.

## Files

| File | Purpose |
|------|---------|
| `interactive-mode.md` | Persistent session mode with model selector |
| `single-shot-mode.md` | One task and exit mode |
| `mcp-server.md` | Running Claudish as MCP server |
| `monitor-mode.md` | Debug mode with Anthropic API passthrough |

## Usage Modes

1. **Interactive Mode**: `claudish` - Opens model selector, persistent session
2. **Single-shot Mode**: `claudish --model x "prompt"` - One task, exit
3. **MCP Server Mode**: `npm run dev:mcp` - Expose as MCP resource
4. **Monitor Mode**: `claudish --monitor --debug` - Debug with real Anthropic API
