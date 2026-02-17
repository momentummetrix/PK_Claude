---
name: new-run
description: Create a new NONMEM run from an existing model
---

# New Run Creation

## Usage
```
/new-run <new_run_number> <base_run_number> "description of changes"
/new-run 102 101 "Add 2nd compartment"
```

## Protocol

### Step 1: Validate Inputs
- New run number must not already exist
- Base run must exist with .mod file
- Description must be provided

### Step 2: Create Directory
```bash
mkdir -p models/run<NEW>/
```

### Step 3: Copy Control Stream
```bash
cp models/run<BASE>/run<BASE>.mod models/run<NEW>/run<NEW>.mod
```

### Step 4: Update Header
Update in the new .mod file:
- Run number
- Parent run reference
- Description
- Date to today

### Step 5: Update File References
- $TABLE FILE names: sdtab<NEW>, cotab<NEW>, etc.
- Any other run-number-specific references

### Step 6: User Modifies
Present the new control stream for the user to review and modify per their description.

### Step 7: Log
```r
log <- aipharma::log_run(log, "<NEW>", phase = "...", parent_run = "<BASE>", changes = "description")
```

## Verification
- [ ] New directory created
- [ ] Control stream copied and updated
- [ ] Run number references updated
- [ ] Header reflects new run info
- [ ] Model development log updated
