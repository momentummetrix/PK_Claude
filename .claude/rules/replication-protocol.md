---
paths:
  - "scripts/**/*.R"
  - "Figures/**/*.R"
---

# Replication-First Protocol

**Core principle:** Replicate original results to the dot BEFORE extending.

---

## Phase 1: Inventory & Baseline

Before writing any NONMEM code:

- [ ] Read the published model description (paper methods section)
- [ ] Inventory model details: structural model, IIV, residual error, covariates
- [ ] Record gold standard parameter estimates from the paper:

```markdown
## Replication Targets: [Paper Author (Year)]

| Parameter | Published Value | SE/CI | Units | Notes |
|-----------|----------------|-------|-------|-------|
| CL | | | L/h | |
| V | | | L | |
```

- [ ] Store targets in `quality_reports/replication_targets.md` or as RDS

---

## Phase 2: Translate & Execute

- [ ] Follow `r-code-conventions.md` for all R coding standards
- [ ] Translate line-by-line initially -- don't "improve" during replication
- [ ] Match original specification exactly (covariates, sample, clustering, SE computation)
- [ ] Save all intermediate results as RDS

### NONMEM Model Reproduction Pitfalls

<!-- Common issues when reproducing published PK models -->

| Published Model | Your Implementation | Trap |
|----------------|--------------------|----- |
| ADVAN2 TRANS2 | ADVAN2 TRANS1 | Different parameterization (CL/V vs K) |
| FOCE INTER | FOCE (no INTER) | Omitting interaction term changes estimates |
| Combined error | Proportional only | Different error model affects all parameters |
| WT on CL (allometric) | WT on CL (linear) | Wrong covariate functional form |
| THETA(1) = 10.5 | THETA(1) = 10.5 | Different units (mg vs mcg, L vs mL) |
| Bootstrap CI | Asymptotic CI | Different uncertainty method |

---

## Phase 3: Verify Match

### Tolerance Thresholds

| Type | Tolerance | Rationale |
|------|-----------|-----------|
| Integers (N, counts) | Exact match | No reason for any difference |
| Point estimates | < 0.01 | Rounding in paper display |
| Standard errors | < 0.05 | Bootstrap/clustering variation |
| P-values | Same significance level | Exact p may differ slightly |
| Percentages | < 0.1pp | Display rounding |

### If Mismatch

**Do NOT proceed to extensions.** Isolate which step introduces the difference, check common causes (sample size, SE computation, default options, variable definitions), and document the investigation even if unresolved.

### Replication Report

Save to `quality_reports/LectureNN_replication_report.md`:

```markdown
# Replication Report: [Paper Author (Year)]
**Date:** [YYYY-MM-DD]
**Original language:** [Stata/R/etc.]
**R translation:** [script path]

## Summary
- **Targets checked / Passed / Failed:** N / M / K
- **Overall:** [REPLICATED / PARTIAL / FAILED]

## Results Comparison

| Target | Paper | Ours | Diff | Status |
|--------|-------|------|------|--------|

## Discrepancies (if any)
- **Target:** X | **Investigation:** ... | **Resolution:** ...

## Environment
- R version, key packages (with versions), data source
```

---

## Phase 4: Only Then Extend

After replication is verified (all targets PASS):

- [ ] Commit replication script: "Replicate [Paper] Table X -- all targets match"
- [ ] Now extend with course-specific modifications (different estimators, new figures, etc.)
- [ ] Each extension builds on the verified baseline
