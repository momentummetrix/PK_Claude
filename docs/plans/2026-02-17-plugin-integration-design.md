# Design: Plugin-First R/Quarto/Mermaid Enhancement for PK_Claude

**Status:** APPROVED
**Date:** 2026-02-17
**Approach:** A (Plugin-First)

---

## Problem

The PK_Claude template has strong NONMEM model development support (via aipharma), but the broader pharmacometrics R/Quarto workflow is underserved. Team members doing NCA, exposure-response, simulations, EDA, and TFL generation lack scaffolding, don't get PMX-aware code review, and Claude may hallucinate outdated R package APIs. Additionally, diagram generation for PK model schematics, data flows, and analysis workflows requires manual effort.

## Solution

Integrate three MCP plugins (Context7, Mermaid Chart) into the PK workflow, create 6 new analysis skills, enhance 3 existing agents, and add 1 new rule. This gives the template: fresh docs on demand, auto-generated diagrams, scaffolded analysis templates, and PMX-aware code review.

---

## Section 1: Context7 Integration

### What
A path-scoped rule that instructs Claude to use Context7 to fetch live documentation for PMX R packages before writing R code.

### File
`.claude/rules/context7-docs.md`

### Behavior
- Triggers on paths: `**/*.R`, `**/*.qmd`, `scripts/**`
- Before writing R code that uses a PMX package, Claude calls `resolve-library-id` then `query-docs`
- Applies to the following package tiers:

**Tier 1 — Core PMX (always check):**
xpose, mrgsolve, rxode2, PKNCA, vpc, nlmixr2, pkr

**Tier 2 — Simulation/ODE (check when relevant):**
PKPDsim, posologyr, linpk, nlmixr2est, babelmixr2

**Tier 3 — Tidyverse (check for non-trivial usage):**
dplyr, tidyr, purrr, stringr, readr, forcats, lubridate

**Tier 4 — Visualization (check when building figures/tables):**
ggplot2, Plotly, patchwork, cowplot, GGally, gganimate, gt, flextable, officer

**Tier 5 — Pipeline:**
targets

### Cost
One API call per relevant R coding task. No user action needed.

---

## Section 2: Mermaid Diagram Skill

### What
A new skill `/pk-diagram` that generates and renders PK-relevant diagrams using the Mermaid Chart MCP plugin.

### File
`.claude/skills/pk-diagram/SKILL.md`

### Diagram Types

| Type | What It Generates | Example Input |
|------|-------------------|---------------|
| `compartment <model>` | PK compartment model schematic | `1cmt-oral`, `2cmt-iv`, `tmdd`, `transit` |
| `workflow <analysis>` | Analysis workflow flowchart | `model-development`, `covariate-selection`, `nca-pipeline` |
| `dataflow <description>` | Data derivation pipeline | `"SDTM to ADaM to NONMEM"` |
| `decision <question>` | Decision tree | `"dose adjustment"`, `"error model selection"` |
| `custom <prompt>` | Free-form from description | Any text description |

### Built-in Templates
Pre-built Mermaid code for common PK model structures:
- 1-CMT IV bolus
- 1-CMT oral (first-order absorption)
- 2-CMT oral (first-order absorption)
- 2-CMT IV infusion
- TMDD (quasi-steady-state)
- Transit compartment absorption

### Output
- Rendered diagram image via Mermaid Chart plugin
- Raw Mermaid code block for embedding in Quarto `.qmd` reports

---

## Section 3: New Analysis Skills

### 3.1 `/nca-analysis`

**File:** `.claude/skills/nca-analysis/SKILL.md`

**Purpose:** Scaffold a complete NCA workflow using PKNCA + pkr.

**Output:** Quarto `.qmd` report in `reports/` with:
- Concentration-time profile plots (linear + semi-log)
- NCA parameter table (AUC, Cmax, Tmax, t1/2, CL/F, Vz/F)
- Summary statistics by dose group
- BLQ handling documentation
- Lambda_z regression diagnostics

### 3.2 `/er-analysis`

**File:** `.claude/skills/er-analysis/SKILL.md`

**Purpose:** Scaffold exposure-response analysis.

**Output:** Quarto `.qmd` report with:
- E-R scatter plots (efficacy + safety endpoints)
- Logistic regression / Cox PH models as appropriate
- Forest plot of subgroup effects
- Dose-response curves with confidence intervals
- Exposure metric derivation documentation

### 3.3 `/simulate <engine>`

**File:** `.claude/skills/simulate-pk/SKILL.md`

**Purpose:** PK/PD simulations using rxode2 or mrgsolve.

**Arguments:** `engine` = `rxode2` (default) or `mrgsolve`

**Output:** R script + Quarto summary with:
- Model specification (from NONMEM estimates or manual)
- Dose scenario definitions
- Population simulation with prediction intervals
- Spaghetti + median/PI plots
- Parameter uncertainty propagation (if bootstrap available)

### 3.4 `/tfl-generator`

**File:** `.claude/skills/tfl-generator/SKILL.md`

**Purpose:** Generate submission-ready Tables, Figures, and Listings.

**Output:**
- gt/flextable tables with MM styling
- ggplot2 figures at 300 DPI
- Consistent formatting across all outputs
- Quarto document assembling all TFLs

### 3.5 `/eda`

**File:** `.claude/skills/eda/SKILL.md`

**Purpose:** Exploratory data analysis for clinical/PK datasets.

**Output:** Quarto `.qmd` report with:
- Demographics summary table
- PK concentration summary (by dose, visit, analyte)
- Covariate distributions and correlations
- Missing data assessment
- Outlier detection
- Dataset quality flags

### 3.6 `/pk-diagram` (from Section 2)

Already defined above.

### Template Approach
Each skill has a corresponding Quarto template in `templates/`:
- `templates/nca-report.qmd`
- `templates/er-report.qmd`
- `templates/simulation-report.qmd`
- `templates/tfl-report.qmd`
- `templates/eda-report.qmd`

Skills fill in these templates rather than generating from scratch, ensuring consistency.

---

## Section 4: Smarter Agents & Rules

### 4.1 Agent: r-reviewer.md (modify)

Add PMX R review categories:

**PKNCA/pkr patterns:**
- Correct `PKNCAconc` → `PKNCAdata` → `pk.nca` workflow
- Proper interval definitions for AUC calculation
- BLQ exclusion handling
- Linear-up/log-down trapezoidal method

**mrgsolve/rxode2 patterns:**
- `$PARAM`, `$ODE`, `$CMT` consistency
- Proper event table construction
- Simulation seed setting with `set.seed()`
- Parameter uncertainty propagation

**E-R patterns:**
- Correct exposure metric derivation (AUC, Cmax, Ctrough)
- Proper endpoint handling (binary/continuous/TTE)
- Confounder adjustment

**TFL standards:**
- gt/flextable tables match regulatory expectations
- Figure dimensions set for submission (typically 6.5" wide)
- DPI = 300 for all figures

### 4.2 Agent: domain-reviewer.md (modify)

Add analysis-type lenses alongside existing PK model lenses:

**NCA Methodology:**
- Correct AUC calculation method selection
- Proper BLQ handling (<LLOQ rules)
- Lambda_z selection criteria and r-squared cutoff
- t1/2 reliability assessment

**E-R Analysis:**
- Exposure metric selection rationale
- Confounder adjustment approach
- Graphical assessment before formal modeling
- Clinical relevance of findings

**Simulation Validity:**
- Parameter uncertainty propagation
- Dose scenario relevance to clinical questions
- Prediction interval methodology
- Comparison to observed data (if available)

### 4.3 Agent: verifier.md (modify)

Add R analysis verification procedures:

**NCA output checks:**
- Parameter ranges physiologically plausible
- t1/2 vs dosing interval consistency
- Dose proportionality assessment sensibility

**Simulation checks:**
- No negative concentrations in predictions
- Steady-state achievement within simulation duration
- Prediction intervals capture observed data

**Quarto render:**
- Verify `.qmd` files render to HTML without errors
- Check all figures generated at correct DPI
- Verify table formatting renders properly

### 4.4 Rule: pmx-r-patterns.md (create)

**File:** `.claude/rules/pmx-r-patterns.md`
**Paths:** `**/*.R`, `**/*.qmd`

**Enforces:**
- `set.seed()` required in any simulation script
- `here::here()` for all file paths, never absolute paths
- GOF plots always `type = "ps"`
- No hardcoded values in tables — always pull from R objects
- Explicit `fig.width`, `fig.height` in all chunk options
- `dpi = 300` for all `ggsave()` calls
- No `ggplotly()` — use native Plotly if interactivity needed

---

## File Count Summary

| Action | Files | Details |
|--------|-------|---------|
| Create rules | 2 | `context7-docs.md`, `pmx-r-patterns.md` |
| Create skills | 6 | `pk-diagram`, `nca-analysis`, `er-analysis`, `simulate-pk`, `tfl-generator`, `eda` |
| Create templates | 5 | `nca-report.qmd`, `er-report.qmd`, `simulation-report.qmd`, `tfl-report.qmd`, `eda-report.qmd` |
| Modify agents | 3 | `r-reviewer.md`, `domain-reviewer.md`, `verifier.md` |
| **Total** | **16** | |

---

## Verification

After implementation:
1. Each new skill has valid SKILL.md with frontmatter
2. Each Quarto template renders without errors
3. New rules have correct `paths:` frontmatter
4. Modified agents maintain existing functionality + new PMX categories
5. Context7 rule triggers correctly on R/qmd file paths
6. Mermaid skill generates valid diagrams for all 5 types
7. Commit and push to PK_Claude repo
