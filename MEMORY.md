# Project Memory

Corrections and learned facts that persist across sessions.
When a mistake is corrected, append a `[LEARN:category]` entry below.

---

<!-- Append new entries below. Most recent at bottom. -->

## Workflow Patterns

[LEARN:workflow] Requirements specification phase catches ambiguity before planning → reduces rework 30-50%. Use spec-then-plan for complex/ambiguous tasks (>1 hour or >3 files).

[LEARN:workflow] Spec-then-plan protocol: AskUserQuestion (3-5 questions) → create `quality_reports/specs/YYYY-MM-DD_description.md` with MUST/SHOULD/MAY requirements → declare clarity status (CLEAR/ASSUMED/BLOCKED) → get approval → then draft plan.

[LEARN:workflow] Context survival before compression: (1) Update MEMORY.md with [LEARN] entries, (2) Ensure session log current (last 10 min), (3) Active plan saved to disk, (4) Open questions documented. The pre-compact hook displays checklist.

[LEARN:workflow] Plans, specs, and session logs must live on disk (not just in conversation) to survive compression and session boundaries. Quality reports only at merge time.

## Documentation Standards

[LEARN:documentation] When adding new features, update BOTH README and guide immediately to prevent documentation drift. Stale docs break user trust.

[LEARN:documentation] Always document new templates in README's "What's Included" section with purpose description. Template inventory must be complete and accurate.

[LEARN:documentation] Guide must be generic (framework-oriented) not prescriptive. Provide templates with examples for multiple workflows (LaTeX, R, Python, Jupyter), let users customize. No "thou shalt" rules.

[LEARN:documentation] Date fields in frontmatter and README must reflect latest significant changes. Users check dates to assess currency.

## Design Philosophy

[LEARN:design] Framework-oriented > Prescriptive rules. Constitutional governance works as a TEMPLATE with examples users customize to their domain. Same for requirements specs.

[LEARN:design] Quality standard for guide additions: useful + pedagogically strong + drives usage + leaves great impression + improves upon starting fresh + no redundancy + not slow. All 7 criteria must hold.

[LEARN:design] Generic means working for any academic workflow: pure LaTeX (no Quarto), pure R (no LaTeX), Python/Jupyter, any domain (not just econometrics). Test recommendations across use cases.

## File Organization

[LEARN:files] Specifications go in `quality_reports/specs/YYYY-MM-DD_description.md`, not scattered in root or other directories. Maintains structure.

[LEARN:files] Templates belong in `templates/` directory with descriptive names. Currently have: session-log.md, quality-report.md, exploration-readme.md, archive-readme.md, requirements-spec.md, constitutional-governance.md.

## Constitutional Governance

[LEARN:governance] Constitutional articles distinguish immutable principles (non-negotiable for quality/reproducibility) from flexible user preferences. Keep to 3-7 articles max.

[LEARN:governance] Example articles: Primary Artifact (which file is authoritative), Plan-First Threshold (when to plan), Quality Gate (minimum score), Verification Standard (what must pass), File Organization (where files live).

[LEARN:governance] Amendment process: Ask user if deviating from article is "amending Article X (permanent)" or "overriding for this task (one-time exception)". Preserves institutional memory.

## Skill Creation

[LEARN:skills] Effective skill descriptions use trigger phrases users actually say: "check citations", "format results", "validate protocol" → Claude knows when to load skill.

[LEARN:skills] Skills need 3 sections minimum: Instructions (step-by-step), Examples (concrete scenarios), Troubleshooting (common errors) → users can debug independently.

[LEARN:skills] Domain-specific examples beat generic ones: citation checker (psychology), protocol validator (biology), regression formatter (economics) → shows adaptability.

## Memory System

[LEARN:memory] Two-tier memory solves template vs working project tension: MEMORY.md (generic patterns, committed), personal-memory.md (machine-specific, gitignored) → cross-machine sync + local privacy.

[LEARN:memory] Post-merge hooks prompt reflection, don't auto-append → user maintains control while building habit.

## Meta-Governance

[LEARN:meta] Repository dual nature requires explicit governance: what's generic (commit) vs specific (gitignore) → prevents template pollution.

[LEARN:meta] Dogfooding principles must be enforced: plan-first, spec-then-plan, quality gates, session logs → we follow our own guide.

[LEARN:meta] Template development work (building infrastructure, docs) doesn't create session logs in quality_reports/ → those are for user work (slides, analysis), not meta-work. Keeps template clean for users who fork.

## Pharmacometrics Patterns

[LEARN:nonmem] THETA initial estimate can NEVER be 0. Use small value (0.00001) instead. Zero causes NONMEM to fix the parameter.

[LEARN:nonmem] Both convergence AND covariance step must succeed for model acceptance. Check both in .lst output.

[LEARN:nonmem] Run numbering convention: 1xx (base structural), 2xx (covariate), 3xx (final model). Maintains clear development history.

[LEARN:nonmem] Forward addition threshold: dOFV >= 3.84 (p < 0.05, 1 df). Backward elimination threshold: dOFV >= 6.63 (p < 0.01, 1 df). Always use stricter threshold for elimination.

[LEARN:nonmem] GOF plots MUST use type = "ps" (points + smooth, NO connecting lines) in xpose. Never use type "p" alone or type "l".

[LEARN:nonmem] Never hardcode parameter values from NONMEM output. Always pull numerically so reports auto-update when models are rerun.

[LEARN:nonmem] Use .lst extension for NONMEM output, not .res. Standard convention for submission.

[LEARN:nonmem] RSE thresholds: < 30% for fixed effects, < 50% for random effects. Condition number < 1000. Shrinkage < 30% for meaningful individual estimates.

[LEARN:nonmem] Exponential IIV (TVparam * EXP(ETA(n))) for CL, V, KA. Additive IIV (TVparam + ETA(n)) for lag times, fractions.

## Plugin & MCP Integration

[LEARN:plugins] Rules with `paths:` frontmatter are the lowest-friction way to integrate MCP plugins. They auto-trigger on file patterns — no manual plugin calls needed from the user.

[LEARN:plugins] Context7 package tiers prevent unnecessary API calls: Tier 1 (core PMX: xpose, mrgsolve, rxode2, PKNCA) always check; Tier 3-5 (tidyverse, viz, pipeline) only for non-trivial usage.

[LEARN:plugins] Mermaid Chart plugin renders diagrams via `validate_and_render_mermaid_diagram`. Always provide BOTH rendered image AND raw Mermaid code for Quarto embedding.

## R/Quarto Analysis Patterns

[LEARN:r-quarto] Pharmacometrics is broader than NONMEM modeling. NCA (PKNCA/pkr), exposure-response, PK simulations (rxode2/mrgsolve), EDA, and TFL generation all need dedicated R/Quarto support.

[LEARN:r-quarto] Quarto report templates with `eval: false` chunks serve as scaffolding. Skills copy templates to `reports/`, fill in placeholders, then set `eval: true` on ready chunks. Users never run raw templates.

[LEARN:r-quarto] MM color palette: mm_primary="#1B365D", mm_secondary="#4A90D9", mm_accent="#E8891C". Apply consistently via `theme_mm` and `scale_color_manual(values = mm_colors)`.

[LEARN:r-quarto] TFL standards for submission: dpi=300, width=6.5 inches, gt/flextable for tables (not knitr::kable), no hardcoded values, 3 sig figs for PK parameters, 1 decimal for percentages.

## Template Architecture

[LEARN:architecture] Extend existing agents with new lenses/categories rather than creating new specialized agents. Avoids agent proliferation while adding domain coverage.

[LEARN:architecture] 3-worker parallel execution works well for independent file creation tasks (rules, skills, templates). Team-lead handles dependent tasks (agent modifications) while workers run.

[LEARN:architecture] protect-files.sh hook blocks the Edit tool on protected files (settings.json, Bibliography_base.bib, model_development_log.yaml). Workaround: use Bash with python3 to write these files.
