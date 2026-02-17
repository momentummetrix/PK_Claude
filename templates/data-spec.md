# Dataset Specification: [PROJECT_NAME]

**Dataset:** [FILENAME]
**Created:** [DATE]
**Source:** [SOURCE_DESCRIPTION]

---

## Column Definitions

| Column | Type | Description | Required | Source |
|--------|------|-------------|----------|--------|
| ID | Integer | Subject identifier | Yes | |
| TIME | Numeric | Time after first dose (h) | Yes | |
| DV | Numeric | Dependent variable (concentration) | Yes | |
| AMT | Numeric | Dose amount | Yes | |
| MDV | Integer | Missing DV flag (0/1) | Yes | Derived |
| EVID | Integer | Event ID (0=obs, 1=dose) | Yes | Derived |
| CMT | Integer | Compartment number | Yes | |
| WT | Numeric | Body weight (kg) | No | |
| SEX | Integer | Sex (0=female, 1=male) | No | |
| AGE | Numeric | Age (years) | No | |
| | | | | |

## Derivation Rules

| Derived Column | Rule | Notes |
|---------------|------|-------|
| MDV | 1 if EVID=1 or DV is missing, else 0 | |
| EVID | 1 for dosing records, 0 for observations | |
| | | |

## QC Checks

- [ ] No negative TIME values (except pre-dose)
- [ ] No negative DV values (for log-transform)
- [ ] AMT > 0 only when EVID = 1
- [ ] DV present only when EVID = 0
- [ ] All subjects have at least one dosing record
- [ ] All subjects have at least one observation
- [ ] No duplicate TIME values within subject (for same EVID)
- [ ] Covariates within physiological ranges
- [ ] Dataset sorted by ID, TIME
