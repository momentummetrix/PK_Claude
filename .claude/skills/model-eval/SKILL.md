---
name: model-eval
description: Comprehensive NONMEM model evaluation and diagnostics
---

# Model Evaluation

## Usage
```
/model-eval <run_number>
/model-eval 101
```

## What This Does

1. **Check run status** -- convergence, covariance, boundary warnings
2. **Extract parameters** -- estimates, RSE, IIV (CV%), shrinkage
3. **Generate GOF plots** -- DV vs PRED, DV vs IPRED, CWRES vs TIME, CWRES vs PRED
4. **Report OFV** and condition number
5. **Flag issues** -- THETA=0, high RSE, high shrinkage, failed steps

## Protocol

### Step 1: Locate Run
```r
run_dir <- file.path("models", paste0("run", run_number))
lst_file <- file.path(run_dir, paste0("run", run_number, ".lst"))
```

### Step 2: Check Status
```r
library(aipharma)
status <- check_run_status(run_number, run_dir = "models")
```

If convergence OR covariance failed, report immediately and flag.

### Step 3: Load xpose Data
```r
library(xpose)
xpdb <- xpose_data(runno = run_number, dir = run_dir)
```

### Step 4: Parameter Summary
```r
params <- get_parameter_estimates_xpose(xpdb)
```

Present as table: Parameter | Estimate | RSE(%) | IIV CV(%) | Shrinkage(%)

### Step 5: GOF Plots
Generate using xpose with `type = "ps"` (points + smooth):
```r
# Standard 4-panel GOF
dv_vs_pred(xpdb, type = "ps")
dv_vs_ipred(xpdb, type = "ps")
res_vs_idv(xpdb, res = "CWRES", type = "ps")
res_vs_pred(xpdb, res = "CWRES", type = "ps")
```

### Step 6: Report
Present structured evaluation:
- Run number and description
- Convergence: PASS/FAIL
- Covariance: PASS/FAIL
- OFV value
- Parameter table
- Issues flagged
- GOF plot interpretations
- Recommendation: Accept / Revise / Reject

## Non-Negotiables
- NEVER hardcode parameter values
- ALWAYS check convergence before extracting parameters
- GOF plots MUST use type = "ps"
- Log every evaluation in model development log
