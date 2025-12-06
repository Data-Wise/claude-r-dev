# Statistical Methodology Package Development

> Statistical-methods profile for claude-r-dev - Extends base for methodology packages

**This profile extends the base profile with standards for statistical methodology, causal inference, and research software.**

## Profile Scope

This profile is designed for R packages that:
- Implement new statistical methods or estimators
- Focus on causal inference or epidemiological methods
- Provide inference procedures (bootstrap, asymptotic, Bayesian)
- Require rigorous identification assumptions
- Need sensitivity analysis components
- Target methodological journals (JASA, Biostatistics, Epidemiology, etc.)

## Statistical Standards

### Identification Assumptions
EVERY method implementation MUST clearly document required assumptions.

Standard assumptions for causal inference:
1. **Consistency** (SUTVA): Well-defined interventions
2. **Positivity** (Overlap): P(A=a|C) > 0 for all a, C
3. **Exchangeability** (No unmeasured confounding): Y(a) ⊥ A | C
4. **Correct model specification**: Functional forms are correct

For mediation analysis, additionally:
5. **Sequential ignorability**: M(a) ⊥ A | C and Y(a,m) ⊥ M | A, C
6. **Cross-world independence** (for natural effects)

### Standard Notation

Use established notation from methodology literature:

**VanderWeele (2015) - Mediation Analysis**:
- Outcome: Y
- Mediator: M  
- Exposure/Treatment: A
- Confounders: C
- Natural Direct Effect: NDE
- Natural Indirect Effect: NIE
- Total Effect: TE
- Controlled Direct Effect: CDE
- Proportion Mediated: PM

**Pearl (2009) - Causal Inference**:
- Potential outcomes: Y(a), Y(a,m)
- do-operator: P(Y|do(A=a))
- Counterfactuals: Y_a, Y_{a,m}

**Hernán & Robins (2024) - Causal Inference Book**:
- g-formula notation
- IP weighting: SW(A,C)
- Marginal structural models

**Mathematical Notation**:
- Expectations: E[Y|A,M] not E(Y|A,M)
- Probability: P(A=a) not Pr(A=a)
- Estimands in bold: **θ** for population parameters
- Estimates with hat: θ̂ for sample estimates

### Effect Measures

Standard effect measures to implement:

**Mediation Analysis**:
- Natural Direct Effect: E[Y(a, M(a*)) - Y(a*, M(a*))]
- Natural Indirect Effect: E[Y(a, M(a)) - Y(a, M(a*))]
- Total Effect: TE = NDE + NIE (under rare outcome assumption)
- Proportion Mediated: PM = NIE / TE
- Controlled Direct Effect: CDE(m) = E[Y(a, m) - Y(a*, m)]

**Causal Inference General**:
- Average Treatment Effect: ATE = E[Y(1) - Y(0)]
- Average Treatment Effect on Treated: ATT = E[Y(1) - Y(0) | A=1]
- Conditional Average Treatment Effect: CATE(C) = E[Y(1) - Y(0) | C]

### Inference Methods

Support multiple inference approaches:

**1. Delta Method** (Fast, asymptotic):
```r
# Compute standard errors via delta method
# Use numDeriv::jacobian() or manual derivatives
# Good for simple estimators
```

**2. Bootstrap** (Robust, computationally intensive):
```r
# Nonparametric bootstrap
# Default B = 1000 (minimum)
# Use parallel::mclapply() for speed
# Provide percentile and normal CIs
```

**3. Influence Functions** (Efficient, complex):
```r
# Compute efficient influence function
# Provides semiparametric efficiency
# Requires careful derivation
```

**4. Monte Carlo** (For complex models):
```r
# Simulate from fitted models
# Good for complex mediation structures
# Document simulation approach
```

### S7 Object System

For modern R packages, use S7 for classes:

```r
# Define result class with validator
MediationResult <- new_class(
  name = "MediationResult",
  properties = list(
    direct_effect = class_double,
    indirect_effect = class_double,
    total_effect = class_double,
    standard_errors = class_double,
    confidence_intervals = class_matrix,
    method = class_character,
    n_obs = class_integer
  ),
  validator = function(self) {
    # Validate all properties
    if (any(!is.finite(c(self@direct_effect, self@indirect_effect)))) {
      return("Effects must be finite")
    }
    if (any(self@standard_errors < 0)) {
      return("Standard errors must be non-negative")
    }
  }
)

# Define methods
method(print, MediationResult) <- function(x, digits = 3, ...) {
  cat("\nMediation Analysis Results\n")
  cat(rep("=", 50), "\n\n", sep = "")
  cat("Method:", x@method, "\n")
  cat("Sample size:", x@n_obs, "\n\n")
  cat("Natural Direct Effect:", format(x@direct_effect, digits = digits), "\n")
  cat("Natural Indirect Effect:", format(x@indirect_effect, digits = digits), "\n")
  cat("Total Effect:", format(x@total_effect, digits = digits), "\n")
  invisible(x)
}
```

## Testing Standards for Statistical Methods

### Statistical Correctness Tests

```r
test_that("method satisfies known theoretical properties", {
  # Test on data with known truth
  data <- simulate_known_effects(nde = 0.5, nie = 0.3, n = 1000)
  
  result <- mediate(outcome = "Y", mediator = "M", 
                   treatment = "A", data = data)
  
  # Should be close to truth (within 2 SE)
  expect_equal(result@direct_effect, 0.5, tolerance = 0.1)
  expect_equal(result@indirect_effect, 0.3, tolerance = 0.1)
})

test_that("effect decomposition satisfies TE = NDE + NIE", {
  data <- simulate_rare_outcome(n = 1000)
  
  result <- mediate(outcome = "Y", mediator = "M",
                   treatment = "A", data = data)
  
  # For rare outcomes
  expect_equal(
    result@total_effect,
    result@direct_effect + result@indirect_effect,
    tolerance = 0.01
  )
})
```

### Simulation-Based Validation

```r
test_that("bootstrap CIs have nominal coverage", {
  skip_on_cran()  # Too slow
  
  n_sim <- 100
  coverage <- 0
  
  for (i in seq_len(n_sim)) {
    data <- simulate_known_effects(nde = 0.5, n = 200)
    
    result <- mediate_bootstrap(
      outcome = "Y", mediator = "M", treatment = "A",
      data = data, B = 500, conf.level = 0.95
    )
    
    ci <- result@confidence_intervals["direct_effect", ]
    if (ci[1] <= 0.5 && 0.5 <= ci[2]) {
      coverage <- coverage + 1
    }
  }
  
  # Should be approximately 95% (allow 90-100%)
  expect_gte(coverage / n_sim, 0.90)
  expect_lte(coverage / n_sim, 1.00)
})
```

### Edge Cases Specific to Statistical Methods

**Always test**:
- Missing data in outcomes, mediators, exposures, confounders
- Zero variance in variables
- Perfect collinearity between confounders
- Singular covariance matrices
- Extreme values that might cause numerical instability
- Different variable types (binary, continuous, categorical)
- Small sample sizes (n < 100)
- Very large sample sizes (n > 100,000)

## Sensitivity Analysis

Methods packages should include sensitivity analysis tools:

```r
# E-values for unmeasured confounding
evalue_mediation <- function(nde, nie, rare_outcome = TRUE) {
  # Implement VanderWeele & Ding (2017)
  # Return minimum strength of confounding
}

# Tipping point analysis
tipping_point <- function(result, alpha = 0.05) {
  # How much confounding to nullify effect?
}

# Sensitivity parameter approaches
sensitivity_analysis <- function(result, rho_range = seq(-0.5, 0.5, 0.1)) {
  # Vary sensitivity parameter
  # Show how estimates change
}
```

## Documentation Requirements

### Function Documentation Must Include

```r
#' @title Brief description of method
#' @description Detailed description including:
#'   - What causal estimand is targeted
#'   - What identification assumptions are required
#'   - What inference method is used
#'   - What sensitivity analysis is available
#'   
#' @param outcome Character. Name of outcome variable
#' @param mediator Character. Name of mediator variable  
#' @param treatment Character. Name of treatment variable
#' @param confounders Character vector. Names of confounders
#' @param data Data frame with all variables
#' @param inference Character. Inference method ("bootstrap", "delta")
#' @param conf.level Numeric. Confidence level (default 0.95)
#' 
#' @return S7 object of class MediationResult with properties:
#'   \item{direct_effect}{Natural direct effect estimate}
#'   \item{indirect_effect}{Natural indirect effect estimate}
#'   \item{standard_errors}{Standard errors for effects}
#'   \item{confidence_intervals}{Matrix of confidence intervals}
#'   
#' @details
#' **Identification Assumptions:**
#' \enumerate{
#'   \item No unmeasured confounding of treatment-outcome
#'   \item No unmeasured confounding of mediator-outcome
#'   \item No unmeasured confounding of treatment-mediator
#'   \item No effect of treatment that confounds mediator-outcome
#' }
#' 
#' **Inference:**
#' Bootstrap inference with B=1000 resamples by default.
#' Percentile confidence intervals provided.
#' 
#' @references
#' VanderWeele, T. J. (2015). Explanation in Causal Inference: Methods for 
#' Mediation and Interaction. Oxford University Press.
#' 
#' @examples
#' \dontrun{
#'   # Simulate data
#'   set.seed(123)
#'   n <- 500
#'   C <- rnorm(n)
#'   A <- rbinom(n, 1, plogis(0.3 * C))
#'   M <- rnorm(n, 0.5 * A + 0.3 * C, 1)
#'   Y <- rnorm(n, 0.5 * A + 0.3 * M + 0.4 * C, 1)
#'   data <- data.frame(Y, M, A, C)
#'   
#'   # Estimate effects
#'   result <- mediate(
#'     outcome = "Y",
#'     mediator = "M",
#'     treatment = "A",
#'     confounders = "C",
#'     data = data
#'   )
#'   
#'   print(result)
#'   summary(result)
#' }
#' @export
```

## Vignette Requirements

Methodology packages should include:

**1. Getting Started Vignette**:
- Simple example with simulated data
- Explanation of estimand
- Interpretation of results
- References to methodology papers

**2. Methodology Vignette**:
- Detailed explanation of method
- Mathematical formulation
- Identification assumptions
- Comparison to related methods
- Simulation demonstrating properties

**3. Real Data Example**:
- Application to actual dataset
- Complete workflow
- Sensitivity analysis
- Interpretation for applied researchers

## Performance for Statistical Computing

### Optimization Priorities

1. **Vectorization**: Use matrix operations
```r
# Good - Vectorized
effects <- colMeans((Y1 - Y0) * weights)

# Bad - Loop
effects <- numeric(ncol(Y1))
for (j in seq_len(ncol(Y1))) {
  effects[j] <- mean((Y1[,j] - Y0[,j]) * weights)
}
```

2. **Parallel Bootstrap**:
```r
bootstrap_se <- function(data, B = 1000, parallel = TRUE) {
  ncores <- if (parallel) parallel::detectCores() - 1 else 1
  
  boot_results <- parallel::mclapply(
    seq_len(B),
    function(b) {
      boot_data <- data[sample(nrow(data), replace = TRUE), ]
      compute_estimator(boot_data)
    },
    mc.cores = ncores
  )
  
  sd(unlist(boot_results))
}
```

3. **Efficient Data Structures**:
```r
# For large datasets
if (nrow(data) > 100000) {
  library(data.table)
  data <- as.data.table(data)
  # Use data.table operations
}
```

## Manuscript Integration

Functions should facilitate manuscript preparation:

```r
# Extract results for tables
extract_results <- function(result) {
  tibble::tibble(
    Effect = c("NDE", "NIE", "TE"),
    Estimate = c(result@direct_effect, 
                 result@indirect_effect,
                 result@total_effect),
    SE = result@standard_errors,
    CI_Lower = result@confidence_intervals[, 1],
    CI_Upper = result@confidence_intervals[, 2]
  )
}

# Format for LaTeX tables
format_for_latex <- function(results_table) {
  # Format with proper significant figures
  # Add LaTeX markup
}
```

## Common Statistical Pitfalls

### ❌ Avoid

- Claiming causal effects without stating assumptions
- Ignoring positivity violations
- Using wrong variance estimator (e.g., treating estimated propensity scores as known)
- Not accounting for multiple testing when relevant
- Overstating conclusions beyond what assumptions allow
- Ignoring sensitivity to unmeasured confounding

### ✅ Do

- Always state identification assumptions clearly
- Check positivity/overlap diagnostically
- Use appropriate inference accounting for estimation uncertainty
- Adjust for multiple comparisons when conducting many tests
- Interpret results conditional on assumptions
- Conduct and report sensitivity analyses

## References to Key Papers

Maintain bibliography of essential methodology papers:

**Mediation Analysis**:
- VanderWeele, T. J. (2015). Explanation in Causal Inference.
- Imai, K., Keele, L., & Tingley, D. (2010). AJPS mediation paper.
- Pearl, J. (2001). Direct and indirect effects.

**Causal Inference**:
- Pearl, J. (2009). Causality.
- Hernán, M. A., & Robins, J. M. (2024). Causal Inference book.
- Robins, J. M., & Greenland, S. (1992). G-computation.

**Sensitivity Analysis**:
- VanderWeele, T. J., & Ding, P. (2017). E-values.
- Rosenbaum, P. R. (2002). Observational Studies.
- Ding, P., & VanderWeele, T. J. (2016). Sensitivity formulas.

---

**Profile**: statistical-methods  
**Extends**: base  
**Version**: 1.0.0  
**Last Updated**: 2025-12-05
