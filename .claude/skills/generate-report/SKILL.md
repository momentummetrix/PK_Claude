---
name: generate-report
description: Generate POPPK analysis reports (development update, executive summary, regulatory)
---

# Report Generation

## Usage
```
/generate-report update <run_number>
/generate-report executive <run_number>
/generate-report regulatory <run_number>
```

## Report Types

### Development Update
Quick status report:
- Current model status (run number, phase)
- Latest parameter estimates
- Key diagnostics
- Next steps
- Issues/blockers

### Executive Summary
Non-technical summary:
- Study overview
- Key PK findings
- Covariate effects (in plain language)
- Clinical relevance
- Recommendations

### Regulatory Report
Full PopPK analysis report following template:
```r
library(aipharma)
generate_poppk_report(final_run = run_number, report_type = "regulatory")
```

Uses `templates/model-development-report.md` structure.

## Non-Negotiables
- ALL parameter values pulled from NONMEM output programmatically
- ALL figures auto-generated
- NO hardcoded values anywhere
- Report auto-updates when model is rerun
