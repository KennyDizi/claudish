# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this directory.

## Directory Overview

Test fixtures containing captured API responses for snapshot testing.

## Files

| File | Purpose |
|------|---------|
| `README.md` | Documentation for fixture format and usage |
| `example_simple_text.json` | Simple text response fixture |
| `example_tool_use.json` | Tool use response fixture |

## Fixture Format

Fixtures are JSON files containing:
- Request payload sent to API
- Response (SSE events for streaming, JSON for non-streaming)
- Metadata about the capture

## Capturing New Fixtures

Use monitor mode to capture real Anthropic API traffic:

```bash
# 1. Enable monitor mode with debug logging
claudish --monitor --debug "your test prompt"

# 2. Find captured logs
ls logs/claudish_*.log

# 3. Extract fixture using capture-fixture.ts
bun tests/capture-fixture.ts logs/claudish_*.log > tests/fixtures/new_fixture.json
```

## Usage in Tests

```typescript
import fixture from './fixtures/example_simple_text.json';

// Validate response matches expected format
expect(response).toMatchProtocol(fixture);
```
