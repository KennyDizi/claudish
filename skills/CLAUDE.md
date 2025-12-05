# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this directory.

## Directory Overview

Claude Code skills that can be installed in projects for automatic Claudish integration.

## Subdirectory

- `claudish-usage/` - Main Claudish usage skill

## What are Skills?

Skills are installable guides that help Claude Code agents use Claudish correctly:
- Installed via `claudish --init`
- Located in project's `.claude/skills/` directory
- Automatically loaded when relevant topics are mentioned

## Installing Skills

```bash
# Install Claudish skill in your project
claudish --init

# This creates .claude/skills/claudish-usage/SKILL.md
```
