# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this directory.

## Directory Overview

Technical documentation for AI agents and developers working on Claudish internals. These docs explain architecture decisions, protocol specifications, and implementation details.

## Document Categories

### Protocol & Compliance
| Document | Purpose |
|----------|---------|
| `PROTOCOL_SPECIFICATION.md` | Complete Anthropic Messages API protocol spec |
| `PROTOCOL_COMPLIANCE_PLAN.md` | Roadmap for protocol compliance |
| `STREAMING_PROTOCOL_EXPLAINED.md` | SSE streaming protocol details |
| `CLAUDE_CODE_PROTOCOL_COMPLETE.md` | Claude Code communication protocol |

### Architecture
| Document | Purpose |
|----------|---------|
| `MODEL_ADAPTER_ARCHITECTURE.md` | Adapter pattern explanation |
| `IMPLEMENTATION_COMPLETE.md` | Technical implementation summary |
| `THINKING_ALIGNMENT_SUMMARY.md` | Thinking/reasoning mode alignment |

### Model-Specific Issues
| Document | Purpose |
|----------|---------|
| `GROK_*.md` | Grok model issues and fixes |
| `GEMINI_*.md` | Gemini model issues and fixes |

### Features
| Document | Purpose |
|----------|---------|
| `MONITOR_MODE_COMPLETE.md` | Monitor mode implementation |
| `MONITOR_MODE_FINDINGS.md` | Findings from monitor mode analysis |
| `CACHE_METRICS_ENHANCEMENT.md` | Cache metrics feature |
| `TIMEOUT_CONFIGURATION_CLARIFICATION.md` | Timeout handling |

### Codebase Analysis
| Document | Purpose |
|----------|---------|
| `claudish-CODEBASE_ANALYSIS.md` | Full codebase analysis |
| `claudish-EXPLORATION_INDEX.md` | Index of explored areas |
| `claudish-FINDINGS_SUMMARY.md` | Summary of findings |
| `claudish-KEY_CODE_LOCATIONS.md` | Important code locations |
| `claudish-QUICK_REFERENCE.md` | Quick reference guide |
| `REMAINING_5_PERCENT_ANALYSIS.md` | Edge cases and remaining issues |

## Usage

These docs are primarily for:
1. Understanding why certain design decisions were made
2. Debugging protocol compliance issues
3. Adding support for new models
4. Understanding streaming event ordering requirements
