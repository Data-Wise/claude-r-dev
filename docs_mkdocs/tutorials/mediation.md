# Mediation Analysis Tutorial

Learn how to use claude-r-dev for developing mediation analysis R packages.

!!! tip "Difficulty: Intermediate"
    This tutorial uses VanderWeele notation, NDE/NIE, and sensitivity analysis.

## Overview

This tutorial walks through setting up claude-r-dev for a mediation analysis package like RMediation, using the specialized `mediation-expert` agent and relevant commands.

## Step 1: Initialize Your Package

```bash
# Install claude-r-dev
curl -fsSL https://raw.githubusercontent.com/Data-Wise/claude-r-dev/main/scripts/install.sh | bash -s -- \
  --profile base \
  --target ~/my-mediation-package

# Start Claude Code
cd ~/my-mediation-package
claude
```

## Step 2: Run the Configuration Wizard

```bash
/project:init
```

Answer the wizard questions:

- **Package type:** Statistical methodology
- **Domain:** Mediation analysis / Causal inference
- **Notation:** VanderWeele (2015)
- **Object system:** S7
- **Inference:** Bootstrap, Delta method, Distribution of product

## Step 3: Check Identification Assumptions

Use the mediation identification command:

```bash
/project:identify-mediation-effects
```

This workflow ensures you document the four VanderWeele conditions:

1. No unmeasured A-Y confounding given C
2. No unmeasured M-Y confounding given A, C
3. No unmeasured A-M confounding given C
4. No effect of A on M-Y confounders

## Step 4: Implement Estimators

```bash
/project:fit-model
```

The workflow guides you through:

- Specifying the estimand (NDE, NIE, CDE)
- Implementing the estimation method
- Adding variance estimation (bootstrap, delta method)
- Creating S7 result classes

## Step 5: Add Sensitivity Analysis

```bash
/project:sensitivity-analysis
```

Implement:

- E-value computation
- Sensitivity parameters for unmeasured confounding
- Tipping point analysis

## Step 6: Get Expert Review

```text
"Use mediation-expert to review my NDE/NIE implementation"
```

The mediation-expert agent checks:

- [x] Identification assumptions are stated
- [x] Formulas match VanderWeele notation
- [x] Variance estimation is valid
- [x] Edge cases are handled

## Example: S7 Mediation Result Class

```r
MediationResult <- S7::new_class(
  "MediationResult",
  properties = list(
    nde = class_numeric,
    nie = class_numeric,
    te = class_numeric,
    nde_se = class_numeric,
    nie_se = class_numeric,
    nde_ci = class_numeric,
    nie_ci = class_numeric,
    proportion_mediated = class_numeric
  ),
  validator = function(self) {
    if (length(self@nde_ci) != 2) {
      return("nde_ci must have 2 elements (lower, upper)")
    }
  }
)
```

## Key Commands

| Command | Purpose |
|---------|---------|
| `/project:identify-mediation-effects` | Check identification assumptions |
| `/project:multiple-mediators` | Handle parallel/serial mediators |
| `/project:fit-model` | Implement estimation |
| `/project:bootstrap-inference` | Add bootstrap CIs |
| `/project:sensitivity-analysis` | Sensitivity to confounding |

## Next Steps

- [Causal Inference Tutorial](causal.md)
- [Survival Analysis Tutorial](survival.md)
- [Commands Reference](../commands-reference.md)
