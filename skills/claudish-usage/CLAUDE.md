# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this directory.

## Directory Overview

Claudish usage skill - comprehensive guide for AI agents using Claudish CLI.

## Files

| File | Purpose |
|------|---------|
| `SKILL.md` | Complete skill document (1300+ lines) |

## SKILL.md Contents

The skill document covers:

1. **Critical Rules**: Never run Claudish directly in main context
2. **Agent Selection**: Which agent type to use for different tasks
3. **File-Based Patterns**: Instruction files to avoid context pollution
4. **Sub-Agent Delegation**: How to properly delegate to sub-agents
5. **Model Selection**: Choosing the right model for tasks
6. **CLI Reference**: All flags and options
7. **Error Handling**: Common errors and solutions
8. **Anti-Patterns**: What to avoid

## Key Principle

**Always use sub-agents with file-based instructions** when running Claudish to prevent context window pollution (10K+ tokens per run).

## Installation

This skill is installed to projects via `claudish --init` which copies it to `.claude/skills/claudish-usage/`.
