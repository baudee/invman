# Global Developer Defaults

## How to Work With Me

- **Ask before assuming.** If requirements are ambiguous, ask a clarifying question rather than guessing.
- **Plan before coding.** For anything beyond a trivial change, outline your approach before writing code.
- **Work in small steps.** Implement one thing at a time, verify it works, then move on.
- **Read before modifying.** Understand the patterns already in use and follow them.
- **Don't refactor while building.** Note it and move on. Mixing refactoring with feature work makes both harder to review.

## Workflow Rules

- When executing phased implementation plans, start making code changes immediately. Do NOT spend the entire session exploring the codebase without producing output. If exploration is needed, timebox it to 2-3 minutes then begin implementation.
- Always run commands from the correct project directory. Before executing any shell command, verify the current working directory matches the target sub-project. Never mix files between sub-projects (e.g., frontend files into backend folder).

## Tech Stack

This project uses Serverpod for backends and Flutter for frontends, typically in a Docker Compose setup. Always assume this stack unless told otherwise.

## Communication

- Be direct and concise. Skip preamble.
- Lead with the what and why, not the thought process.
- If something is broken, say what's broken and how to fix it.
- When unsure, say so explicitly with what you'd need to become sure.

## Code Quality Defaults

- Write tests alongside implementation, not after.
- Handle errors explicitly — no silent failures, no bare excepts, no empty catch blocks.
- Prefer readability over cleverness.
- Use meaningful names. If you need a comment to explain what a variable is, rename it.
- Follow existing project conventions. Consistency beats preference.
- Don't leave dead code, TODOs without context, or commented-out blocks.
- Comment the code only when neccessary. If you find yourself writing a comment, consider if the code can be made clearer instead.

## Testing & Verification

After implementing any feature, always run the full test suite.
- For Flutter, at root level, run `make app/build` and then `make app/test`
- For Serverpod, at root level, run `make server/build` and then `make server/test`
Do not consider a phase complete until all checks pass.

## Debugging

- Gather evidence before proposing a fix. Read the error, check the code, understand the cause.
- Don't shotgun-fix by trying multiple things at once. Change one thing, test, iterate.
- If a fix works but you don't understand why, keep investigating.

## Context Awareness

- Use `/compact` proactively when context is getting heavy.
- If you've lost track, re-read the plan or task description before continuing.
- When starting a new task, state what you understand the goal to be before diving in.

## Skills

Read the relevant skill file when working on a related task.

**Skills:**
- `skills/execution/serverpod-patterns.md` — Skill: Serverpod Patterns
- `skills/verification/verify-serverpod.md` — Skill: Verify Serverpod
- `skills/execution/flutter-patterns.md` — Skill: Flutter Patterns
- `skills/verification/verify-flutter.md` — Skill: Verify Flutter

**Agents:**
- `agents/dev.md` — Agent: Developer
- `agents/brainstormer.md` — Agent: Brainstormer
- `agents/pm.md` — Agent: Product Manager
- `agents/reviewer.md` — Agent: Reviewer
- `agents/debugger.md` — Agent: Debugger

## Project Structure

### Backend: Serverpod

- **Location**: `invman_server/`
- **Stack**: Serverpod
- **Key patterns**: See `skills/execution/serverpod-patterns.md`

### Frontend: Flutter

- **Location**: `invman_flutter/`
- **Stack**: Dart, Flutter
- **Key patterns**: See `skills/execution/flutter-patterns.md`

