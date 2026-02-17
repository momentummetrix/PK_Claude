# Meta-Governance: This Repository's Dual Nature

**This repository is BOTH a PK project template AND a working infrastructure for Momentum Metrix pharmacometric workflows.**

Understanding this distinction is critical for deciding what to commit, what to document, and where to save learnings.

---

## The Two Identities

### Identity 1: PK Project Template
- Team members fork this repo to bootstrap PopPK/PD model development projects
- Provides NONMEM conventions, model development workflow, quality gates
- Includes skills, agents, and rules for pharmacometric analysis with Claude Code
- Originated from Pedro Sant'Anna's academic Claude Code template (Beamer/Quarto/R)

### Identity 2: Working Infrastructure
- We iterate on skills, rules, and agents to improve the PK workflow
- We accumulate learnings specific to NONMEM, xpose, aipharma tooling
- We test new features and refine the template before team adoption
- Academic slide infrastructure (Beamer/Quarto) is preserved for training materials

---

## Decision Framework

When creating or modifying content, ask:

### "Is this GENERIC or SPECIFIC?"

**GENERIC (commit to repo, helps all team members):**
- PK workflow patterns (model development phases, covariate testing, quality gates)
- NONMEM conventions (THETA!=0, run numbering, estimation methods)
- Skills, agents, rules for pharmacometric analysis
- Templates (control streams, reports, data specs)
- Academic slide infrastructure (Beamer/Quarto for training materials)

**SPECIFIC (keep local or gitignore):**
- Machine-specific NONMEM installation paths (`/opt/nm75/`, etc.)
- Project-specific data paths and dataset filenames
- Client/sponsor-specific configurations
- Personal preferences (local quality gate overrides)
- API keys, credentials, local workarounds

---

## Memory Management: Two-Tier System

### MEMORY.md (root directory, committed)

**Purpose:** Generic learnings that help ALL team members

**What goes here:**
- PK workflow patterns: `[LEARN:nonmem] THETA initial estimates can NEVER be zero`
- Model development: `[LEARN:workflow] Forward addition dOFV>=3.84, backward elimination dOFV>=6.63`
- Quality standards: `[LEARN:quality] 80/90/95 thresholds with NONMEM auto-fail conditions`
- Tool patterns: `[LEARN:tools] Use xpose for NONMEM output parsing, aipharma for workflow`

**Review cadence:** After every significant session (plan approval, feature implementation)

**Size limit:** Keep under 200 lines (stays in Claude's system prompt)

---

### .claude/state/personal-memory.md (gitignored, local only)

**Purpose:** Machine-specific and user-specific learnings

**What goes here:**
- Machine setup: `[LEARN:nonmem] NONMEM installed at /opt/nm75/ on this machine`
- Tool quirks: `[LEARN:tools] xpose4 requires explicit runno format "001" not "1"`
- Local paths: `[LEARN:files] Project datasets at /data/clinical/study123/`
- Personal workflow: `[LEARN:workflow] I prefer running NONMEM via PSN execute command`

**Review cadence:** As needed (no pressure to formalize)

**Size limit:** None (doesn't load into context automatically)

---

## Cross-Machine Access

### Scenario: User Works on Multiple Machines

**Machine A (office desktop):**
- Clone repo → gets MEMORY.md with generic learnings ✓
- Gets all infrastructure (skills, agents, rules, templates) ✓
- Gets up-to-date guide and documentation ✓
- Builds `.claude/state/personal-memory.md` specific to desktop setup

**Machine B (laptop):**
- Clone same repo → gets same MEMORY.md ✓
- Gets same infrastructure ✓
- Builds DIFFERENT `.claude/state/personal-memory.md` for laptop setup

**Key insight:** Generic patterns sync via git, personal patterns stay local (or manually copied if truly needed).

---

## Dogfooding: Following Our Own Guide

**We must follow the patterns we recommend to users.**

### Plan-First Workflow
✅ Do: Enter plan mode for non-trivial tasks (>3 files, >1 hour, multi-step)
✅ Do: Save plans to `quality_reports/plans/YYYY-MM-DD_description.md`
❌ Don't: Skip planning for "quick fixes" that turn into multi-hour tasks

### Spec-Then-Plan
✅ Do: Create requirements specs for complex/ambiguous tasks
✅ Do: Use MUST/SHOULD/MAY framework with clarity status
❌ Don't: Jump straight to planning when requirements are fuzzy

### Quality Gates
✅ Do: Run quality scoring before commits
✅ Do: Nothing ships below 80/100
❌ Don't: Commit "WIP" code without quality verification

### Documentation Standards
✅ Do: Update README and guide together when adding features
✅ Do: Keep dates current (frontmatter, "Last Updated" fields)
❌ Don't: Let documentation drift from implementation

### Context Survival
✅ Do: Update MEMORY.md with [LEARN] entries after sessions
✅ Do: Save active plans to disk before compression
✅ Do: Keep session logs current (last 10 minutes)
❌ Don't: Rely solely on conversation history (it compresses)

---

## Template Maintenance Principles

### Keep It Generic

**Bad (too specific):**
```markdown
# NONMEM Path Rule
Always use /opt/nm75/run/nmfe75 for NONMEM execution.
```

**Good (framework-oriented):**
```markdown
# NONMEM Execution Rule
Configure NONMEM path in config.yaml. Use nmfe75/nmfe74 or PSN execute.
```

### Provide Examples from Multiple Domains

**Bad (single use case):**
```markdown
Example: 2-CMT oral PK model with allometric scaling
```

**Good (diverse use cases):**
```markdown
Examples:
- PopPK: 2-CMT oral absorption with covariate effects on CL
- PKPD: Indirect response model with E_max drug effect
- PMX: Time-to-event analysis with repeated events
```

### Use Templates Not Prescriptions

**Bad (prescriptive):**
```markdown
Your dataset MUST be named pk_data_YYYYMMDD.csv and live in data/derived/.
```

**Good (template with placeholders):**
```markdown
Configure dataset location in config.yaml:
[YOUR_DATASET] (e.g., pk_data_20240101.csv, study123_nm.csv)
```

---

## When to Make Exceptions

### Templates Can Show Specific Examples

It's okay for README to say:
> "This workflow was developed at Momentum Metrix for PopPK analysis..."

As long as it's clear this is ONE example, not THE requirement.

### CLAUDE.md Can Have Placeholders

The template CLAUDE.md has `[PROJECT_NAME]`, `[COMPOUND]`, `[INDICATION]` — this is correct. Team members fill them in per project.

### Documentation Can Reference Original Use Case

Pedagogically valuable to show real-world example:
> "Case Study: PopPK model development for Drug X, 15 runs, base → covariate → final"

This shows what's POSSIBLE, not what's REQUIRED.

---

## Amendment Process

As this repository evolves, meta-governance may need updates.

**When to amend this file:**
- We discover better ways to distinguish generic vs specific
- Cross-machine workflows change (e.g., Claude Code adds cloud sync)
- Memory system evolves (e.g., automatic [LEARN] extraction)
- User feedback reveals confusion about template vs working project

**Amendment protocol:**
1. Propose change in session log or plan
2. Discuss implications (what breaks? what improves?)
3. Update this file
4. Document change with [LEARN:meta-governance] entry in MEMORY.md

---

## Quick Reference Table

| Content Type | Commit to Repo? | Where It Goes | Syncs Across Machines? |
|--------------|----------------|---------------|----------------------|
| Workflow patterns (generic) | ✅ Yes | MEMORY.md | ✅ Yes (via git) |
| Machine-specific setup | ❌ No | .claude/state/personal-memory.md | ❌ No (gitignored) |
| Templates (generic) | ✅ Yes | templates/ | ✅ Yes |
| Skills (generic) | ✅ Yes | .claude/skills/ | ✅ Yes |
| Rules (path-scoped, generic) | ✅ Yes | .claude/rules/ | ✅ Yes |
| Agents (generic) | ✅ Yes | .claude/agents/ | ✅ Yes |
| Hooks (generic behavior) | ✅ Yes | .claude/hooks/ | ✅ Yes |
| Session logs | ✅ Yes | quality_reports/session_logs/ | ✅ Yes |
| Plans | ✅ Yes | quality_reports/plans/ | ✅ Yes |
| Local settings | ❌ No | .claude/settings.local.json | ❌ No (gitignored) |
| Session state | ❌ No | .claude/state/ | ❌ No (gitignored) |
| Build artifacts | ❌ No | .aux, .log, .synctex.gz | ❌ No (gitignored) |
| NONMEM outputs | ❌ No | *.ext, *.phi, *.shk, etc. | ❌ No (gitignored) |
| Model dev log | ✅ Yes | model_development_log.yaml | ✅ Yes (protected) |
| NONMEM templates | ✅ Yes | templates/*.mod | ✅ Yes |

---

## Summary

**This repository serves two masters:**
1. A PK project template (generic PK workflow, NONMEM conventions, Claude Code infrastructure)
2. Working infrastructure for Momentum Metrix (evolving tools, team-specific patterns)

**The solution:**
- Commit generic PK patterns that help all team members (MEMORY.md, templates, skills)
- Keep project-specific learnings local (.claude/state/personal-memory.md, gitignored)
- Dogfood our own workflow (plan-first, quality gates, model development protocol)
- Document with examples from multiple PK scenarios (PopPK, PKPD, PMX)
- Review quarterly: promote generic patterns, refine project-specific ones

**When in doubt:** Ask "Would a pharmacometrician forking this repo for a new PopPK project benefit from this knowledge?" If yes → MEMORY.md. If no → personal-memory.md.
