---
name: simulate-pk
description: PK/PD simulation workflow using rxode2 or mrgsolve. Scaffolds dose scenarios, population simulations, and prediction interval plots.
---

# PK/PD Simulation

## Usage
```
/simulate
/simulate rxode2
/simulate mrgsolve
/simulate <run_number>
```

## What This Does

Scaffolds a PK/PD simulation workflow:
1. Define or load model parameters (from NONMEM run or manual input)
2. Set up dose scenarios
3. Run population simulations with variability
4. Generate spaghetti + median/PI plots
5. Optionally propagate parameter uncertainty

## Protocol

### Step 1: Fetch Documentation
Use Context7 for the selected engine (rxode2 or mrgsolve).

### Step 2: Determine Model Source
If `$ARGUMENTS` is a run number:
- Load parameters from NONMEM output using xpose/aipharma
- Translate NONMEM model structure to rxode2/mrgsolve syntax

If no run number:
- Ask user for model structure and parameters
- Or use a previously defined model file

### Step 3: Define Dose Scenarios
Ask user for:
- Dose levels and regimens
- Number of subjects per scenario
- Simulation duration
- Special populations (if covariate effects included)

### Step 4: Scaffold Report
Copy `templates/simulation-report.qmd` to `reports/`.
Configure for selected engine and scenarios.

### Step 5: Generate Simulations
- Set `set.seed()` for reproducibility
- Run N subjects per scenario (default: 1000)
- Calculate median and 90% prediction intervals
- Generate:
  - Spaghetti plots (individual profiles)
  - Median + PI ribbon plots
  - Dose comparison overlays

### Step 6: Review
- Check no negative concentrations
- Verify steady-state achieved if applicable
- Compare to observed data if available

## Non-Negotiables
- `set.seed()` at top of every simulation script
- Named parameter vectors (not positional)
- Document all dose scenarios in header comments
- dpi = 300 for all figures
- Include parameter uncertainty propagation when bootstrap available
