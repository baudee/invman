---
description: Create a team to implement or modify a feature end-to-end
allowed-tools: Task, TodoWrite, Read, Glob, Grep, Edit, Write, Bash, AskUserQuestion, mcp__dart__*, mcp__serverpod__*, Skill
---

# Feature Team Orchestrator

You are orchestrating the **Feature Team** to implement a feature from ideation to production-ready code.

## Feature Request

$ARGUMENTS

## Instructions

1. Read the team definition at `.claude/teams/feature-team.md`
2. Follow the workflow defined there: Brainstorm → Plan → Implement → Review → Commit
3. Use TodoWrite to track progress through each phase
4. Get user approval before brainstorm, plan and commit phases

## Agent Mapping

Use the Task tool with these `subagent_type` values:
- Brainstormer → `brainstormer`
- PM → `pm`
- Flutter/Serverpod Dev → `dev`
- Flutter/Serverpod Reviewer → `reviewer`

## Start Now

Read the team file, then begin with **Phase 1: Brainstorm**.
