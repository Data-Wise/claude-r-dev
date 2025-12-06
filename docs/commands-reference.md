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

## Statistical Methods Commands

*(Available in templates, activated via wizard)*

### `/project:fit-model`

Systematic workflow for fitting and validating statistical models.

**Phases:**

1. **Specification** - Define estimand and assumptions
2. **Implementation** - Write fitting function
3. **Inference** - Add standard errors and CIs
4. **Diagnostics** - Model checking
5. **Documentation** - Complete roxygen2 docs

---

### `/project:bootstrap-inference`

Implement bootstrap-based inference.

**Topics covered:**

- Bootstrap type selection
- Parallel implementation
- CI methods (percentile, BCa, normal)
- Coverage validation
- Performance optimization

---

### `/project:sensitivity-analysis`

Implement sensitivity analysis for unmeasured confounding.

**Methods:**

- E-value calculation
- Tipping point analysis
- Sensitivity parameter contours
- Interpretation guidance

---

## Sub-Agents

### `r-package-reviewer`

Expert code review for CRAN compliance and quality.

**Usage:**

```
"Use r-package-reviewer sub-agent to review R/my-function.R"
"Use r-package-reviewer to check my latest changes"
```

**Reviews:**

- CRAN compliance (critical and important)
- Documentation completeness
- Test coverage
- Code quality and style
- Performance issues

---

### `test-specialist`

Comprehensive test generation with edge cases.

**Usage:**

```
"Use test-specialist sub-agent to write tests for my_function()"
"Use test-specialist to add edge case tests"
```

**Generates tests for:**

- Happy path
- NA values
- Zero-length inputs
- Single elements
- Invalid types
- Boundary values
- Large inputs

---

### `statistical-methods-expert`

*(Statistical methods profile)*

Reviews statistical correctness and methodology.

**Usage:**

```
"Use statistical-methods-expert to verify my estimator"
```

**Reviews:**

- Estimand definition
- Identification assumptions
- Inference validity
- Numerical stability

---

### `longitudinal-expert`

*(Statistical methods profile)*

Specialist for mixed effects and repeated measures.

**Usage:**

```
"Use longitudinal-expert to review my mixed model"
```

**Reviews:**

- Random effects structure
- Correlation handling
- Convergence issues
- Missing data patterns

---

## Quick Reference

| Command | Purpose |
|---------|---------|
| `/project:init` | Setup wizard |
| `/project:pre-commit-check` | Quality checks |
| `/project:fix-bug` | Debug workflow |
| `/project:setup-pkgdown` | Website setup |
| `/project:fit-model` | Model fitting |
| `/project:bootstrap-inference` | Bootstrap CIs |
| `/project:sensitivity-analysis` | Sensitivity analysis |

| Agent | Purpose |
|-------|---------|
| `r-package-reviewer` | Code review |
| `test-specialist` | Test generation |
| `statistical-methods-expert` | Methodology review |
| `longitudinal-expert` | Mixed models review |
