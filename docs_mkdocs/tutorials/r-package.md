# R Package Development Tutorial

Learn how to use claude-r-dev for professional R package development.

!!! tip "Difficulty: Beginner"
    This tutorial covers the core workflow for any R package.

## Overview

This tutorial covers the core workflow for developing any R package using claude-r-dev, including CRAN compliance, testing, documentation, and quality checks.

## Step 1: Install claude-r-dev

```bash
# Install to your existing R package
curl -fsSL https://raw.githubusercontent.com/Data-Wise/claude-r-dev/main/scripts/install.sh | bash -s -- \
  --profile base \
  --target /path/to/your/package

# Or for a new package, first create it:
Rscript -e "usethis::create_package('mypackage')"
# Then install claude-r-dev
```

## Step 2: Run the Configuration Wizard

```bash
# Start Claude Code
cd /path/to/your/package
claude

# Run the wizard
/project:init
```

The wizard will ask about:

- Package type (general, statistical, data analysis, etc.)
- Object system (S3, S4, S7, R6)
- Testing requirements
- Documentation preferences
- pkgdown website options

## Step 3: Write Code with AI Assistance

Ask Claude to help with your code:

```text
"Create a function that calculates the mean with NA handling"
"Add input validation using checkmate"
"Write roxygen2 documentation for this function"
```

## Step 4: Generate Tests

Use the test-specialist agent:

```text
"Use test-specialist to write comprehensive tests for my_function()"
```

The agent generates tests for:

- [x] Happy path (normal inputs)
- [x] NA values
- [x] Zero-length inputs
- [x] Single element inputs
- [x] Invalid types
- [x] Boundary values
- [x] Large inputs (performance)

## Step 5: Run Pre-Commit Checks

```bash
/project:pre-commit-check
```

This runs:

1. `styler::style_pkg()` - Format code
2. `lintr::lint_package()` - Static analysis
3. `devtools::test()` - Run tests
4. `covr::package_coverage()` - Check coverage (>80%)
5. `devtools::check()` - R CMD check

## Step 6: Get Code Review

```text
"Use r-package-reviewer to review R/my-function.R"
```

The reviewer checks:

- CRAN compliance (critical issues)
- Documentation completeness
- Test coverage
- Code quality and style
- Performance considerations

## Step 7: Debug Issues

```bash
/project:fix-bug "function fails when input is empty"
```

The debugging workflow:

1. **Investigate** - Reproduce and locate issue
2. **Diagnose** - Identify root cause
3. **Write failing test** - TDD approach
4. **Fix** - Implement solution
5. **Validate** - Run tests
6. **Document** - Update NEWS.md

## Step 8: Set Up pkgdown Website

```bash
/project:setup-pkgdown
```

Choose from 5 color schemes:

- 🔵 Academic Blue
- 🟢 Forest Green
- 🟣 Deep Purple
- 🟠 Warm Orange
- 🔷 Ocean Teal

## Step 9: Prepare for CRAN

```bash
# Run comprehensive check
R CMD check --as-cran

# Common issues to fix:
# - No NOTEs, WARNINGs, or ERRORs
# - Examples run in < 5 seconds each
# - Total check time < 10 minutes
# - No external dependencies on unstable URLs
```

## Key Commands

| Command | Purpose |
|---------|---------|
| `/project:init` | Configure claude-r-dev for your package |
| `/project:pre-commit-check` | Run all quality checks |
| `/project:fix-bug` | Systematic debugging |
| `/project:setup-pkgdown` | Create package website |

## Key Agents

| Agent | Purpose |
|-------|---------|
| `r-package-reviewer` | Code review for CRAN compliance |
| `test-specialist` | Comprehensive test generation |

## Next Steps

- [Mediation Analysis Tutorial](mediation.md)
- [Causal Inference Tutorial](causal.md)
- [Commands Reference](../commands-reference.md)
