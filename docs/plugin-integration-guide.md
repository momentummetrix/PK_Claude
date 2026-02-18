# Plugin Integration Guide: R/Quarto Analysis Skills

**Last Updated:** 2026-02-17

This guide covers the 6 new analysis skills, 5 Quarto report templates, 2 rules, and MCP plugin integrations added to PK_Claude. These extend the template beyond NONMEM model development to cover the full pharmacometrics R/Quarto workflow.

---

## Overview

| Component | Count | Purpose |
|-----------|-------|---------|
| Analysis skills | 6 | Scaffold NCA, E-R, simulation, TFL, EDA, and diagram workflows |
| Report templates | 5 | Pre-built Quarto `.qmd` files with MM styling and placeholder code |
| Rules | 2 | Auto-fetch R package docs (Context7) and enforce PMX R patterns |
| Agent upgrades | 3 | NCA/E-R/simulation review capabilities on existing agents |
| MCP plugins | 5 | Live docs, diagrams, clinical trials, preprints, compound data |

---

## Analysis Skills

### `/nca-analysis` — Non-Compartmental Analysis

Scaffolds a complete NCA workflow using PKNCA and pkr.

**Usage:**
```
/nca-analysis
/nca-analysis data/derived/pk_data.csv
```

**What you get:**
- Quarto report copied from `templates/nca-report.qmd` to `reports/`
- Concentration-time profiles (linear + semi-log)
- NCA parameter computation (AUC, Cmax, Tmax, t1/2, CL/F, Vz/F)
- Summary statistics by dose group
- Dose proportionality assessment (power model)
- BLQ handling documentation

**What you provide:**
- Dataset path and column mappings (Subject ID, Time, Concentration, Dose)
- BLQ handling preference (set to 0, LLOQ/2, or exclude)
- Dosing information (single dose, steady-state, interval)

**Key packages:** PKNCA, pkr, tidyverse, gt, ggplot2

---

### `/er-analysis` — Exposure-Response Analysis

Scaffolds exposure-response modeling with appropriate model selection.

**Usage:**
```
/er-analysis
/er-analysis data/derived/er_dataset.csv
```

**What you get:**
- Exploratory E-R scatter plots and quartile boxplots
- Model fitting: logistic (binary), linear (continuous), Cox PH (time-to-event)
- Forest plot of subgroup effects
- Dose-response curves with 95% confidence intervals
- Exposure metric derivation documentation

**What you provide:**
- Dataset with exposure metrics (AUC, Cmax, Ctrough) and clinical endpoints
- Endpoint type (binary, continuous, time-to-event)
- Key covariates for subgroup analysis

**Key packages:** ggplot2, survival, gt, tidyverse

---

### `/simulate` — PK/PD Simulation

Runs population PK/PD simulations using rxode2 or mrgsolve.

**Usage:**
```
/simulate              # defaults to rxode2
/simulate rxode2
/simulate mrgsolve
/simulate 301          # load parameters from NONMEM run 301
```

**What you get:**
- Model specification (from NONMEM output or manual input)
- Dose scenario definitions
- Population simulation with IIV
- Spaghetti + median/PI plots
- Parameter uncertainty propagation (if bootstrap available)
- Steady-state and target attainment assessment

**What you provide:**
- Model parameters (or a NONMEM run number to extract from)
- Dose levels and regimens
- Number of subjects (default: 1000)
- Simulation duration

**Key packages:** rxode2 or mrgsolve, tidyverse, ggplot2

---

### `/tfl-generator` — Tables, Figures, and Listings

Generates submission-ready TFLs with consistent MM styling.

**Usage:**
```
/tfl-generator
/tfl-generator demographics
/tfl-generator pk-summary
/tfl-generator parameter-table
/tfl-generator forest-plot
/tfl-generator conc-time
/tfl-generator listing
```

**What you get:**
- Demographics table (N, Age, Sex, Race, Weight by treatment group)
- PK summary table (Cmax, AUC, t1/2 with geometric means)
- Parameter estimate table (from NONMEM output)
- Concentration-time figures (linear + semi-log)
- Forest plot of covariate effects
- Data listings

**Standards enforced:**
- 300 DPI, 6.5" wide for submission figures
- gt/flextable tables (not knitr::kable)
- No hardcoded values — all derived from R objects
- MM color palette throughout

**Key packages:** gt, flextable, ggplot2, tidyverse

---

### `/eda` — Exploratory Data Analysis

Comprehensive EDA for clinical/PK datasets before modeling.

**Usage:**
```
/eda
/eda data/derived/pk_data.csv
```

**What you get:**
- Demographics summary (continuous + categorical)
- PK concentration summary by dose, visit, timepoint
- BLQ summary
- Covariate distributions, correlations, and cross-plots
- Missing data assessment with pattern visualization
- Outlier detection (statistical + visual flagging)
- Data quality checks (duplicates, time sequences, dose-concentration consistency)

**What you provide:**
- Dataset path and column names
- Dataset type (PK, PD, PKPD, demographics)
- Known data issues or exclusion criteria

**Key packages:** tidyverse, gt, ggplot2, GGally

---

### `/pk-diagram` — Mermaid Diagram Generator

Generates and renders PK-relevant diagrams using the Mermaid Chart MCP plugin.

**Usage:**
```
/pk-diagram compartment 1cmt-oral
/pk-diagram compartment 2cmt-oral
/pk-diagram compartment tmdd
/pk-diagram compartment transit
/pk-diagram workflow model-development
/pk-diagram workflow nca-pipeline
/pk-diagram dataflow "SDTM to ADaM to NONMEM"
/pk-diagram decision "error model selection"
/pk-diagram custom "Show the covariate testing workflow"
```

**Built-in compartment model templates:**
- 1-CMT IV bolus
- 1-CMT oral (first-order absorption)
- 2-CMT oral (first-order absorption)
- 2-CMT IV infusion
- TMDD (quasi-steady-state)
- Transit compartment absorption

**Output:**
- Rendered diagram image via Mermaid Chart plugin
- Raw Mermaid code block for embedding in Quarto `.qmd` reports

---

## Quarto Report Templates

All templates live in `templates/` and follow the same conventions:

| Template | Skill That Uses It |
|----------|--------------------|
| `nca-report.qmd` | `/nca-analysis` |
| `er-report.qmd` | `/er-analysis` |
| `simulation-report.qmd` | `/simulate` |
| `tfl-report.qmd` | `/tfl-generator` |
| `eda-report.qmd` | `/eda` |

### Template Conventions

- **YAML header:** title with `[COMPOUND_NAME]`, author, date: today, format: html
- **All R chunks:** `eval: false` so templates don't fail on render
- **Placeholders:** `[DATASET_PATH]`, `[SUBJECT_ID]`, `[TIME_COL]`, etc.
- **MM color palette:** `mm_primary="#1B365D"`, `mm_secondary="#4A90D9"`, `mm_accent="#E8891C"`
- **Standards:** `dpi = 300`, `width = 6.5`, `here::here()` for paths

### How Skills Use Templates

1. Skill copies template from `templates/` to `reports/` with a descriptive name
2. Fills in YAML header and data path placeholders
3. Customizes R code chunks for the user's specific dataset
4. Sets `eval: true` on chunks that are ready to run
5. Renders the Quarto report

---

## Rules (Auto-Triggered)

### Context7 Live Documentation (`context7-docs.md`)

**Triggers on:** `**/*.R`, `**/*.qmd`, `scripts/**`

Before writing R code that uses PMX packages, Claude automatically fetches current documentation from Context7. No manual action needed.

**Package tiers:**

| Tier | Packages | When Checked |
|------|----------|-------------|
| 1 — Core PMX | xpose, mrgsolve, rxode2, PKNCA, vpc, nlmixr2, pkr | Always before first use in session |
| 2 — Simulation/ODE | PKPDsim, posologyr, linpk, nlmixr2est, babelmixr2 | When writing simulation code |
| 3 — Tidyverse | dplyr, tidyr, purrr, stringr, readr, forcats, lubridate | Non-trivial usage only |
| 4 — Visualization | ggplot2, Plotly, patchwork, cowplot, GGally, gt, flextable, officer | When building figures/tables |
| 5 — Pipeline | targets | When setting up workflow |

### PMX R Code Patterns (`pmx-r-patterns.md`)

**Triggers on:** `**/*.R`, `**/*.qmd`

Enforces mandatory patterns for all PMX R code:

- `set.seed()` required in any simulation script
- `here::here()` for all file paths
- GOF plots always `type = "ps"`
- No hardcoded values in tables
- Explicit `fig.width`, `fig.height` in Quarto chunk options
- `dpi = 300` for all `ggsave()` calls
- No `ggplotly()` — use native Plotly if interactivity needed

---

## Agent Upgrades

### r-reviewer — New PMX Review Categories

Added sections 5b-5e expanding R code review for pharmacometrics:

| Section | What It Checks |
|---------|---------------|
| 5b. NCA Analysis Patterns | PKNCA workflow, BLQ handling, lambda_z selection |
| 5c. Simulation Patterns | set.seed, named parameters, PI computation, uncertainty propagation |
| 5d. Exposure-Response Patterns | Graphical assessment, model type, CIs, clinical relevance |
| 5e. TFL Standards | gt/flextable, dimensions, numbering, sig figs, MM palette |

### domain-reviewer — New Substantive Lenses

Added Lenses 6-8 for analysis types beyond PopPK:

| Lens | What It Reviews |
|------|----------------|
| 6. NCA Methodology | AUC method, BLQ handling, lambda_z criteria, dose proportionality |
| 7. Exposure-Response Analysis | Exposure metric rationale, confounders, model type, clinical relevance |
| 8. Simulation Validity | Parameter uncertainty, dose scenarios, PI computation, negative concentrations |

### verifier — New Verification Procedures

Added verification for R analysis scripts and Quarto reports:

- **R scripts:** NCA output plausibility, simulation output checks (no negative concentrations, steady-state)
- **Quarto reports:** render success, figure generation, table formatting, cross-reference resolution

---

## MCP Plugins Available

These plugins are available in every PK_Claude session:

| Plugin | Use Case | Example |
|--------|----------|---------|
| **Context7** | Live R package documentation | Auto-triggered by `context7-docs` rule |
| **Mermaid Chart** | PK model diagrams | `/pk-diagram compartment 2cmt-oral` |
| **ClinicalTrials.gov** | Trial search, protocol design | "Search for Phase 3 oncology trials with PK endpoints" |
| **bioRxiv/medRxiv** | Latest preprints | "Find recent preprints on population PBPK models" |
| **ChEMBL** | Compound and target data | "Find bioactivity data for imatinib" |

---

## Typical Workflows

### New Compound Analysis (start to finish)

```
# 1. Explore the data
/eda data/derived/pk_data.csv

# 2. Run NCA for initial PK characterization
/nca-analysis data/derived/pk_data.csv

# 3. Develop PopPK model (existing NONMEM workflow)
/model-template 2cmt-oral
/model-eval 101
/covariate-test 201

# 4. Simulate dose scenarios
/simulate 301

# 5. Exposure-response analysis
/er-analysis data/derived/er_dataset.csv

# 6. Generate submission TFLs
/tfl-generator

# 7. Generate diagrams for the report
/pk-diagram compartment 2cmt-oral
/pk-diagram workflow model-development
```

### Quick NCA Report

```
/nca-analysis data/derived/pk_sad.csv
# Claude asks for column mappings, BLQ handling, dosing info
# Generates reports/nca-analysis-compound-sad.qmd
# Renders to HTML with all figures and tables
```

### Generate Diagrams for Presentations

```
/pk-diagram compartment 2cmt-oral          # Model schematic
/pk-diagram workflow model-development     # Development workflow
/pk-diagram dataflow "SDTM to ADaM to NONMEM"  # Data pipeline
```
