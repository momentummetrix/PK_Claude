---
name: batch-compare
description: Batch model comparison - Compare multiple NONMEM runs
---

# Batch Model Comparison

## Usage
```
/batch-compare 101 102 103
/batch-compare 101-105
/batch-compare all
```

## Protocol

### Step 1: Identify Runs
Parse the argument to get list of run numbers.

### Step 2: Extract Data
For each run:
```r
library(aipharma)
summary <- compare_runs(run_numbers, run_dir = "models")
```

### Step 3: Generate Comparison Table

| Run | Description | OFV | dOFV | nPar | Convergence | Covariance | AIC |
|-----|-------------|-----|------|------|-------------|------------|-----|

### Step 4: Highlight
- Best OFV (lowest)
- Significant dOFV drops (>= 3.84 for 1 df)
- Any failed convergence/covariance
- Recommendation for next steps

## Output
Present formatted comparison table with recommendations.
