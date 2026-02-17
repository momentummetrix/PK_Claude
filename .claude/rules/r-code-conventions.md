---
paths:
  - "**/*.R"
  - "Figures/**/*.R"
  - "scripts/**/*.R"
---

# R Code Standards

**Standard:** Senior Principal Data Engineer + PhD researcher quality

---

## 1. Reproducibility

- `set.seed()` called ONCE at top (YYYYMMDD format)
- All packages loaded at top via `library()` (not `require()`)
- All paths relative to repository root
- `dir.create(..., recursive = TRUE)` for output directories

## 2. Function Design

- `snake_case` naming, verb-noun pattern
- Roxygen-style documentation
- Default parameters, no magic numbers
- Named return values (lists or tibbles)

## 3. Domain Correctness (Pharmacometrics)

- Verify xpose data objects are created with correct run numbers
- Check aipharma function calls use correct parameters
- GOF plots MUST use `type = "ps"` (points + smooth, no connecting lines)
- Never use `ggplotly()` for GOF plots — use native plotly if interactive needed
- Parameter estimates must be pulled from NONMEM output programmatically, never hardcoded
- Check vpc::vpc() calls use appropriate binning and stratification

## 4. Visual Identity

```r
# --- Momentum Metrix palette (customize) ---
mm_primary   <- "#1B365D"   # Dark navy
mm_secondary <- "#4A90D9"   # Medium blue
mm_accent    <- "#E8891C"   # Orange accent
mm_success   <- "#2D8B4E"   # Green
mm_warning   <- "#D4A017"   # Gold
mm_error     <- "#C0392B"   # Red
```

### Custom Theme
```r
theme_custom <- function(base_size = 14) {
  theme_minimal(base_size = base_size) +
    theme(
      plot.title = element_text(face = "bold", color = primary_blue),
      legend.position = "bottom"
    )
}
```

### Figure Dimensions for Beamer
```r
ggsave(filepath, width = 12, height = 5, bg = "transparent")
```

## 5. RDS Data Pattern

**Heavy computations saved as RDS; slide rendering loads pre-computed data.**

```r
saveRDS(result, file.path(out_dir, "descriptive_name.rds"))
```

## 6. Common Pitfalls

<!-- Add your field-specific pitfalls here -->
| Pitfall | Impact | Prevention |
|---------|--------|------------|
| Missing `bg = "transparent"` | White boxes on slides | Always include in ggsave() |
| Hardcoded paths | Breaks on other machines | Use relative paths |
| Wrong GOF plot type | Lines connecting points | Always use type = "ps" in xpose |
| Hardcoded NONMEM values | Reports don't auto-update | Use xpose/aipharma to extract |
| ggplotly() for GOF | Ugly, broken output | Use native plotly or static ggplot2 |
| Missing convergence check | Accepting failed models | Always check_run_status() first |
| Wrong run directory | Reading wrong model output | Use consistent run_dir parameter |

## 7. Line Length & Mathematical Exceptions

**Standard:** Keep lines <= 100 characters.

**Exception: Mathematical Formulas** -- lines may exceed 100 chars **if and only if:**

1. Breaking the line would harm readability of the math (influence functions, matrix ops, finite-difference approximations, formula implementations matching paper equations)
2. An inline comment explains the mathematical operation:
   ```r
   # Sieve projection: inner product of residuals onto basis functions P_k
   alpha_k <- sum(r_i * basis[, k]) / sum(basis[, k]^2)
   ```
3. The line is in a numerically intensive section (simulation loops, estimation routines, inference calculations)

**Quality Gate Impact:**
- Long lines in non-mathematical code: minor penalty (-1 to -2 per line)
- Long lines in documented mathematical sections: no penalty

## 8. Code Quality Checklist

```
[ ] Packages at top via library()
[ ] set.seed() once at top
[ ] All paths relative
[ ] Functions documented (Roxygen)
[ ] Figures: transparent bg, explicit dimensions
[ ] RDS: every computed object saved
[ ] Comments explain WHY not WHAT
```
