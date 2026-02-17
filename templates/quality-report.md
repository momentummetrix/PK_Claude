# Quality Report: Merge to Main -- [Date]

## Summary
[1-2 sentences: what was merged and why]

## Files Modified
| File | Type | Quality Score |
|------|------|---|
| `path/to/file` | [Code/Slides/Config] | [N]/100 |

## Verification
- [ ] Compilation/execution succeeds
- [ ] Tolerance checks PASS (if applicable)
- [ ] Tests pass (if applicable)
- [ ] Quality gates >= 80

## PK-Specific Verification
- [ ] NONMEM convergence successful
- [ ] Covariance step successful
- [ ] No THETA initial estimates = 0
- [ ] RSE < 30% for fixed effects
- [ ] RSE < 50% for random effects
- [ ] Condition number < 1000
- [ ] ETA shrinkage < 30%
- [ ] GOF plots reviewed (DV vs PRED, DV vs IPRED, CWRES vs TIME, CWRES vs PRED)
- [ ] Parameter values physiologically plausible
- [ ] Model development log updated

## Status
MERGED

## Notes
[Any learnings or follow-ups]
