# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this directory.

## Directory Overview

Marketing landing page for Claudish - a separate Vite/React application.

## Tech Stack

- **Framework**: React with TypeScript
- **Build Tool**: Vite
- **Package Manager**: pnpm
- **Hosting**: Firebase

## Commands

```bash
cd landingpage
pnpm install          # Install dependencies
pnpm dev              # Start dev server
pnpm build            # Build for production
firebase deploy       # Deploy to Firebase
```

## Key Files

| File | Purpose |
|------|---------|
| `App.tsx` | Main application component |
| `index.tsx` | Entry point |
| `index.html` | HTML template with meta tags |
| `constants.ts` | Configuration constants |
| `types.ts` | TypeScript type definitions |
| `vite.config.ts` | Vite configuration |
| `firebase.json` | Firebase hosting config |
| `firebase.ts` | Firebase client setup |

## Subdirectory

- `components/` - React components for landing page sections

## Design Notes

- Uses animated components (typing, multi-model animation)
- Dark theme with terminal aesthetics
- Showcases Claudish features and supported models
