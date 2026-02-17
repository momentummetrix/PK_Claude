---
paths:
  - "Slides/**/*.tex"
  - "Quarto/**/*.qmd"
  - "docs/**"
  - "models/**/*.mod"
  - "models/**/*.ctl"
  - "models/**/*.lst"
---

# Task Completion Verification Protocol

**At the end of EVERY task, Claude MUST verify the output works correctly.** This is non-negotiable.

## For Quarto/HTML Slides:
1. Run `./scripts/sync_to_docs.sh` (or `./scripts/sync_to_docs.sh LectureN`) to render and deploy
2. Open the HTML in browser: `open docs/slides/LectureX.html`
3. Verify images display by reading 2-3 image files to confirm valid content
4. Check HTML source for correct image paths
5. Check for overflow by scanning dense slides
6. Verify environment parity: every Beamer box environment has a CSS equivalent in the QMD
7. Report verification results

## For LaTeX/Beamer Slides:
1. Compile with xelatex and check for errors
2. Open the PDF to verify figures render
3. Check for overfull hbox warnings

## For TikZ Diagrams in HTML/Quarto:
1. Browsers **cannot** display PDF images inline — ALWAYS convert to SVG
2. Use SVG (vector format) for crisp rendering: `pdf2svg input.pdf output.svg`
3. **NEVER use PNG for diagrams** — PNG is raster and looks blurry
4. Verify SVG files contain valid XML/SVG markup
5. Copy SVGs to `docs/Figures/LectureX/` via `sync_to_docs.sh`
6. **Freshness check:** Before using any TikZ SVG, verify extract_tikz.tex matches current Beamer source

## For R Scripts:
1. Run `Rscript scripts/R/filename.R`
2. Verify output files (PDF, RDS) were created with non-zero size
3. Spot-check estimates for reasonable magnitude

## Common Pitfalls:
- **PDF images in HTML**: Browsers don't render PDFs inline → convert to SVG
- **Relative paths**: `../Figures/` works from `Quarto/` but not from `docs/slides/` → use `sync_to_docs.sh`
- **Assuming success**: Always verify output files exist AND contain correct content
- **Stale TikZ SVGs**: extract_tikz.tex diverges from Beamer source → always diff-check

## For NONMEM Control Streams (.mod/.ctl):
1. Check control stream syntax (matching $PROBLEM, $INPUT, $DATA, $SUB, $PK/$PRED, $ERROR, $THETA, $OMEGA, $SIGMA, $EST, $COV, $TABLE)
2. Verify no THETA initial estimate = 0
3. Check $DATA path references valid file
4. Verify $TABLE includes standard diagnostic columns (ID TIME DV IPRED PRED CWRES)

## For NONMEM Output (.lst):
1. Search for "MINIMIZATION SUCCESSFUL" or "MINIMIZATION TERMINATED"
2. Search for "COVARIANCE STEP" status
3. Check for "0PARAMETER ESTIMATE IS NEAR ITS BOUNDARY"
4. Extract final OFV value
5. Report convergence + covariance status clearly

## NONMEM Verification Checklist:
```
[ ] Control stream syntax valid
[ ] No THETA = 0 initial estimates
[ ] Convergence successful
[ ] Covariance step successful
[ ] No boundary warnings
[ ] Condition number < 1000
[ ] RSE within acceptable limits
[ ] Diagnostic plots generated
```

## Verification Checklist:
```
[ ] Output file created successfully
[ ] No compilation/render errors
[ ] Images/figures display correctly
[ ] Paths resolve in deployment location (docs/)
[ ] Opened in browser/viewer to confirm visual appearance
[ ] Reported results to user
```
