---
name: dashboard
description: Generate interactive Quarto dashboard for NONMEM model diagnostics
---

# Model Dashboard

## Usage
```
/dashboard <run_number>
/dashboard 301
```

## What This Generates

An interactive Quarto HTML dashboard with:

### Tab 1: Run Summary
- Convergence status
- OFV
- Parameter table with RSE, IIV, shrinkage
- Condition number

### Tab 2: GOF Plots
- DV vs PRED (interactive)
- DV vs IPRED (interactive)
- CWRES vs TIME (interactive)
- CWRES vs PRED (interactive)

### Tab 3: Individual Fits
- Individual concentration-time profiles
- Population and individual predictions overlaid

### Tab 4: ETA Diagnostics
- ETA distributions (histograms)
- ETA vs covariates
- ETA correlation matrix

### Tab 5: VPC (if available)
- Visual predictive check plot

## Protocol

```r
library(aipharma)
generate_model_dashboard(run_number = run_number, run_dir = paste0("models/run", run_number))
```

## Output
Dashboard saved to `reports/dashboard_run<NUMBER>.html`
Open in browser for interactive exploration.
