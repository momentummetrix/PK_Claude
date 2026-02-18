---
paths:
  - "**/*.R"
  - "**/*.qmd"
---

# PMX R Code Patterns

**Mandatory patterns for all pharmacometrics R code in this project.**

## Reproducibility

- `set.seed()` REQUIRED in any script that uses simulation (rxode2, mrgsolve, sample, rnorm)
- `here::here()` for all file paths — never absolute paths
- All packages loaded at top of script via `library()`

## Figures

- `dpi = 300` for all `ggsave()` calls
- Explicit `fig.width` and `fig.height` in all Quarto chunk options
- GOF plots: always `type = "ps"` (points + smooth)
- Never use `ggplotly()` — use native Plotly (`plot_ly()`) if interactivity needed
- Use MM color palette from `.claude/rules/r-code-conventions.md`

## Tables

- No hardcoded values — always pull from R objects
- Use `gt` or `flextable` for formatted tables
- Include units in column headers
- Numeric formatting: 3 significant figures for PK parameters, 1 decimal for percentages

## Simulation Scripts

- Document dose scenarios in a comment block at top
- Use named parameter vectors (not positional)
- Always propagate parameter uncertainty when bootstrap results available
- Check for negative concentrations in output and flag as warning

## Report Templates

- All analysis reports go in `reports/` directory
- Use Quarto `.qmd` format with YAML header specifying `format: html`
- Include `date: today` and `author` in YAML
- Cross-reference figures and tables using Quarto syntax (`@fig-name`, `@tbl-name`)
