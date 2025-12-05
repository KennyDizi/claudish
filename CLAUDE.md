# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Claudish is a TypeScript CLI tool and MCP server that proxies Claude Code requests to OpenRouter, enabling use of alternative AI models (Grok, GPT-5, Gemini, MiniMax, Qwen) while maintaining 100% Claude Code feature compatibility.

## Commands

```bash
# Development
npm run dev                    # Run CLI in development mode
npm run dev:mcp                # Run as MCP server

# Build
npm run build                  # Extract models + compile TypeScript
npm run install-global         # Build and npm link globally

# Code Quality
npm run lint                   # Run Biome linter
npm run format                 # Auto-format with Biome
npm run typecheck              # TypeScript type checking

# Testing
npm test                       # Run comprehensive model test
npm run test-snapshot          # Run snapshot tests (protocol compliance)
```

## Architecture

### Core Flow
```
claudish "prompt" --model x-ai/grok-code-fast-1
    ↓
CLI Parser (src/cli.ts) → Parse args, load env, validate
    ↓
Port Manager (src/port-manager.ts) → Find available port (3000-9000)
    ↓
Proxy Server (src/proxy-server.ts) → Hono HTTP server on localhost
    ↓
Handler Selection:
  - NativeHandler → Passthrough to Anthropic (monitor mode)
  - OpenRouterHandler → API translation + model adaptation
    ↓
Model Adapter (src/adapters/) → Model-specific quirk handling
    ↓
OpenRouter API
```

### Key Components

**Handlers (`src/handlers/`)**
- `OpenRouterHandler`: Main handler - translates Anthropic API ↔ OpenRouter API, manages streaming, token scaling, thinking/reasoning support
- `NativeHandler`: Passthrough to real Anthropic API (monitor mode for debugging)

**Adapters (`src/adapters/`)**
- `BaseModelAdapter`: Abstract interface for model-specific handlers
- `GrokAdapter`: Handles XML function calls → JSON tool_calls
- `GeminiAdapter`: Preserves thought signatures in reasoning output
- `OpenAIAdapter`: Maps thinking budget → reasoning_effort (low/medium/high)
- `AdapterManager`: Routes requests to correct adapter based on model ID

**API Transform (`src/transform.ts`)**
- Converts Anthropic request format → OpenAI format
- Handles tool_use → tool_calls conversion
- Streaming response protocol translation

**Profile System (`src/profile-config.ts`, `src/profile-commands.ts`)**
- Save/load model configurations per profile
- Map claude-3-* models to OpenRouter alternatives

### Streaming Protocol

Claudish implements the Anthropic Messages API v2 streaming protocol with thinking block support:

```
message_start → content_block_start (index=0) → ping →
[If reasoning: content_block_stop(0) → content_block_start(thinking, 1) → thinking_deltas → stop(1)] →
content_block_start(text, 2) → text_deltas → stop(2) → message_delta → message_stop
```

Critical: `content_block_start` must be sent immediately after `message_start`, before `ping`.

### Token Scaling

For models with different context windows (128k to 2M+), Claudish scales token usage reporting:
- Internal: Scale to Claude's expected 200k window for proper auto-compaction triggers
- External: Report real unscaled usage in status line

## Code Style

Biome handles formatting and linting:
- Line width: 100 characters
- Double quotes, semicolons, ES5 trailing commas
- No unused locals/parameters

## Testing

Snapshot tests verify protocol compliance with 13/13 passing tests. Tests validate:
- Event sequence ordering
- Content block indices
- Tool input streaming
- Usage metrics
- Stop reasons and cache metrics

Run `npm run test-snapshot` before submitting changes to handlers or transform logic.
