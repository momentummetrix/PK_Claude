---
name: data-qc
description: Dataset Quality Control - Comprehensive checks for NONMEM-ready datasets
---

# Dataset QC

## Usage
```
/data-qc
/data-qc path/to/dataset.csv
```

## Checks

### 1. Structure
- [ ] Required columns present (ID, TIME, DV, AMT, MDV, EVID, CMT)
- [ ] No unexpected NA values in key columns
- [ ] Correct data types (numeric for DV, integer for ID)

### 2. Dosing Records
- [ ] All subjects have at least one dosing record (EVID=1)
- [ ] AMT > 0 when EVID = 1
- [ ] AMT = 0 or missing when EVID = 0
- [ ] CMT appropriate for dose and observation

### 3. Observation Records
- [ ] DV present when EVID = 0
- [ ] No negative DV values (unless log-transformed)
- [ ] BLQ handling documented

### 4. Time
- [ ] No negative TIME values (except pre-dose if applicable)
- [ ] TIME sorted within each subject
- [ ] No duplicate TIME within subject for same EVID

### 5. Covariates
- [ ] Values within physiological ranges
  - WT: 30-200 kg
  - AGE: 18-100 years
  - CRCL: 10-200 mL/min
- [ ] No missing values for key covariates
- [ ] Categorical covariates properly coded (0/1 or integers)

### 6. Summary Statistics
Generate and present:
- N subjects, N observations, N doses
- DV summary (min, max, median, N BLQ)
- Covariate summaries
- Observations per subject (min, max, median)

## Output
Present QC report with PASS/FAIL for each check and summary statistics.
