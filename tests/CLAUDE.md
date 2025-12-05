# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this directory.

## Directory Overview

Test suite for Claudish, focusing on protocol compliance, model adapters, and integration testing.

## Test Commands

```bash
npm test                    # Run comprehensive model test
npm run test-snapshot       # Run snapshot tests (protocol compliance)
bun test tests/snapshot.test.ts  # Run specific test file
```

## Key Test Files

| File | Purpose |
|------|---------|
| `snapshot.test.ts` | Protocol compliance tests (13/13 passing) |
| `comprehensive-model-test.ts` | Integration tests across models |
| `gemini-adapter.test.ts` | Gemini adapter unit tests |
| `gemini-compatibility.test.ts` | Gemini API compatibility |
| `gemini-integration.test.ts` | Gemini end-to-end tests |
| `grok-adapter.test.ts` | Grok adapter unit tests |
| `grok-tool-format.test.ts` | Grok XML tool call parsing |
| `image-handling.test.ts` | Image content handling |
| `image-transformation.test.ts` | Image format transformation |
| `integration.test.ts` | Full integration tests |
| `capture-fixture.ts` | Utility to capture test fixtures from monitor mode |
| `debug-snapshot.ts` | SSE event debugging utility |
| `verify-user-models.ts` | Verify user-provided model IDs |

## Shell Scripts

| Script | Purpose |
|--------|---------|
| `snapshot-workflow.sh` | Full workflow: capture fixtures + run tests |
| `monitor-integration-test.sh` | Test monitor mode integration |

## Subdirectory

- `fixtures/` - Test fixture data (captured API responses)

## Snapshot Testing

Validates protocol compliance with Anthropic Messages API:
- Event sequence ordering
- Content block indices
- Tool input streaming
- Usage metrics presence
- Stop reasons
- Cache metrics

## Adding New Tests

1. Create `{feature}.test.ts` following existing patterns
2. Use fixtures from `fixtures/` or capture new ones with `capture-fixture.ts`
3. Run `npm run test-snapshot` to verify protocol compliance
