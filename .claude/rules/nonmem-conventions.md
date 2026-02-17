---
paths:
  - "models/**/*.mod"
  - "models/**/*.ctl"
  - "models/**/*.lst"
---

# NONMEM Control Stream Conventions

## THETA Rules (Non-Negotiable)

1. **THETA initial estimate can NEVER be 0** — use 0.00001 instead
2. Use boundary constraints: `(0, init)` for positive parameters (CL, V, KA)
3. Use `(-1, init, 1)` for correlation parameters
4. Use `(0, init, 1)` for bioavailability fractions
5. Comment every THETA with parameter name and units: `; CL (L/h)`

## Estimation Methods

| Method | When to Use |
|--------|-------------|
| METHOD=1 INTER (FOCE-I) | Default for PK models |
| METHOD=SAEM | Complex models with convergence issues |
| LAPLACIAN | Binary/count data models |

Always include: `MAXEVAL=9999 PRINT=5 NOABORT SIGDIGITS=3`

## IIV Coding

| Parameter Type | IIV Form | Example |
|---------------|----------|---------|
| CL, V, KA | Exponential | `CL = TVCL * EXP(ETA(1))` |
| Lag time, fractions | Additive | `ALAG1 = TVALAG + ETA(2)` |
| Bioavailability | Logit-transform | `LOGITF1 = THETA(N) + ETA(3)` |

## Residual Error Models

```
; Combined error (default)
W = SQRT(THETA(N)**2 * IPRED**2 + THETA(N+1)**2)
IF (W.EQ.0) W = 0.0001
Y = IPRED + W * EPS(1)
$SIGMA 1 FIX

; Proportional only
Y = IPRED * (1 + EPS(1))

; Log-transformed data
Y = LOG(IPRED) + EPS(1)
```

## $TABLE Requirements

Every run MUST include:
```
$TABLE ID TIME DV IPRED PRED CWRES IWRES ETAs [PK parameters]
       ONEHEADER NOPRINT FILE=sdtab[RUN_NUMBER]
```

Optional additional tables:
```
$TABLE ID WT SEX AGE [covariates] ETA1 ETA2
       ONEHEADER NOPRINT FILE=cotab[RUN_NUMBER]
```

## Control Stream Header

Every .mod file MUST start with:
```
$PROBLEM [PROJECT] - [Description]
; Run: [RUN_NUMBER]
; Based on: [PARENT_RUN or "New"]
; Description: [What changed from parent]
; Analyst: [NAME]
; Date: [YYYY-MM-DD]
```

## Acceptance Criteria

1. **MINIMIZATION SUCCESSFUL** in .lst output
2. **COVARIANCE STEP SUCCESSFUL** (or explicitly justified exception)
3. No "PARAMETER ESTIMATE IS NEAR ITS BOUNDARY" warnings
4. Condition number < 1000
5. RSE < 30% for fixed effects, < 50% for random effects
6. ETA shrinkage < 30% for parameters used in diagnostics

## File Naming

- Control stream: `runXXX.mod`
- Output listing: `runXXX.lst` (NOT .res)
- Diagnostic tables: `sdtabXXX`, `cotabXXX`, `patabXXX`
