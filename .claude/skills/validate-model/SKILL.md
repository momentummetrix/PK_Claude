---
name: validate-model
description: Run comprehensive model validation (VPC, NPC, Bootstrap, NPDE)
---

# Model Validation

## Usage
```
/validate-model <run_number>
/validate-model <run_number> vpc
/validate-model <run_number> bootstrap
/validate-model <run_number> npde
/validate-model <run_number> all
```

## Validation Methods

### Visual Predictive Check (VPC)
```r
library(vpc)
vpc_data <- vpc(
  sim = sim_data,
  obs = obs_data,
  stratify = c("DOSE"),  # adjust as needed
  bins = "jenks",
  pi = c(0.05, 0.95),
  ci = c(0.05, 0.95)
)
plot(vpc_data)
```

### Bootstrap (N=1000)
```r
# Generate bootstrap datasets and run NONMEM
# Extract parameter estimates from each run
# Calculate 95% CI and compare to original estimates
```

### NPDE (Normalized Prediction Distribution Errors)
```r
# Generate simulations
# Calculate NPDE
# Check for normality and trends
```

## Report
Present validation results:
- VPC: visual assessment + prediction interval coverage
- Bootstrap: parameter CIs vs original estimates
- NPDE: normality tests, trend assessments
- Overall validation conclusion: VALIDATED / CONCERNS / FAILED
