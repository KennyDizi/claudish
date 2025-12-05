# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this directory.

## Directory Overview

Request handlers that process API requests from Claude Code and route to appropriate backends.

## Architecture

```
proxy-server.ts
    ↓ route selection
Handler (interface in types.ts)
    ├── OpenRouterHandler  → OpenRouter API
    └── NativeHandler      → Anthropic API (passthrough)
```

## Key Files

| File | Purpose |
|------|---------|
| `types.ts` | Handler interface definition |
| `openrouter-handler.ts` | Main handler (17.5KB) - API translation, streaming, token scaling |
| `native-handler.ts` | Passthrough to Anthropic API for monitor mode |

## OpenRouterHandler Responsibilities

1. **API Translation**: Convert Anthropic request format → OpenAI format
2. **Streaming Protocol**: Implement Anthropic Messages API v2 SSE format
3. **Token Scaling**: Scale usage for different context windows (128K-2M)
4. **Thinking Support**: Handle extended thinking/reasoning blocks
5. **Model Adaptation**: Use adapters for model-specific quirks
6. **Cost Tracking**: Track and report real-time costs
7. **Context Management**: Monitor and report context window usage

## NativeHandler Responsibilities

1. **Passthrough**: Forward requests directly to Anthropic API
2. **Logging**: Log all traffic for debugging (monitor mode)
3. **No Translation**: Preserve original request/response format

## Handler Selection Logic (in proxy-server.ts)

```typescript
if (monitorMode) → NativeHandler
else if (modelMapping && requestedModel in mapping) → Map model, use OpenRouterHandler
else if (modelId.includes('/')) → OpenRouterHandler
else → NativeHandler
```

## Streaming Protocol (OpenRouterHandler)

Must emit events in this exact order:
```
message_start
content_block_start (index=0)  ← REQUIRED immediately
ping
[thinking blocks if model supports]
content_block_start (text)
text_delta events
content_block_stop
message_delta
message_stop
```

Critical: `content_block_start` must precede `ping` for Claude Code UI initialization.
