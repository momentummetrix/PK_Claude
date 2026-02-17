---
paths:
  - "models/**/*.mod"
  - "models/**/*.ctl"
  - "models/**/*.lst"
  - "scripts/**/*.R"
  - "reports/**"
  - "Slides/**/*.tex"
  - "Quarto/**/*.qmd"
---

# PopPK Knowledge Base: [PROJECT_NAME]

## Run Numbering Convention

| Range | Phase | Example |
|-------|-------|---------|
| 100-199 | Base structural models | run101: 1-CMT FO, run102: 2-CMT FO |
| 200-299 | Covariate models | run201: WT on CL, run202: WT on CL + SEX on V |
| 300-399 | Final models | run301: Final model, run302: Final + sensitivity |

## Parameter Coding Standards

| Parameter | IIV Form | Typical Code | Anti-Pattern |
|-----------|----------|-------------|-------------|
| CL | Exponential | CL = TVCL * EXP(ETA(1)) | CL = TVCL + ETA(1) |
| V | Exponential | V = TVV * EXP(ETA(2)) | V = TVV * (1 + ETA(2)) |
| KA | Exponential | KA = TVKA * EXP(ETA(3)) | KA = TVKA + ETA(3) |
| ALAG | Additive | ALAG1 = TVALAG + ETA(4) | ALAG1 = TVALAG * EXP(ETA(4)) |
| F1 | Logit or additive | F1 = TVFR + ETA(5) | F1 = TVFR * EXP(ETA(5)) |

## Residual Error Models

| Model | Code | Use Case |
|-------|------|----------|
| Combined | Y = IPRED * (1 + EPS(1)) + EPS(2) | Default for PK |
| Proportional | Y = IPRED * (1 + EPS(1)) | When additive component negligible |
| Log-transform | Y = LOG(IPRED) + EPS(1) | When data is log-transformed |

## Diagnostic Thresholds

| Metric | Acceptable | Concerning | Unacceptable |
|--------|-----------|------------|-------------|
| RSE (fixed) | < 30% | 30-50% | > 50% |
| RSE (random) | < 50% | 50-80% | > 80% |
| Condition number | < 1000 | 1000-5000 | > 5000 |
| ETA shrinkage | < 30% | 30-50% | > 50% |

## Covariate Testing

| Step | Threshold | df | Chi-squared |
|------|-----------|-----|-------------|
| Forward addition | p < 0.05 | 1 | 3.84 |
| Backward elimination | p < 0.01 | 1 | 6.63 |

## Anti-Patterns (Don't Do This)

| Anti-Pattern | Why It's Wrong | Correction |
|-------------|---------------|-----------|
| THETA(n) = 0 | NONMEM fixes parameter at 0 | Use 0.00001 |
| Using .res instead of .lst | Non-standard | Always use .lst |
| Hardcoding parameter values | Reports don't auto-update | Pull from .lst programmatically |
| Skipping covariance step | Can't assess parameter uncertainty | Always include $COV |
| GOF with connecting lines | Misleading visual pattern | Use type = "ps" |
| Missing run documentation | Can't trace model decisions | Log every run |

## Project-Specific Conventions

<!-- Fill in as you develop your model -->

| Convention | Value | Notes |
|-----------|-------|-------|
| Dosing units | [mg or mcg] | |
| Concentration units | [ng/mL or mg/L] | |
| Time units | [hours or days] | |
| Key covariates | [WT, SEX, AGE, ...] | |
