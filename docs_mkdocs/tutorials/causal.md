# Causal Inference Tutorial

Build causal inference R packages with proper identification, estimation, and sensitivity analysis.

!!! tip "Difficulty: Intermediate"
    This tutorial covers DAGs, propensity scores, AIPW, and TMLE.

## Overview

This tutorial covers building R packages for causal effect estimation using the `causal-inference-expert` agent and causal inference commands.

## Step 1: Define Your Causal Question

Before coding, clarify:

- **Estimand:** ATE, ATT, ATU, or CATE?
- **Treatment:** Binary, multi-valued, or continuous?
- **Target population:** Sample or external?

## Step 2: Validate Your DAG

```bash
/project:validate-dag
```

This command guides you through:

1. Specifying nodes (exposure, outcome, confounders)
2. Drawing edges based on causal knowledge
3. Finding minimal adjustment sets
4. Checking for colliders and M-bias

```r
# Using dagitty
library(dagitty)
dag <- dagitty("dag {
  C -> A
  C -> Y
  A -> Y
}")
adjustmentSets(dag, exposure = "A", outcome = "Y")
# Returns: { C }
```

## Step 3: Implement Propensity Score Methods

```bash
/project:propensity-score
```

| Method | Use When |
|--------|----------|
| IPW | Good overlap, need all observations |
| Matching | Limited overlap, intuitive for stakeholders |
| Stratification | Quick exploratory analysis |
| AIPW | Want doubly-robust protection |

## Step 4: Add Doubly-Robust Estimation

```bash
/project:doubly-robust
```

AIPW is consistent if *either* the propensity score or outcome model is correct:

```r
# AIPW estimator structure
aipw_ate <- function(Y, A, X, ps_model, out_model) {
  # Propensity scores
  ps <- predict(ps_model, type = "response")
  
  # Outcome predictions
  mu1 <- predict(out_model, newdata = transform(X, A = 1))
  mu0 <- predict(out_model, newdata = transform(X, A = 0))
  
  # AIPW
  aipw1 <- mu1 + A * (Y - mu1) / ps
  aipw0 <- mu0 + (1 - A) * (Y - mu0) / (1 - ps)
  
  mean(aipw1 - aipw0)
}
```

## Step 5: Check Positivity

Extreme propensity scores violate positivity:

```r
# Check propensity score distribution
summary(ps)
# Trim if needed
ps_trimmed <- pmax(pmin(ps, 0.99), 0.01)

# Check overlap
ggplot(data.frame(ps = ps, A = factor(A))) +
  geom_density(aes(x = ps, fill = A), alpha = 0.5)
```

## Step 6: Add Sensitivity Analysis

```bash
/project:sensitivity-analysis
```

```r
# E-value for unmeasured confounding
evalue <- function(RR) {
  RR + sqrt(RR * (RR - 1))
}

# Example: If RR = 2.0, E-value = 3.41
```

## Step 7: Get Expert Review

```text
"Use causal-inference-expert to review my IPW implementation"
```

The agent checks:

- [x] Identification assumptions are justified
- [x] Adjustment set is sufficient
- [x] Positivity violations are handled
- [x] Standard errors are correctly computed

## Key Commands

| Command | Purpose |
|---------|---------|
| `/project:validate-dag` | DAG validation and adjustment sets |
| `/project:propensity-score` | PS estimation and diagnostics |
| `/project:doubly-robust` | AIPW/TMLE implementation |
| `/project:instrumental-variable` | IV estimation |
| `/project:sensitivity-analysis` | Robustness to confounding |

## Next Steps

- [Mediation Analysis Tutorial](mediation.md)
- [Survival Analysis Tutorial](survival.md)
- [Commands Reference](../commands-reference.md)
