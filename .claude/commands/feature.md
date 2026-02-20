---
description: Create a team to implement or modify a feature end-to-end
allowed-tools: Task, TodoWrite, Read, Glob, Grep, Edit, Write, Bash, AskUserQuestion, mcp__dart__*, mcp__serverpod__*, Skill
---

# Feature Team Orchestrator

You are orchestrating the **Feature Team** to implement a feature from ideation to production-ready code.

## Feature Request

$ARGUMENTS

## Feature Implementation Team

### Team Composition

| Role | Agent | Skills |
|------|-------|--------|
| Brainstormer | `.claude/agents/brainstormer` | — |
| Product Manager | `.claude/agents/pm` | — |
| Flutter Developer | `.claude/agents/senior-dev` | `.claude/skills/execution/flutter-patterns` |
| Serverpod Developer | `.claude/agents/senior-dev` | `.claude/skills/execution/serverpod-patterns` |
| Flutter Reviewer | `.claude/agents/reviewer` | `.claude/skills/verification/verify-flutter` |
| Serverpod Reviewer | `.claude/agents/reviewer` | `.claude/skills/verification/verify-serverpod` |

### Workflow

```
┌─────────────┐
│ BRAINSTORM  │  Explore the idea, ask questions, produce design doc
└──────┬──────┘
       │
       ▼
┌─────────────┐
│   PLAN      │  PM defines phased implementation plan from design
└──────┬──────┘
       │
       ▼
┌─────────────────────────────┐
│        IMPLEMENT            │  Devs work in parallel on their stack
│  ┌─────────┐  ┌──────────┐  │
│  │ Flutter │  │ Serverpod│  │
│  │   Dev   │  │   Dev    │  │
│  └─────────┘  └──────────┘  │
└──────────────┬──────────────┘
               │
               ▼
┌─────────────────────────────┐
│         REVIEW              │  Reviewers verify their stack
│  ┌─────────┐  ┌──────────┐  │
│  │ Flutter │  │ Serverpod│  │
│  │Reviewer │  │ Reviewer │  │
│  └─────────┘  └──────────┘  │
└──────────────┬──────────────┘
               │
       ┌───────┴───────┐
       │               │
       ▼               ▼
   [PASS]          [FAIL]
       │               │
       ▼               └──► Back to IMPLEMENT
┌─────────────┐
│   COMMIT    │  Using commit-conventions skill
└─────────────┘
```
