---
name: model-log
description: Model development log - Track runs, log decisions, generate development report
---

# Model Development Log

## Usage
```
/model-log init              # Initialize new log
/model-log log <run>         # Log a run
/model-log decision <run>    # Log decision for a run
/model-log view              # View current log
/model-log report            # Generate development report
/model-log scan              # Scan and add all runs
```

## Actions

### init
Initialize `model_development_log.yaml` in project root:
```r
library(aipharma)
log <- init_model_log(project_dir = ".")
```

### log <run>
Log a completed run with auto-parsing:
```r
log <- log_run(log, run_number, phase = "base_structural|covariate|final",
               parent_run = "...", changes = "description")
```

### decision <run>
Record accept/reject decision:
```r
log <- log_decision(log, run_number, decision = "accepted|rejected",
                    rationale = "reason for decision")
```

### view
Display current log summary:
```r
print_log_summary(log)
```

### report
Generate markdown development report:
```r
generate_log_report(log, format = "markdown", file = "reports/model_development_report.md")
```

### scan
Scan all runs and add to log:
```r
log <- scan_and_log_runs(log, phase = "...")
```
