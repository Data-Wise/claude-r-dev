# R Package Development with Claude Code

> Base profile for claude-r-dev - Universal R package development standards

## Project Overview
This is an R package under development. Core principles:
- **CRAN Compliance**: Package will pass R CMD check
- **Modern R**: Contemporary best practices and patterns
- **Quality Standards**: Testing, documentation, style
- **Reproducibility**: Version control, dependency management

## Essential Commands

### Development Workflow
```r
devtools::load_all()           # Load package (Cmd+Shift+L in RStudio)
devtools::test()               # Run test suite (Cmd+Shift+T)
devtools::check()              # R CMD check (Cmd+Shift+E)
devtools::document()           # Update docs from roxygen2 (Cmd+Shift+D)
devtools::build()              # Build package tarball
devtools::install()            # Install package locally
```

### Testing & Coverage
```r
testthat::test_file("tests/testthat/test-X.R")  # Test one file
covr::package_coverage()                         # Coverage report
covr::report()                                   # View in browser
```

### Code Quality
```r
styler::style_pkg()            # Auto-format to tidyverse style
lintr::lint_package()          # Static code analysis
spelling::spell_check_package() # Check spelling in docs
goodpractice::gp()             # Comprehensive checks
```

### Documentation
```r
pkgdown::build_site()          # Build package website
pkgdown::build_reference()     # Just rebuild function docs
usethis::use_vignette("name")  # Create new vignette
```

## R Code Standards

### Package Structure Requirements
- **NEVER** use `library()` or `require()` in package code
- **ALWAYS** use `::` notation for external functions (e.g., `dplyr::mutate()`)
- **ALWAYS** use `@importFrom` or `@import` in roxygen2 for dependencies
- All dependencies must be in DESCRIPTION file (Imports or Suggests)

### Function Documentation (roxygen2)

EVERY exported function MUST include:
```r
#' @title Brief one-line description
#' @description Longer description with details
#' @param name Type. Description
#' @return Description of return value structure
#' @examples
#' # Working example
#' result <- my_function(x = 1)
#' @export
```

### Code Style (tidyverse)

```r
# GOOD - Clear, readable
calculate_mean <- function(x, na.rm = TRUE) {
  if (!is.numeric(x)) {
    stop("x must be numeric")
  }
  mean(x, na.rm = na.rm)
}

# BAD - Poor style
calc <- function(x,y=T){mean(x,na.rm=y)}
```

**Key principles:**
- Function names: verbs, snake_case
- Variable names: nouns, snake_case
- Spaces around operators: `x + y` not `x+y`
- Consistent indentation: 2 spaces
- Lines < 80 characters (flexible)
- Meaningful variable names (no single letters except i, j, k)

## Testing Standards

### Test Structure (testthat3)
```r
test_that("function_name() works with standard inputs", {
  # Arrange - Set up test data
  x <- 1:10
  
  # Act - Run function
  result <- my_function(x)
  
  # Assert - Check results
  expect_type(result, "double")
  expect_length(result, 1)
  expect_true(is.finite(result))
})
```

### Critical Edge Cases to Test
**ALWAYS** test these scenarios:
- Missing data (NA values)
- Zero-length inputs
- Single element inputs
- Large inputs (if performance matters)
- Invalid input types
- Boundary values

### Coverage Requirements
- Overall coverage: >80%
- All exported functions: Have tests
- Critical functionality: 100% coverage
- Error handling: Tested

Check with:
```r
covr::package_coverage()
```

## Common Pitfalls to Avoid

### ❌ DON'T DO THIS
```r
# Using library() in package code
my_function <- function(data) {
  library(dplyr)  # WRONG!
  data %>% mutate(x = 1)
}

# Modifying global options without reset
my_function <- function() {
  options(scipen = 999)  # Will affect user's session!
  # ... code ...
}

# Using T/F instead of TRUE/FALSE
if (x == T) { }  # WRONG! T can be overwritten

# Using = for assignment in function calls
my_function(x = 1)  # OK
x = 1               # Bad style, use <-
```

### ✅ DO THIS INSTEAD
```r
# Use :: notation
my_function <- function(data) {
  dplyr::mutate(data, x = 1)
}

# Save and restore options
my_function <- function() {
  old_opts <- options(scipen = 999)
  on.exit(options(old_opts), add = TRUE)
  # ... code ...
}

# Use TRUE/FALSE
if (isTRUE(x)) { }

# Use <- for assignment
x <- 1
```

## Git Workflow

### Branch Naming
- `feature/add-new-function` - New features
- `fix/handle-na-values` - Bug fixes
- `refactor/simplify-internals` - Code refactoring
- `docs/update-vignette` - Documentation
- `test/add-edge-cases` - Test additions

### Commit Messages
Follow [Conventional Commits](https://www.conventionalcommits.org/):

```
feat: Add new_function() for data processing

- Implements algorithm from Smith et al. (2020)
- Includes input validation
- Adds comprehensive tests
- Updates documentation

Closes #42
```

Types: `feat`, `fix`, `docs`, `test`, `refactor`, `style`, `chore`

### Never Commit
- `.Rproj.user/` - RStudio user files
- `.Rhistory` - Command history
- `.RData` - Workspace data
- `*.Rcheck/` - Check output
- Personal notes

## CRAN Compliance

### Critical (Will cause rejection)
- No `library()` or `require()` in package code
- All dependencies in DESCRIPTION
- No writing to user's home directory without permission
- No changing global options without restoration
- Examples run in < 5 seconds (or use `\donttest{}`)
- No `T`/`F` (use `TRUE`/`FALSE`)
- Valid URLs in documentation
- NAMESPACE correctly generated

### Important (Should fix)
- Exported functions have complete documentation
- All parameters documented
- Return values documented
- Functions have working examples
- Clear LICENSE file
- Authors specified with roles

## Performance Considerations

### Vectorization
```r
# GOOD - Vectorized
result <- sum(x * y)

# BAD - Slow loop
result <- 0
for (i in seq_along(x)) {
  result <- result + x[i] * y[i]
}
```

### Memory Efficiency
- Pre-allocate vectors: `result <- vector("list", n)`
- Use `vapply()` not `sapply()` (type-stable)
- Avoid growing objects in loops
- Consider `data.table` for large datasets

### Profiling
```r
# Profile code
profvis::profvis({
  result <- my_function(data)
})

# Benchmark alternatives
bench::mark(
  method1 = approach1(data),
  method2 = approach2(data)
)
```

## Documentation Website (pkgdown)

### _pkgdown.yml Structure
```yaml
template:
  bootstrap: 5
  
reference:
  - title: "Main Functions"
    desc: "Core package functionality"
    contents:
      - main_function
      - helper_function
      
articles:
  - title: "Vignettes"
    contents:
      - getting-started
      - advanced-usage
```

## When Working with Claude Code

### Be Specific
Instead of: "Fix the function"  
Use: "The calculate_mean() function fails when all values are NA. Add proper handling for this edge case."

### Request Verification
"After changes, run the test suite and show me the results"

### Use Iterative Development
1. "Read the current implementation"
2. "Create a plan for the improvement"
3. "Implement following R package standards"
4. "Write tests covering edge cases"
5. "Run R CMD check"

### Reference Files
"Look at how we handle input validation in R/utils.R"  
"Follow the same testing pattern as test-main.R"

## Common Commands Shortlist

```bash
# Quick development cycle
R -e "devtools::load_all(); devtools::test()"

# Before committing
R -e "styler::style_pkg(); devtools::test(); devtools::check()"

# Documentation
R -e "devtools::document(); pkgdown::build_site()"

# Coverage
R -e "covr::report()"
```

## Quality Checklist

Before every commit:
- [ ] Code follows tidyverse style
- [ ] All tests pass
- [ ] Coverage >80%
- [ ] R CMD check passes (0 errors, 0 warnings)
- [ ] Documentation complete
- [ ] Examples work
- [ ] NEWS.md updated (if user-facing change)

## Quick Reference Links

- [R Packages Book](https://r-pkgs.org/) - Comprehensive guide
- [Tidyverse Style Guide](https://style.tidyverse.org/) - Code style
- [testthat Documentation](https://testthat.r-lib.org/) - Testing
- [roxygen2 Documentation](https://roxygen2.r-lib.org/) - Documentation
- [CRAN Repository Policy](https://cran.r-project.org/web/packages/policies.html)

---

**Profile**: base  
**Version**: 1.0.0  
**Last Updated**: 2025-12-05  
**Maintainer**: Update standards as R ecosystem evolves
