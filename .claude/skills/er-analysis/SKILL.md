---
name: er-analysis
description: Exposure-response analysis workflow. Scaffolds Quarto report with E-R scatter plots, logistic/Cox regression, forest plots, and dose-response curves.
---

# Exposure-Response Analysis

## Usage
```
/er-analysis
/er-analysis <dataset_path>
```

## What This Does

Scaffolds a complete exposure-response analysis as a Quarto report:
1. Load PK exposure metrics and clinical endpoints
2. Exploratory E-R scatter plots (efficacy + safety)
3. Fit appropriate models (logistic, linear, Cox PH)
4. Generate forest plots for subgroup effects
5. Dose-response curves with confidence intervals

## Protocol

### Step 1: Fetch Documentation
Use Context7 for ggplot2, gt, and relevant modeling packages.

### Step 2: Identify Data and Endpoints
Ask the user for:
- Dataset with exposure metrics (AUC, Cmax, Ctrough) and endpoints
- Efficacy endpoint(s): binary (response/no response), continuous (change from baseline), or time-to-event
- Safety endpoint(s): if applicable
- Key covariates for subgroup analysis
- Exposure metric preference (AUC_ss, Cmax, Ctrough, or all)

### Step 3: Scaffold Report
Copy `templates/er-report.qmd` to `reports/`.
Adapt for the user's endpoints and exposure metrics.

### Step 4: Customize Analysis
- Select appropriate model type based on endpoint:
  - Binary → logistic regression (`glm(..., family = binomial)`)
  - Continuous → linear regression or ANCOVA
  - Time-to-event → Cox PH (`survival::coxph`)
- Set up subgroup variables for forest plot
- Configure dose-response visualization

### Step 5: Generate and Review
- Render the Quarto report
- Check E-R relationship direction is clinically plausible
- Verify forest plot subgroups are meaningful

## Non-Negotiables
- Always show graphical E-R assessment before formal modeling
- Include exposure metric derivation documentation
- Forest plots must include overall effect + subgroups
- Confidence intervals on all model predictions
- No p-value hacking — pre-specify analysis plan
