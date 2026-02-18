# Momentum Metrix PK Claude Workflow

> **PK project template.** Fork this repo to get a ready-to-go PopPK/PD model development environment with Claude Code. Includes NONMEM conventions, model development tracking, specialized review agents, and automated quality gates. Built on the [academic Claude Code template](https://github.com/pedrohcgs/claude-code-my-workflow) by Pedro Sant'Anna.

**Last Updated:** 2026-02-17

---

## Quick Start (5 minutes)

### 1. Fork & Clone

```bash
git clone https://github.com/momentummetrix/PK_Claude.git my-pk-project
cd my-pk-project
```

### 2. Start Claude Code

```bash
claude
```

Then paste:

> I am starting a PopPK analysis for **[COMPOUND NAME]** in **[INDICATION]** for **[SPONSOR]**. The dataset is at **[PATH TO DATASET]**.
>
> This project uses the Momentum Metrix PK Claude workflow. Please read the configuration files, update `CLAUDE.md` and `config.yaml` with my project details, initialize the model development log, and enter plan mode to outline the analysis strategy.

### 3. What Happens Next

Claude reads all configuration files, fills in your project details, initializes the model development log, and enters contractor mode. You approve plans and Claude handles NONMEM model development, evaluation, and reporting autonomously.

---

## How It Works

### Contractor Mode

You describe a task. Claude plans the approach, implements it (writes NONMEM control streams, runs evaluations, generates diagnostics), runs specialized review agents, fixes issues, and scores against quality gates — all autonomously.

### Specialized Agents

11 focused agents each check one dimension:

- **proofreader** — grammar/typos in reports
- **slide-auditor** — visual layout for presentations
- **pedagogy-reviewer** — teaching quality for training materials
- **r-reviewer** — R code quality + PK domain correctness
- **domain-reviewer** — PK model specification, parameter plausibility, diagnostics
- **nonmem-reviewer** — NONMEM control stream review
- **tikz-reviewer** — diagram visual critique
- **beamer-translator** — Beamer-to-Quarto translation
- **quarto-critic** — adversarial Quarto QA
- **quarto-fixer** — implements critic fixes
- **verifier** — end-to-end verification including NONMEM runs

### Quality Gates

| Score | Gate | Meaning |
|-------|------|---------|
| 80 | Commit | Good enough to save |
| 90 | PR | Ready for review |
| 95 | Excellence | Regulatory-ready |

NONMEM auto-fail conditions: THETA initial estimate = 0, missing convergence, missing covariance step.

---

## What's Included

<details>
<summary><strong>11 agents, 37 skills, 22 rules, 7 hooks</strong> (click to expand)</summary>

### PK-Specific Skills

| Skill | What It Does |
|-------|-------------|
| `/model-eval <run>` | Comprehensive model evaluation + GOF plots |
| `/new-run <new> <base> "desc"` | Create new NONMEM run from existing |
| `/model-log <action>` | Model development log management |
| `/batch-compare [runs]` | Compare multiple runs side-by-side |
| `/covariate-test <base_run>` | Forward addition + backward elimination workflow |
| `/validate-model <run> [type]` | VPC, bootstrap, NPDE validation |
| `/data-qc` | Dataset quality control checks |
| `/model-template` | NONMEM control stream templates |
| `/generate-report <type> <run>` | PopPK reports (update, executive, regulatory) |
| `/dashboard <run>` | Interactive Quarto model dashboard |

### R/Quarto Analysis Skills

| Skill | What It Does |
|-------|-------------|
| `/nca-analysis [dataset]` | NCA workflow (PKNCA/pkr) → Quarto report |
| `/er-analysis [dataset]` | Exposure-response analysis → Quarto report |
| `/simulate [engine]` | PK/PD simulation (rxode2 or mrgsolve) |
| `/tfl-generator [type]` | Submission-ready Tables, Figures, Listings |
| `/eda [dataset]` | Exploratory data analysis → Quarto report |
| `/pk-diagram <type> <spec>` | Mermaid diagrams for PK models, workflows, data flows |

### Academic Skills (inherited)

| Skill | What It Does |
|-------|-------------|
| `/compile-latex` | 3-pass XeLaTeX compilation |
| `/deploy` | Render Quarto + sync to GitHub Pages |
| `/proofread` | Grammar/typo/overflow review |
| `/visual-audit` | Slide layout audit |
| `/slide-excellence` | Combined multi-agent review |
| `/translate-to-quarto` | Beamer to Quarto translation |
| `/commit` | Stage, commit, create PR |
| ... and 14 more |

### Agents

| Agent | What It Does |
|-------|-------------|
| `nonmem-reviewer` | NONMEM control stream review (structure, statistics, conventions) |
| `domain-reviewer` | PK model specification, parameter plausibility, diagnostic interpretation |
| `r-reviewer` | R code quality + PK domain correctness (xpose, aipharma) |
| `verifier` | End-to-end verification including NONMEM .lst checks |
| `proofreader` | Grammar, typos, consistency |
| ... and 6 more academic agents |

### PK-Specific Rules

| Rule | What It Enforces |
|------|-----------------|
| `nonmem-conventions` | THETA rules, estimation methods, IIV coding, error models |
| `model-development-protocol` | Development phases, logging, per-run checklist |
| `report-standards` | No hardcoding, GOF standards, table standards |
| `quality-gates` | NONMEM scoring rubric (THETA=0 auto-fail, RSE thresholds) |
| `knowledge-base-template` | PK conventions registry |
| `context7-docs` | Auto-fetch live R package docs before writing PMX R code |
| `pmx-r-patterns` | Mandatory R patterns: set.seed, here::here, dpi=300, no ggplotly |

### MCP Plugin Integrations

| Plugin | What It Provides |
|--------|-----------------|
| Context7 | Live documentation for 30+ R packages (auto-triggered by rules) |
| Mermaid Chart | Rendered PK model diagrams, workflow charts, data flow diagrams |
| ClinicalTrials.gov | Trial search, protocol design research, competitive intelligence |
| bioRxiv/medRxiv | Preprint search for latest pharmacometrics research |
| ChEMBL | Compound search, bioactivity data, target information |

</details>

---

## Prerequisites

| Tool | Required For | Install |
|------|-------------|---------|
| [Claude Code](https://code.claude.com/docs/en/overview) | Everything | `npm install -g @anthropic-ai/claude-code` |
| NONMEM | Model estimation | License from ICON |
| R + packages | Diagnostics & reporting | [r-project.org](https://www.r-project.org/) |
| xpose | NONMEM output parsing | `install.packages("xpose")` |
| vpc | Visual predictive checks | `install.packages("vpc")` |
| PKNCA | NCA analysis | `install.packages("PKNCA")` |
| mrgsolve / rxode2 | PK simulations | `install.packages("mrgsolve")` |
| gt / flextable | Formatted tables | `install.packages(c("gt", "flextable"))` |
| aipharma | PK workflow automation | Internal package |
| XeLaTeX | LaTeX compilation (optional) | [TeX Live](https://tug.org/texlive/) |
| [Quarto](https://quarto.org) | Web slides/dashboards | [quarto.org](https://quarto.org/docs/get-started/) |

---

## Adapting for Your Project

1. **Update `CLAUDE.md`** — fill in compound, indication, sponsor, project details
2. **Update `config.yaml`** — set NONMEM paths, directory structure, thresholds
3. **Fill knowledge base** (`.claude/rules/knowledge-base-template.md`) — project-specific PK conventions
4. **Configure NONMEM path** — ensure `nmfe75` is on your PATH
5. **Initialize model log** — `/model-log init`
6. **Run data QC** — `/data-qc` on your dataset

For the R/Quarto analysis skills (NCA, E-R, simulations, TFLs, EDA), see the [Plugin Integration Guide](docs/plugin-integration-guide.md).

---

## Origin

This template was built by **Momentum Metrix** for internal PopPK/PD model development with Claude Code. It extends the [academic Claude Code workflow](https://github.com/pedrohcgs/claude-code-my-workflow) developed by Pedro Sant'Anna at Emory University.

---

## License

MIT License. Use freely for pharmacometric analysis and research.
