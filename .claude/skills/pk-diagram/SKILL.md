---
name: pk-diagram
description: Generate PK-relevant Mermaid diagrams - compartment models, workflow charts, data flow diagrams, and decision trees
---

# PK Diagram Generator

## Usage
```
/pk-diagram compartment 2cmt-oral
/pk-diagram workflow model-development
/pk-diagram dataflow "SDTM to ADaM to NONMEM"
/pk-diagram decision "error model selection"
/pk-diagram custom "Show the covariate testing workflow with forward addition and backward elimination"
```

## Arguments

`$ARGUMENTS` is parsed as: `<type> <specification>`

Types: `compartment`, `workflow`, `dataflow`, `decision`, `custom`

## Protocol

### Step 1: Parse Arguments

Extract diagram type and specification from `$ARGUMENTS`.

### Step 2: Generate Mermaid Code

Use the built-in templates below for known types, or generate from the specification for custom diagrams.

### Step 3: Render via Mermaid Chart Plugin

Call `mcp__claude_ai_Mermaid_Chart__validate_and_render_mermaid_diagram` with:
- `prompt`: description of the diagram
- `mermaidCode`: the generated Mermaid code
- `diagramType`: `flowchart` for most, `sequenceDiagram` for workflows
- `clientName`: `claude`

### Step 4: Present Output

Show the rendered diagram and provide the raw Mermaid code block for embedding in Quarto reports:

````
```{mermaid}
<mermaid code here>
```
````

---

## Built-in Compartment Model Templates

### 1-CMT IV Bolus
```mermaid
flowchart LR
    DOSE["Dose (IV)"] -->|k_in| CENTRAL["Central\nV, CL"]
    CENTRAL -->|CL/V| ELIM["Elimination"]
```

### 1-CMT Oral (First-Order Absorption)
```mermaid
flowchart LR
    DOSE["Dose (Oral)"] -->|KA| DEPOT["Depot\nF"]
    DEPOT -->|KA| CENTRAL["Central\nV, CL"]
    CENTRAL -->|CL/V| ELIM["Elimination"]
```

### 2-CMT Oral (First-Order Absorption)
```mermaid
flowchart LR
    DOSE["Dose (Oral)"] --> DEPOT["Depot\nF, KA"]
    DEPOT -->|KA| CENTRAL["Central\nV1, CL"]
    CENTRAL <-->|Q/V1, Q/V2| PERIPH["Peripheral\nV2"]
    CENTRAL -->|CL/V1| ELIM["Elimination"]
```

### 2-CMT IV Infusion
```mermaid
flowchart LR
    DOSE["Dose (IV Infusion)"] -->|Rate| CENTRAL["Central\nV1, CL"]
    CENTRAL <-->|Q| PERIPH["Peripheral\nV2"]
    CENTRAL -->|CL| ELIM["Elimination"]
```

### TMDD (Quasi-Steady-State)
```mermaid
flowchart TD
    DOSE["Dose"] --> CENTRAL["Central\nV, CL"]
    CENTRAL <-->|kon, koff| COMPLEX["Drug-Target\nComplex"]
    CENTRAL -->|CL| ELIM_DRUG["Drug\nElimination"]
    COMPLEX -->|kint| ELIM_COMPLEX["Complex\nInternalization"]
    TARGET["Target\nksyn, kdeg"] <-->|kon, koff| COMPLEX
```

### Transit Compartment Absorption
```mermaid
flowchart LR
    DOSE["Dose"] --> T1["Transit 1\nktr"]
    T1 --> T2["Transit 2\nktr"]
    T2 --> T3["Transit 3\nktr"]
    T3 --> TN["Transit N\nktr"]
    TN -->|ktr| CENTRAL["Central\nV, CL"]
    CENTRAL -->|CL/V| ELIM["Elimination"]
```

## Workflow Templates

### Model Development
```mermaid
flowchart TD
    A["Data QC"] --> B["Base Structural Model"]
    B --> C{"Convergence +\nCovariance?"}
    C -->|No| B
    C -->|Yes| D["IIV Structure"]
    D --> E["Residual Error Model"]
    E --> F["Covariate Screening"]
    F --> G["Forward Addition\ndOFV >= 3.84"]
    G --> H["Backward Elimination\ndOFV >= 6.63"]
    H --> I["Final Model"]
    I --> J["Validation\nVPC + Bootstrap"]
    J --> K["Report"]
```

### NCA Pipeline
```mermaid
flowchart TD
    A["Raw PK Data"] --> B["Data Cleaning\nBLQ Handling"]
    B --> C["Concentration-Time Profiles"]
    C --> D["NCA Computation\nPKNCA / pkr"]
    D --> E["Parameter Summary\nAUC, Cmax, Tmax, t1/2"]
    E --> F["Dose Proportionality"]
    F --> G["Statistical Summary\nby Dose Group"]
    G --> H["NCA Report"]
```

## Custom Diagrams

For `custom` type, generate appropriate Mermaid code from the user's text description. Choose the best diagram type:
- `flowchart TD` or `flowchart LR` for processes and workflows
- `sequenceDiagram` for time-ordered interactions
- `gantt` for timelines
- `classDiagram` for data structures
- `stateDiagram-v2` for state machines

## Non-Negotiables

- Always render via the Mermaid Chart plugin (don't just return raw code)
- Always ALSO provide the raw Mermaid code for Quarto embedding
- Use consistent node styling across diagrams
- Label all arrows with rate constants or descriptions
