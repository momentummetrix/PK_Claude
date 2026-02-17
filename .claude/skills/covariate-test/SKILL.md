---
name: covariate-test
description: Covariate testing - Forward addition and backward elimination workflow
---

# Covariate Testing Workflow

## Usage
```
/covariate-test <base_run_number>
```

## Protocol

### Phase 1: Setup
1. Read base model results (must have converged with successful covariance)
2. Identify available covariates from dataset
3. Identify PK parameters to test covariates on
4. Generate ETA vs covariate plots for visual screening

### Phase 2: Forward Addition
For each covariate-parameter combination:
1. Create new run with covariate added
2. Run NONMEM
3. Record OFV
4. Calculate dOFV from base
5. If dOFV >= 3.84 (p < 0.05, 1 df): covariate is significant

Select the covariate with the largest significant dOFV drop. Add it to the model. Repeat until no more significant covariates.

### Phase 3: Backward Elimination
Starting from the full model (after forward addition):
1. Remove one covariate at a time
2. Run NONMEM
3. Record OFV increase
4. If dOFV < 6.63 (p < 0.01, 1 df): covariate is not needed, remove it

Continue until all remaining covariates produce dOFV >= 6.63 when removed.

### Phase 4: Report
Generate covariate testing summary:
- Forward addition table (step, covariate, parameter, dOFV, decision)
- Backward elimination table (step, covariate, parameter, dOFV, decision)
- Final covariate model specification
- Log all steps in model development log

## Thresholds
- Forward addition: dOFV >= 3.84 (p < 0.05, 1 df)
- Backward elimination: dOFV >= 6.63 (p < 0.01, 1 df)
