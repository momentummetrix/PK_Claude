---
name: model-template
description: Model Template Library - Generate NONMEM control stream templates
---

# Model Template Library

## Usage
```
/model-template
/model-template 1cmt-fo
/model-template 2cmt-fo
/model-template 2cmt-zo
/model-template transit
/model-template tmdd
```

## Available Templates

### 1-CMT First-Order Absorption (1cmt-fo)
- ADVAN2 TRANS2
- CL, V, KA parameterization
- Combined residual error
- Template: `templates/nonmem-1cmt-fo.mod`

### 2-CMT First-Order Absorption (2cmt-fo)
- ADVAN4 TRANS4
- CL, V2, Q, V3, KA parameterization
- Combined residual error
- Template: `templates/nonmem-2cmt-fo.mod`

### 2-CMT Zero-Order Absorption (2cmt-zo)
- ADVAN4 TRANS4 with ALAG and D1
- Zero-order infusion to depot

### Transit Compartment (transit)
- Multiple transit compartments for delayed absorption
- MTT, NN parameterization

### TMDD (tmdd)
- Target-mediated drug disposition
- QSS or full TMDD model

## Protocol

1. Ask user which template (if not specified)
2. Copy template to new run directory
3. Fill in placeholders ([PROJECT_NAME], [RUN_NUMBER], etc.)
4. Present for user customization
5. Validate control stream syntax
