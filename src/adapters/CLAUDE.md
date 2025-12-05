# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this directory.

## Directory Overview

Model-specific adapters that handle quirks and special formats for different AI providers.

## Architecture

```
AdapterManager
    ↓ getAdapter(modelId)
BaseModelAdapter (abstract)
    ├── GrokAdapter      (x-ai/*)
    ├── GeminiAdapter    (google/*)
    ├── OpenAIAdapter    (openai/*)
    ├── QwenAdapter      (qwen/*)
    ├── MiniMaxAdapter   (minimax/*)
    ├── DeepSeekAdapter  (deepseek/*)
    └── DefaultAdapter   (fallback)
```

## Key Files

| File | Purpose |
|------|---------|
| `base-adapter.ts` | Abstract base class defining adapter interface |
| `adapter-manager.ts` | Selects appropriate adapter based on model ID |
| `grok-adapter.ts` | Handles Grok's XML function call format |
| `gemini-adapter.ts` | Preserves thought signatures in reasoning output |
| `openai-adapter.ts` | Maps thinking budget → reasoning_effort |
| `qwen-adapter.ts` | Enables thinking mode for Qwen models |
| `minimax-adapter.ts` | Handles reasoning_split for interleaved thinking |
| `deepseek-adapter.ts` | Manages DeepSeek reasoning parameters |

## BaseModelAdapter Interface

```typescript
abstract class BaseModelAdapter {
  // Process text and extract model-specific tool calls
  abstract processTextContent(text: string, accumulated: string): AdapterResult;

  // Check if adapter handles this model ID
  abstract shouldHandle(modelId: string): boolean;

  // Adapter name for logging
  abstract getName(): string;

  // Modify request before sending (e.g., thinking budget mapping)
  prepareRequest(request: any, originalRequest: any): any;

  // Reset state between requests
  reset(): void;
}
```

## Adding a New Adapter

1. Create `{provider}-adapter.ts` extending `BaseModelAdapter`
2. Implement `shouldHandle()` to match model IDs (e.g., `modelId.includes('provider/')`)
3. Implement `processTextContent()` for any special output parsing
4. Optionally override `prepareRequest()` for request modifications
5. Register in `adapter-manager.ts` adapters array

## Model-Specific Behaviors

- **Grok**: Returns XML `<tool_call>` blocks instead of JSON tool_calls - adapter parses and converts
- **Gemini**: Includes thought signatures in reasoning - adapter preserves them
- **OpenAI o1/o3**: Uses reasoning_effort levels - adapter maps token budgets to low/medium/high
- **Qwen**: Uses enable_thinking flag - adapter enables based on thinking budget
- **MiniMax**: Uses reasoning_split - adapter enables interleaved thinking
