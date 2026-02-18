---
name: tfl-generator
description: Generate submission-ready Tables, Figures, and Listings (TFLs) for pharmacometric analyses using gt, flextable, and ggplot2.
---

# TFL Generator

## Usage
```
/tfl-generator
/tfl-generator <dataset_path>
/tfl-generator <type>
```

Types: `demographics`, `pk-summary`, `parameter-table`, `forest-plot`, `conc-time`, `listing`

## What This Does

Generates publication/submission-ready Tables, Figures, and Listings:
1. Formatted tables via gt or flextable with MM styling
2. ggplot2 figures at 300 DPI with consistent theme
3. Data listings with appropriate formatting
4. Assembled Quarto document with all TFLs

## Protocol

### Step 1: Fetch Documentation
Use Context7 for gt, flextable, and ggplot2.

### Step 2: Determine TFL Requirements
Ask user for:
- TFL type(s) needed
- Dataset location
- Output format (HTML for review, PDF/DOCX for submission)
- Specific formatting requirements (sponsor shell, standard headers/footers)

### Step 3: Scaffold Report
Copy `templates/tfl-report.qmd` to `reports/`.

### Step 4: Generate TFLs

**Demographics Table:**
- N, Age (mean, SD, range), Sex, Race, Weight, BMI, eGFR
- By treatment group with total column
- Using gt with MM styling

**PK Summary Table:**
- Cmax, Tmax, AUC, t1/2 by dose group and visit
- Geometric mean + CV% for log-normal parameters
- Arithmetic mean + SD for others

**Parameter Estimate Table:**
- From NONMEM output: Estimate, RSE%, IIV CV%, Shrinkage%
- Formatted with appropriate significant figures

**Concentration-Time Figure:**
- Linear and semi-log scales
- By dose group, with mean + SD overlay
- Individual profiles as light lines

**Forest Plot:**
- Covariate effects on key parameters
- Reference line at 1.0 (or appropriate null)
- 90% CI bars

**Data Listing:**
- Subject-level data in tabular format
- Sorted by subject, time
- Flagged BLQ and excluded records

## Non-Negotiables
- No hardcoded values — all from R objects
- gt/flextable for tables (not knitr::kable for final output)
- dpi = 300 for all figures, width = 6.5 inches for submission
- Include table/figure numbers and titles
- MM color palette for all visualizations
