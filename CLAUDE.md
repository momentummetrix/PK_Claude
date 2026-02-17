# CLAUDE.MD -- PopPK/PD Project Development with Claude Code

<!-- HOW TO USE: Replace [BRACKETED PLACEHOLDERS] with your project info.
     Customize Beamer environments and CSS classes for your theme.
     Keep this file under ~200 lines — Claude loads it every session.
     See the guide at docs/workflow-guide.html for full documentation. -->

**Project:** [PROJECT_NAME]
**Compound:** [COMPOUND]
**Indication:** [INDICATION]
**Sponsor:** [SPONSOR]
**Institution:** Momentum Metrix
**Branch:** main

---

## Core Principles

- **Plan first** -- enter plan mode before non-trivial tasks; save plans to `quality_reports/plans/`
- **Verify after** -- compile/render and confirm output at the end of every task
- **Single source of truth** -- NONMEM `.mod` is authoritative for model specification
- **Never hardcode parameter values** -- always pull from NONMEM output so reports auto-update
- **Model development log for every run** -- no exceptions
- **Quality gates** -- nothing ships below 80/100
- **[LEARN] tags** -- when corrected, save `[LEARN:category] wrong -> right` to MEMORY.md

---

## Folder Structure

```
[PROJECT_NAME]/
├── CLAUDE.MD                    # This file
├── .claude/                     # Rules, skills, agents, hooks
├── Bibliography_base.bib        # Centralized bibliography
├── Figures/                     # Figures and images
├── Preambles/header.tex         # LaTeX headers
├── Slides/                      # Beamer .tex files
├── Quarto/                      # RevealJS .qmd files + theme
├── docs/                        # GitHub Pages (auto-generated)
├── scripts/                     # Utility scripts + R code
├── quality_reports/             # Plans, session logs, merge reports
├── explorations/                # Research sandbox (see rules)
├── templates/                   # Session log, quality report, NONMEM templates
├── master_supporting_docs/      # Papers and existing slides
├── data/
│   ├── raw/                     # Source datasets (gitignored)
│   ├── derived/                 # NONMEM-ready datasets
│   └── specs/                   # Dataset specifications
├── models/                      # NONMEM runs (run1XX-3XX)
├── reports/
│   ├── interim/                 # Development updates
│   ├── final/                   # Regulatory submissions
│   └── figures/                 # Publication figures
├── config.yaml                  # Project configuration
└── model_development_log.yaml   # Run tracking
```

---

## Commands

```bash
# LaTeX (3-pass, XeLaTeX only)
cd Slides && TEXINPUTS=../Preambles:$TEXINPUTS xelatex -interaction=nonstopmode file.tex
BIBINPUTS=..:$BIBINPUTS bibtex file
TEXINPUTS=../Preambles:$TEXINPUTS xelatex -interaction=nonstopmode file.tex
TEXINPUTS=../Preambles:$TEXINPUTS xelatex -interaction=nonstopmode file.tex

# Deploy Quarto to GitHub Pages
./scripts/sync_to_docs.sh LectureN

# Quality score
python scripts/quality_score.py Quarto/file.qmd

# NONMEM submission
nmfe75 models/runXXX/runXXX.mod models/runXXX/runXXX.lst

# aipharma model evaluation
Rscript -e "aipharma::evaluate_run('XXX', 'models')"

# Quality score for control streams
python scripts/quality_score.py models/runXXX/runXXX.mod
```

---

## Quality Thresholds

| Score | Gate | Meaning |
|-------|------|---------|
| 80 | Commit | Good enough to save |
| 90 | PR | Ready for review |
| 95 | Excellence | Regulatory-ready |

NONMEM auto-fail conditions: THETA initial estimate = 0, missing convergence, missing covariance step.

---

## PK Skills Quick Reference

| Command | What It Does |
|---------|-------------|
| `/model-eval <run>` | Check run status + GOF plots + parameter extraction |
| `/new-run <new> <base> "desc"` | Create new run from existing |
| `/model-log <action>` | Model development log management |
| `/batch-compare [runs]` | Compare multiple runs side-by-side |
| `/covariate-test <base_run>` | Forward addition + backward elimination |
| `/validate-model <run> [type]` | VPC, bootstrap, NPDE validation |
| `/data-qc` | Dataset quality control |
| `/model-template` | NONMEM control stream templates |
| `/generate-report <type> <run>` | PopPK reports |
| `/dashboard <run>` | Interactive model dashboard |

## Academic Skills Quick Reference

| Command | What It Does |
|---------|-------------|
| `/compile-latex [file]` | 3-pass XeLaTeX + bibtex |
| `/deploy [LectureN]` | Render Quarto + sync to docs/ |
| `/extract-tikz [LectureN]` | TikZ -> PDF -> SVG |
| `/proofread [file]` | Grammar/typo/overflow review |
| `/visual-audit [file]` | Slide layout audit |
| `/pedagogy-review [file]` | Narrative, notation, pacing review |
| `/review-r [file]` | R code quality review |
| `/qa-quarto [LectureN]` | Adversarial Quarto vs Beamer QA |
| `/slide-excellence [file]` | Combined multi-agent review |
| `/translate-to-quarto [file]` | Beamer -> Quarto translation |
| `/validate-bib` | Cross-reference citations |
| `/devils-advocate` | Challenge slide design |
| `/create-lecture` | Full lecture creation |
| `/commit [msg]` | Stage, commit, PR, merge |
| `/lit-review [topic]` | Literature search + synthesis |
| `/research-ideation [topic]` | Research questions + strategies |
| `/interview-me [topic]` | Interactive research interview |
| `/review-paper [file]` | Manuscript review |
| `/data-analysis [dataset]` | End-to-end R analysis |

---

## Current Model State

| Run | Type | Description | OFV | dOFV | Status |
|-----|------|-------------|-----|------|--------|
| [Fill during development] | | | | | |

---

<!-- CUSTOMIZE: Replace the example entries below with your own
     Beamer environments and Quarto CSS classes. These are examples
     from the original project — delete them and add yours. -->

## Beamer Custom Environments

| Environment       | Effect        | Use Case       |
|-------------------|---------------|----------------|
| `[your-env]`      | [Description] | [When to use]  |

<!-- Example entries (delete and replace with yours):
| `keybox` | Gold background box | Key points |
| `highlightbox` | Gold left-accent box | Highlights |
| `definitionbox[Title]` | Blue-bordered titled box | Formal definitions |
-->

## Quarto CSS Classes

| Class              | Effect        | Use Case       |
|--------------------|---------------|----------------|
| `[.your-class]`    | [Description] | [When to use]  |

<!-- Example entries (delete and replace with yours):
| `.smaller` | 85% font | Dense content slides |
| `.positive` | Green bold | Good annotations |
-->

---

## Current Project State

| Phase | Status | Key Deliverable |
|-------|--------|----------------|
| Data QC | [Not Started] | Clean NONMEM dataset |
| Base Model | [Not Started] | Structural + IIV + residual error |
| Covariate Model | [Not Started] | Statistically justified covariates |
| Final Model | [Not Started] | Validated final model |
| Reporting | [Not Started] | PopPK report |
