---
paths:
  - "reports/**"
  - "Quarto/**/*.qmd"
---

# Report Standards

## No Hardcoding Rule (Non-Negotiable)

**NEVER manually type parameter values from NONMEM output into reports.**

Always use:
```r
# Pull from NONMEM output programmatically
xpdb <- xpose::xpose_data(runno = "301", dir = "models/run301")
params <- aipharma::get_parameter_estimates_xpose(xpdb)
```

This ensures reports auto-update when models are rerun.

## GOF Plot Standards

All goodness-of-fit plots MUST:
1. Use `type = "ps"` (points + smooth line, NO connecting lines)
2. Include identity line where appropriate
3. Use consistent color palette
4. Have clear axis labels with units
5. Be generated at 300 DPI for publication

Standard GOF panel (4 plots):
```r
# DV vs PRED
dv_vs_pred(xpdb, type = "ps")
# DV vs IPRED
dv_vs_ipred(xpdb, type = "ps")
# CWRES vs TIME
res_vs_idv(xpdb, res = "CWRES", type = "ps")
# CWRES vs PRED
res_vs_pred(xpdb, res = "CWRES", type = "ps")
```

## Table Standards

Parameter tables MUST include:
- Parameter name and description
- Estimate with units
- RSE (%)
- IIV as CV% (for exponential model: CV% = 100 * sqrt(exp(omega) - 1))
- Shrinkage (%)

## Report Sections (Standard Order)

1. Executive Summary
2. Data Description
3. Model Development (with decision table)
4. Final Model Parameters
5. Model Diagnostics (GOF, VPC, Bootstrap)
6. Conclusions
7. Appendices (full parameter tables, additional plots)
