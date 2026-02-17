# Workflow Quick Reference

**Model:** Contractor (you direct, Claude orchestrates)

---

## The Loop

```
Your instruction
    ↓
[PLAN] (if multi-file or unclear) → Show plan → Your approval
    ↓
[EXECUTE] Implement, verify, done
    ↓
[REPORT] Summary + what's ready
    ↓
Repeat
```

---

## I Ask You When

- **Design forks:** "Option A (fast) vs. Option B (robust). Which?"
- **Code ambiguity:** "Spec unclear on X. Assume Y?"
- **Replication edge case:** "Just missed tolerance. Investigate?"
- **Scope question:** "Also refactor Y while here, or focus on X?"

---

## I Just Execute When

- Code fix is obvious (bug, pattern application)
- Verification (tolerance checks, tests, compilation)
- Documentation (logs, commits)
- Plotting (per established standards)
- Deployment (after you approve, I ship automatically)

---

## Quality Gates (No Exceptions)

| Score | Action |
|-------|--------|
| >= 80 | Ready to commit |
| < 80  | Fix blocking issues |

---

## Non-Negotiables (PK Workflow)

- **THETA != 0:** NONMEM initial estimates can NEVER be zero (use 0.00001)
- **Convergence + Covariance:** Both must succeed for model acceptance
- **No Hardcoding:** Parameter values always pulled from NONMEM output programmatically
- **GOF Plots:** Always use `type = "ps"` (points + smooth, NO connecting lines)
- **Run Numbering:** 1xx (base), 2xx (covariate), 3xx (final)
- **Logging:** Every run logged in model_development_log.yaml
- **Output Format:** Use `.lst` not `.res` for NONMEM output
- **Covariate Thresholds:** Forward dOFV >= 3.84 (p<0.05), Backward dOFV >= 6.63 (p<0.01)
- **RSE Limits:** < 30% fixed effects, < 50% random effects
- **Shrinkage:** < 30% for meaningful individual estimates

---

## Preferences

**Visual:** GOF plots with type="ps", 300 DPI for publication figures
**Reporting:** Concise tables, auto-generated from NONMEM output
**Session logs:** Always (post-plan, incremental, end-of-session)
**Model development:** Log every run, document every decision

---

## Exploration Mode

For experimental work, use the **Fast-Track** workflow:
- Work in `explorations/` folder
- 60/100 quality threshold (vs. 80/100 for production)
- No plan needed — just a research value check (2 min)
- See `.claude/rules/exploration-fast-track.md`

---

## Next Step

You provide task → I plan (if needed) → Your approval → Execute → Done.
