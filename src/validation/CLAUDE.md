# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this directory.

## Directory Overview

Validation system for analyzing Claude Code project configurations (agents, commands, skills, documentation).

## Key Files

| File | Purpose |
|------|---------|
| `types.ts` | Validation types - issues, reports, improvement plans |
| `validator.ts` | Core validation logic for project components |
| `orchestrator.ts` | Coordinates validation across project areas |

## Type Definitions

```typescript
type IssueSeverity = "critical" | "high" | "medium" | "low";
type ImprovementCategory = "mandatory" | "recommended" | "optional";

interface ValidationIssue {
  path: string;
  line?: number;
  severity: IssueSeverity;
  category: ImprovementCategory;
  message: string;
  hypothesis?: string;
  improvement?: string;
  details?: string;
}

interface ValidationResult {
  project: ValidationReport;
  agents: ValidationReport;
  commands: ValidationReport;
  skills: ValidationReport;
  documentation: ValidationReport;
}
```

## Validation Areas

- **Project**: Overall project configuration
- **Agents**: `.claude/agents/` definitions
- **Commands**: `.claude/commands/` definitions
- **Skills**: `.claude/skills/` definitions
- **Documentation**: README and docs quality

## Usage

The validator is used to analyze Claude Code project setups and provide improvement suggestions with prioritized scores based on impact, ease, and urgency.
