---
paths:
  - "models/**"
  - "reports/**"
  - "model_development_log.yaml"
---

# Model Development Protocol

## Development Phases

### Phase 1: Data QC
- [ ] Dataset specification reviewed
- [ ] QC checks passed (no negative concentrations, valid dosing records)
- [ ] Exploratory plots generated (concentration-time, covariate distributions)
- [ ] NONMEM-ready dataset created in `data/derived/`

### Phase 2: Base Structural Model (runs 100-199)
- [ ] Test 1-CMT vs 2-CMT (vs 3-CMT if warranted)
- [ ] Test absorption models (FO, zero-order, transit)
- [ ] Select IIV structure (diagonal vs block)
- [ ] Select residual error model (combined, proportional, additive)
- [ ] Document selection rationale in model development log

### Phase 3: Covariate Model (runs 200-299)
- [ ] Graphical covariate assessment (ETA vs covariate plots)
- [ ] Forward addition (dOFV >= 3.84, p < 0.05)
- [ ] Backward elimination (dOFV >= 6.63, p < 0.01)
- [ ] Document each step in model development log

### Phase 4: Final Model (runs 300-399)
- [ ] Final model evaluation (GOF, VPC, bootstrap)
- [ ] Sensitivity analysis if needed
- [ ] Parameter table with RSE, IIV, shrinkage

### Phase 5: Reporting
- [ ] Model development report
- [ ] Parameter tables (auto-generated from .lst)
- [ ] Diagnostic figures (auto-generated)

## Per-Run Checklist

Before accepting ANY run:
- [ ] Convergence successful (MINIMIZATION SUCCESSFUL)
- [ ] Covariance step successful
- [ ] No boundary warnings
- [ ] RSE acceptable (fixed < 30%, random < 50%)
- [ ] Condition number < 1000
- [ ] GOF plots reviewed
- [ ] Run logged in model_development_log.yaml
- [ ] Decision documented with rationale

## Logging Requirements

Every run MUST be logged with:
1. Run number
2. Parent run (or "new" for first model)
3. Description of changes
4. OFV and dOFV from parent
5. Convergence and covariance status
6. Decision (accepted/rejected) with rationale
