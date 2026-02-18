---
name: eda
description: Exploratory Data Analysis for clinical and PK datasets. Scaffolds a comprehensive Quarto report with demographics, PK summaries, covariate distributions, and data quality assessment.
---

# Exploratory Data Analysis

## Usage
```
/eda
/eda <dataset_path>
```

## What This Does

Scaffolds a comprehensive EDA report:
1. Demographics summary
2. PK concentration summary by dose, visit, analyte
3. Covariate distributions and correlations
4. Missing data assessment
5. Outlier detection
6. Dataset quality flags

## Protocol

### Step 1: Fetch Documentation
Use Context7 for ggplot2, gt, and data manipulation packages.

### Step 2: Identify Dataset
If `$ARGUMENTS` provides a path, use it. Otherwise ask for:
- Dataset location
- Dataset type (PK, PD, PKPD, demographics, lab data)
- Key column names (ID, TIME, DV, DOSE, covariates)
- Any known data issues or exclusions

### Step 3: Scaffold Report
Copy `templates/eda-report.qmd` to `reports/`.

### Step 4: Customize Sections

**Demographics:**
- Summary table: N, Age, Sex, Race, Weight, Height, BMI, renal/hepatic function
- Stratified by treatment group
- Balance assessment across groups

**PK Concentrations:**
- N observations by dose, visit, timepoint
- BLQ summary (count and percentage by timepoint)
- Concentration-time spaghetti plots (linear + semi-log)
- Dose-normalized concentrations if multiple dose levels

**Covariates:**
- Histograms/density plots for continuous covariates
- Bar charts for categorical covariates
- Correlation matrix (continuous covariates)
- Covariate vs PK parameter scatter plots (if individual estimates available)

**Missing Data:**
- Missing data pattern visualization
- Percentage missing by variable
- Assessment of missingness mechanism (MCAR/MAR/MNAR)

**Outliers:**
- Statistical outlier detection (e.g., > 3 SD from mean)
- Visual outlier flagging on concentration-time plots
- Listing of flagged observations for review

**Data Quality:**
- Duplicate record check
- Time sequence validation (no negative time gaps)
- Dose-concentration consistency
- BLQ below actual LLOQ value

### Step 5: Generate and Review
- Render the Quarto report
- Summarize key findings
- Flag data issues requiring resolution before modeling

## Non-Negotiables
- All figures at dpi = 300
- Use `here::here()` for file paths
- No hardcoded values in summary tables
- Use MM color palette
- Document all data exclusions with rationale
