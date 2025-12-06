# Commands Reference

Complete reference for all claude-r-dev slash commands.

---

## Core Commands

### `/project:init`

Interactive wizard to customize Claude Code for your package.

**Usage:**

```
/project:init
```

**What it does:**

- Asks 10 configuration questions
- Generates custom `CLAUDE.md`
- Creates tool permissions
- Sets up pkgdown website (optional)
- Saves configuration for future updates

**When to use:**

- Initial package setup
- Updating configuration after major changes
- Switching domains or methodologies

---

### `/project:pre-commit-check`

Comprehensive quality assurance before committing code.

**Usage:**

```
/project:pre-commit-check
```

**What it does:**

1. Runs `styler::style_pkg()` for formatting
2. Runs `lintr::lint_package()` for static analysis
3. Runs `devtools::test()` for testing
4. Checks `covr::package_coverage()` for coverage
5. Runs `devtools::check()` for CRAN compliance
6. Reports issues and suggests fixes

**When to use:**

- Before every commit
- Before pull requests
- Before CRAN submission

---

### `/project:fix-bug`

Systematic debugging workflow with test-first approach.

**Usage:**

```
/project:fix-bug "description of the bug"
```

**Example:**

```
/project:fix-bug "calculate_mean() fails when all values are NA"
```

**Phases:**

1. **Investigation** - Reproduce and locate issue
2. **Diagnosis** - Identify root cause
3. **Fix Implementation** - Write failing test, then fix
4. **Validation** - Run tests and R CMD check
5. **Documentation** - Update NEWS.md
6. **Finalization** - Commit with descriptive message

---

### `/project:setup-pkgdown`

Set up or update pkgdown website with professional design.

**Usage:**

```
/project:setup-pkgdown
```

Or with specific requirements:

```
/project:setup-pkgdown "academic blue theme, badges in sidebar"
```

**What it does:**

- Creates/updates `_pkgdown.yml`
- Adds custom CSS (`pkgdown/extra.css`)
- Configures color scheme
- Organizes reference by function categories
- Places badges in right sidebar

---

## Survival Analysis Commands

### `/project:survival-analysis`

Complete survival/time-to-event analysis workflow.

**Phases:**

- Data assessment (Kaplan-Meier, risk tables)
- Model specification (Cox, AFT, competing risks)
- Diagnostics (residuals, concordance)
- Reporting (hazard ratios, survival curves)

---

### `/project:check-proportional-hazards`

Check and handle proportional hazards assumption violations.

**Covers:**

- Schoenfeld residuals test
- Log-log plots
- Solutions (stratification, time-varying coefficients)

---

## Bayesian Commands

### `/project:bayesian-model`

Systematic Bayesian model development workflow.

**Phases:**

- Prior specification
- MCMC diagnostics (R-hat, ESS, divergences)
- Posterior analysis
- Model comparison (LOO-CV)

---

### `/project:prior-selection`

Prior specification and sensitivity analysis.

**Covers:**

- Weakly informative priors
- Prior predictive checks
- Sensitivity to prior choices

---

## Causal Inference Commands

### `/project:validate-dag`

Validate causal diagrams for identification.

**Covers:**

- DAG specification (dagitty)
- Adjustment set identification
- Collider detection
- D-separation testing

---

### `/project:propensity-score`

Propensity score-based causal inference.

**Methods:**

- Inverse probability weighting (IPW)
- Matching
- Stratification
- Balance diagnostics

---

### `/project:doubly-robust`

AIPW and TMLE doubly-robust estimation.

**Features:**

- Doubly-robust property explanation
- AIPW implementation
- TMLE implementation
- Influence function standard errors

---

### `/project:instrumental-variable`

Instrumental variable estimation.

**Covers:**

- IV requirements (relevance, exclusion, independence)
- 2SLS implementation
- Weak instrument diagnostics
- LATE interpretation

---

## Mediation Analysis Commands

### `/project:identify-mediation-effects`

Check identification assumptions for causal mediation.

**VanderWeele conditions:**

- No unmeasured A-Y confounding
- No unmeasured M-Y confounding
- No unmeasured A-M confounding
- No exposure-induced M-Y confounders

---

### `/project:multiple-mediators`

Handle parallel and serial multiple mediator analysis.

**Covers:**

- Mediator structure (parallel vs serial)
- Effect decomposition
- Path-specific effects
- Joint mediation

---

## Sub-Agents

### `r-package-reviewer`

Expert code review for CRAN compliance and quality.

**Usage:**

```
"Use r-package-reviewer sub-agent to review R/my-function.R"
```

---

### `test-specialist`

Comprehensive test generation with edge cases.

**Usage:**

```
"Use test-specialist sub-agent to write tests for my_function()"
```

---

### `statistical-methods-expert`

Reviews statistical correctness and methodology.

**Usage:**

```
"Use statistical-methods-expert to verify my estimator"
```

---

### `longitudinal-expert`

Specialist for mixed effects and repeated measures.

**Usage:**

```
"Use longitudinal-expert to review my mixed model"
```

---

### `survival-expert`

Specialist for survival and time-to-event analysis.

**Usage:**

```
"Use survival-expert to review my Cox model"
```

---

### `bayesian-expert`

Specialist for Bayesian inference and MCMC.

**Usage:**

```
"Use bayesian-expert to check my posterior diagnostics"
```

---

### `causal-inference-expert`

Specialist for causal identification and estimation.

**Usage:**

```
"Use causal-inference-expert to verify my DAG and adjustment set"
```

---

### `mediation-expert`

Specialist for causal mediation analysis.

**Usage:**

```
"Use mediation-expert to check my NDE/NIE identification"
```

---

## Quick Reference

### Commands

| Command | Purpose |
|---------|---------|
| `/project:init` | Setup wizard |
| `/project:pre-commit-check` | Quality checks |
| `/project:fix-bug` | Debug workflow |
| `/project:setup-pkgdown` | Website setup |
| `/project:fit-model` | Model fitting |
| `/project:bootstrap-inference` | Bootstrap CIs |
| `/project:sensitivity-analysis` | Sensitivity analysis |
| `/project:survival-analysis` | Survival models |
| `/project:check-proportional-hazards` | PH assumption |
| `/project:bayesian-model` | Bayesian workflow |
| `/project:prior-selection` | Prior specification |
| `/project:validate-dag` | DAG validation |
| `/project:propensity-score` | Propensity scores |
| `/project:doubly-robust` | AIPW/TMLE |
| `/project:instrumental-variable` | IV estimation |
| `/project:identify-mediation-effects` | Mediation ID |
| `/project:multiple-mediators` | Multiple mediators |

### Agents

| Agent | Domain |
|-------|--------|
| `r-package-reviewer` | Code review |
| `test-specialist` | Test generation |
| `statistical-methods-expert` | Methodology |
| `longitudinal-expert` | Mixed models |
| `survival-expert` | Survival analysis |
| `bayesian-expert` | Bayesian/MCMC |
| `causal-inference-expert` | Causal inference |
| `mediation-expert` | Mediation analysis |
