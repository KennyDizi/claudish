# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this directory.

## Directory Overview

Middleware system for model-specific request/response transformations that hooks into the proxy lifecycle.

## Architecture

```
MiddlewareManager
    ↓ orchestrates
ModelMiddleware (interface)
    └── GeminiThoughtSignatureMiddleware
```

## Key Files

| File | Purpose |
|------|---------|
| `types.ts` | Middleware interface and context types |
| `manager.ts` | Orchestrates middleware execution |
| `gemini-thought-signature.ts` | Preserves Gemini reasoning signatures |
| `index.ts` | Exports |

## ModelMiddleware Interface

```typescript
interface ModelMiddleware {
  name: string;

  // Filter: should this middleware run for this model?
  shouldHandle(modelId: string): boolean;

  // Lifecycle hooks
  onInit?(): void | Promise<void>;
  beforeRequest(context: RequestContext): void | Promise<void>;
  afterResponse?(context: NonStreamingResponseContext): void | Promise<void>;
  afterStreamChunk?(context: StreamChunkContext): void | Promise<void>;
  afterStreamComplete?(metadata: Map<string, any>): void | Promise<void>;
}
```

## Context Types

- **RequestContext**: `modelId`, `messages` (mutable), `tools`, `stream`
- **NonStreamingResponseContext**: `modelId`, `response`
- **StreamChunkContext**: `modelId`, `chunk`, `delta` (mutable), `metadata` (shared across chunks)

## Adding New Middleware

1. Create `{name}.ts` implementing `ModelMiddleware`
2. Implement `shouldHandle()` to filter by model ID
3. Add hooks as needed:
   - `beforeRequest`: Modify messages, inject system prompts
   - `afterResponse`: Process non-streaming responses
   - `afterStreamChunk`: Process each SSE chunk
   - `afterStreamComplete`: Cleanup after streaming
4. Register in `manager.ts`

## GeminiThoughtSignatureMiddleware

Handles Gemini's unique thought signature format in `reasoning_details`:
- Extracts signatures from streaming chunks
- Preserves them for proper thinking block display
- Cleans up after stream completion
