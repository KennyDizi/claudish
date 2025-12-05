# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this directory.

## Directory Overview

Build and utility scripts for Claudish.

## Files

| File | Purpose |
|------|---------|
| `extract-models.ts` | Extracts model list from config for documentation |
| `postinstall.cjs` | Post-install hook for npm package |

## extract-models.ts

Generates model list from `src/config.ts` for:
- README documentation
- CLI `--models` output
- Build process

Run with: `npm run extract-models`

## postinstall.cjs

CommonJS script that runs after `npm install`:
- Sets up any required post-installation configuration
- Uses `.cjs` extension for Node.js CommonJS compatibility
