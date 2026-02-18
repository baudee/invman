---
name: feature-team
description: Full-stack team for implementing features end-to-end, from ideation to production-ready code.
---

# Feature Implementation Team

## Team Composition

| Role | Agent | Skills |
|------|-------|--------|
| Brainstormer | `agents/brainstormer` | — |
| Product Manager | `agents/pm` | — |
| Flutter Developer | `agents/senior-dev` | `skills/implementation/flutter-patterns` |
| Serverpod Developer | `agents/senior-dev` | `skills/implementation/serverpod-patterns` |
| Flutter Reviewer | `agents/reviewer` | `skills/verification/verify-flutter` |
| Serverpod Reviewer | `agents/reviewer` | `skills/verification/verify-serverpod` |

## Workflow

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

## Phase Details

### 1. Brainstorm

**Agent:** Brainstormer

**Input:** Feature idea or request from user

**Process:**
- Understand project context (read CLAUDE.md, stack skills)
- Ask clarifying questions one at a time
- Explore 2-3 approaches with trade-offs
- Present design in sections, validate incrementally

**Exit criteria:** User approves the design

---

### 2. Plan

**Agent:** PM

**Input:** Approved brainstorm document

**Process:**
- Define MVP scope — cut aggressively
- Break into deployable phases
- Define acceptance criteria for each phase
- Identify parallel work streams (Flutter/Serverpod)

**Exit criteria:** User approves the plan

---

### 3. Implement

**Agents:** Flutter Dev, Serverpod Dev (parallel when no dependencies)

**Input:** Approved plan, current phase

**Process:**
- Read assigned phase from plan
- Design approach, get approval before coding
- Implement incrementally with tests
- Follow stack-specific patterns

**Coordination:**
- If phase has cross-stack dependencies, Serverpod goes first (API contracts)
- Flutter dev waits for API to be defined before integrating
- Use sync points defined in plan

**Output:** Working code with tests

**Exit criteria:** All phase tasks complete, tests pass locally

---

### 4. Review

**Agents:** Flutter Reviewer, Serverpod Reviewer (parallel)

**Input:** Completed implementation

**Process:**
- Run verification checklist for stack
- Run test suite and linters
- Check implementation matches plan intent
- Produce verification report

**Verdicts:**
- `PASS` — Code is ready, proceed to commit
- `FAIL` — Issues found, return to implement with specific feedback

**Output:** Verification report with verdict

**Exit criteria:** Both reviewers return PASS

---

### 5. Commit

**Skill:** `skills/git/commit-conventions`

**Trigger:** Both reviewers PASS

**Process:**
- Stage all changes
- Write commit message following conventions
- Commit (do not push unless explicitly requested)

---

## Coordination Rules

1. **Sequential phases:** Brainstorm → Plan → Implement → Review → Commit
2. **Parallel within phases:** Flutter and Serverpod work can happen simultaneously when independent
3. **Sync points:** When frontend needs backend API, backend must complete first
4. **Review loop:** On FAIL, devs fix issues and reviewers re-review
5. **Single commit:** All work for a phase is committed together after review passes
