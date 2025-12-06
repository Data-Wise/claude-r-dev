# Survival Analysis Tutorial

Develop time-to-event analysis packages with proper diagnostics and inference.

!!! tip "Difficulty: Intermediate"
    This tutorial covers Cox PH, Kaplan-Meier, AFT models, and competing risks.

## Overview

This tutorial covers building survival analysis R packages using the `survival-expert` agent and survival analysis commands.

## Step 1: Set Up Survival Data

```r
# Create Surv object
library(survival)
surv_obj <- Surv(time = df$time, event = df$status)

# Key checks:
# - time must be positive
# - event must be 0/1 or TRUE/FALSE
# - Handle ties appropriately
```

## Step 2: Exploratory Analysis

```bash
/project:survival-analysis
```

Start with Kaplan-Meier curves:

```r
# Kaplan-Meier estimate
km_fit <- survfit(Surv(time, event) ~ group, data = df)

# Plot with risk table
ggsurvplot(km_fit, 
           risk.table = TRUE,
           pval = TRUE,
           conf.int = TRUE)
```

## Step 3: Fit Cox Proportional Hazards

```r
# Cox model
cox_fit <- coxph(Surv(time, event) ~ x1 + x2 + x3, data = df)

# Summary with hazard ratios
summary(cox_fit)

# Key outputs:
# - Hazard ratios (exp(coef))
# - 95% CIs
# - Concordance (discrimination)
```

## Step 4: Check Proportional Hazards Assumption

```bash
/project:check-proportional-hazards
```

Critical for valid Cox regression:

```r
# Schoenfeld residuals test
ph_test <- cox.zph(cox_fit)
print(ph_test)  # p < 0.05 suggests PH violation

# Visual check
plot(ph_test)  # Residuals should be flat over time

# Solutions for violations:
# 1. Stratification: strata(variable)
# 2. Time-varying coefficients: tt(variable)
# 3. Piecewise models
```

## Step 5: Residual Diagnostics

```r
# Martingale residuals (functional form)
res_mart <- residuals(cox_fit, type = "martingale")
plot(df$x1, res_mart)  # Should show no pattern

# Deviance residuals (outliers)
res_dev <- residuals(cox_fit, type = "deviance")
plot(res_dev)  # Should be symmetric around 0

# dfbeta (influential observations)
res_dfbeta <- residuals(cox_fit, type = "dfbeta")
plot(res_dfbeta[,1])  # Check for influential points
```

## Step 6: Handle Special Cases

| Case | Solution |
|------|----------|
| Tied event times | Use `ties = "efron"` (default) or `"breslow"` |
| Left truncation | Use `Surv(entry, exit, event)` |
| Interval censoring | Use `Surv(time1, time2, type = "interval2")` |
| Competing risks | Use `finegray()` or `cuminc()` |
| Clustered data | Add `cluster(id)` or use frailty models |

## Step 7: Get Expert Review

```text
"Use survival-expert to review my Cox model implementation"
```

The agent checks:

- [x] Survival data structure is correct
- [x] PH assumption is tested
- [x] Tie handling is appropriate
- [x] Residual diagnostics are done
- [x] Results are properly reported

## Key Commands

| Command | Purpose |
|---------|---------|
| `/project:survival-analysis` | Complete survival workflow |
| `/project:check-proportional-hazards` | Test and handle PH violations |
| `/project:fit-model` | Model implementation |
| `/project:bootstrap-inference` | Bootstrap confidence intervals |

## Next Steps

- [Causal Inference Tutorial](causal.md)
- [Mediation Analysis Tutorial](mediation.md)
- [Commands Reference](../commands-reference.md)
