---
paths:
  - "**/*.R"
  - "**/*.qmd"
  - "scripts/**"
---

# Context7 Live Documentation for PMX R Packages

**Before writing or modifying R code that uses PMX packages, fetch current documentation from Context7.**

## When to Fetch

Use Context7 (`resolve-library-id` then `query-docs`) when:
- Writing new R code that imports a Tier 1 or Tier 2 package
- Unsure about function signatures, arguments, or return values
- The user asks about a package API or best practice

Do NOT fetch for:
- Simple base R operations
- Code you've already verified in this session
- Trivial tidyverse operations (filter, mutate, select)

## Package Tiers

### Tier 1 — Core PMX (always check before first use in session)
xpose, mrgsolve, rxode2, PKNCA, vpc, nlmixr2, pkr

### Tier 2 — Simulation/ODE (check when writing simulation code)
PKPDsim, posologyr, linpk, nlmixr2est, babelmixr2

### Tier 3 — Tidyverse (check only for non-trivial usage)
dplyr, tidyr, purrr, stringr, readr, forcats, lubridate

### Tier 4 — Visualization (check when building figures/tables)
ggplot2, Plotly, patchwork, cowplot, GGally, gganimate, gt, flextable, officer

### Tier 5 — Pipeline (check when setting up workflow)
targets

## How to Fetch

1. Call `resolve-library-id` with the package name
2. Call `query-docs` with the resolved ID and your specific question
3. Use the returned documentation to write correct code

## Example

Before writing NCA code:
1. `resolve-library-id(libraryName="PKNCA", query="NCA analysis workflow")`
2. `query-docs(libraryId="<resolved-id>", query="PKNCAconc PKNCAdata pk.nca workflow example")`
3. Write code using the documented API
