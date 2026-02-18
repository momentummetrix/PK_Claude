---
name: nca-analysis
description: Non-compartmental analysis workflow using PKNCA and pkr. Scaffolds a complete Quarto report with concentration-time profiles, NCA parameters, and summary statistics.
---

# NCA Analysis

## Usage
```
/nca-analysis
/nca-analysis <dataset_path>
```

## What This Does

Scaffolds a complete NCA analysis as a Quarto report:
1. Load and prepare PK concentration data
2. Generate concentration-time profiles (linear + semi-log)
3. Compute NCA parameters via PKNCA (AUC, Cmax, Tmax, t1/2, CL/F, Vz/F)
4. Summarize by dose group with descriptive statistics
5. Assess dose proportionality
6. Document BLQ handling approach

## Protocol

### Step 1: Fetch Documentation
Use Context7 to get current PKNCA and pkr documentation:
- `resolve-library-id` for PKNCA
- `query-docs` for PKNCAconc, PKNCAdata, pk.nca workflow

### Step 2: Identify Dataset
If `$ARGUMENTS` provides a path, use it. Otherwise ask the user for:
- Dataset location (in `data/derived/`)
- Key columns: Subject ID, Time, Concentration, Dose, Treatment/Group
- BLQ handling preference (set to 0, set to LLOQ/2, exclude)
- Dosing information (single dose, steady-state, multiple dose)

### Step 3: Scaffold Report
Copy `templates/nca-report.qmd` to `reports/` with a descriptive name.
Fill in the YAML header and data path placeholders.

### Step 4: Customize R Code
Adapt the template code chunks for the user's dataset:
- Column name mapping
- BLQ handling method
- NCA intervals appropriate for dosing regimen
- Dose groups for stratification

### Step 5: Generate and Review
- Render the Quarto report
- Review NCA parameter ranges for physiological plausibility
- Flag any issues (negative AUC, unreasonable t1/2, etc.)

## Non-Negotiables
- Use `here::here()` for all file paths
- Use PKNCA (not manual trapezoidal calculation)
- Linear-up/log-down trapezoidal method as default
- All figures at dpi = 300
- No hardcoded parameter values in summary tables
