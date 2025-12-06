Run comprehensive pre-commit checks

This command runs a full quality assurance suite before committing changes.

## Phase 1: Code Style and Quality

### Automatic Formatting
```r
# Auto-format all R files to tidyverse style
styler::style_pkg()
```

### Static Analysis
```r
# Run linter
lint_results <- lintr::lint_package()
print(lint_results)
```

### Spelling Check
```r
# Check spelling in documentation
spelling::spell_check_package()
```

**Review output and fix issues**:
- Fix critical linter errors
- Consider fixing warnings
- Add words to inst/WORDLIST if legitimate

## Phase 2: Documentation

### Update Documentation
```r
# Generate documentation from roxygen2 comments
devtools::document()
```

### Check Documentation Completeness
```r
# Verify all exports are documented
devtools::check_man()
```

**Verify**:
- [ ] All exported functions have complete roxygen2 docs
- [ ] All parameters are documented
- [ ] Return values are described
- [ ] Examples are included and work

## Phase 3: Testing

### Run Test Suite
```r
# Run all tests
test_results <- devtools::test()
print(test_results)
```

**Expected**: All tests pass (0 failures, 0 warnings, 0 skipped)

### Check Test Coverage
```r
# Generate coverage report
coverage <- covr::package_coverage()
print(coverage)

# View detailed report
covr::report(coverage)
```

**Requirements**:
- [ ] Overall coverage >80%
- [ ] All new functions have tests
- [ ] Critical functionality has high coverage

## Phase 4: R CMD Check

### Comprehensive Package Check
```r
# Run CRAN-style check
check_results <- devtools::check(
  document = TRUE,
  args = c("--as-cran"),
  error_on = "warning"
)
```

**Must achieve**:
- ✓ 0 errors
- ✓ 0 warnings
- ✓ 0 notes (preferred, but some notes acceptable)

### Review Common Issues

**Errors** (Must fix):
- Missing dependencies in DESCRIPTION
- Invalid NAMESPACE
- Failing examples or tests
- Invalid R code syntax

**Warnings** (Must fix):
- Undocumented exports
- Missing or broken URLs
- Non-standard file names

**Notes** (Review):
- Package size
- Non-standard directories
- Possibly mis-spelled words

## Phase 5: Additional Quality Checks

### Good Practices Check
```r
# Comprehensive quality assessment
gp_results <- goodpractice::gp()
print(gp_results)
```

**Review**:
- Package structure
- Code complexity
- Function length
- Documentation completeness

### Dependency Audit
```r
# Check for unused dependencies
usethis::use_tidy_description()
```

**Verify**:
- [ ] All Imports are actually used
- [ ] No unnecessary dependencies
- [ ] Versions specified where needed

## Phase 6: Build and Install Test

### Build Source Package
```r
# Create source tarball
tarball <- devtools::build()
print(paste("Built:", tarball))
```

### Install and Quick Test
```r
# Install from source
devtools::install()

# Quick smoke test
library(packagename, character.only = TRUE)
packageVersion("packagename")
```

## Phase 7: Git Repository Review

### Check Status
```bash
# What's changed?
git status

# Detailed diff
git diff

# Staged changes
git diff --staged
```

### Verify .gitignore
Ensure these are NOT in git status:
- `.Rproj.user/`
- `.Rhistory`
- `.RData`
- `*.Rcheck/`
- `*.tar.gz` (except intentional releases)

## Phase 8: Pre-Commit Checklist

Go through this checklist:

**Code Quality**:
- [ ] All R code follows tidyverse style
- [ ] No linter errors or warnings
- [ ] Spelling checked
- [ ] No commented-out code blocks

**Documentation**:
- [ ] All exports documented with roxygen2
- [ ] Examples work and are meaningful
- [ ] NEWS.md updated (if user-facing change)
- [ ] README.md updated (if relevant)

**Testing**:
- [ ] All tests pass
- [ ] Coverage >80%
- [ ] New functionality has tests
- [ ] Edge cases covered

**Package Check**:
- [ ] R CMD check passes (0 errors, 0 warnings)
- [ ] Good practices reviewed
- [ ] Dependencies minimal and necessary

**Git**:
- [ ] Only relevant files staged
- [ ] No sensitive data
- [ ] .gitignore up to date
- [ ] Commit message will be descriptive

## Phase 9: Commit Preparation

If all checks pass:

```bash
# Stage changes selectively
git add -p  # Review each change

# Commit with descriptive message
git commit -m "feat: Add new_function() for data processing

- Implements algorithm from Smith et al. (2020)
- Includes input validation and error handling
- Adds comprehensive tests (coverage: 95%)
- Updates documentation and examples

Closes #42"
```

## Phase 10: Post-Commit (Optional)

### Update Documentation Site
```r
# Rebuild pkgdown site
pkgdown::build_site()
```

### Push to Remote
```bash
git push origin branch-name
```

### Create Pull Request
```bash
gh pr create \
  --title "Add new_function() for data processing" \
  --body "Implements feature requested in #42"
```

## Quick Check Commands

For rapid iteration:

```bash
# Minimal (fast - ~30 seconds)
R -e "devtools::test(); devtools::check_man()"

# Standard (medium - ~2 minutes)
R -e "styler::style_pkg(); devtools::test(); devtools::check()"

# Full (thorough - ~5 minutes)
R -e "styler::style_pkg(); devtools::test(); covr::report(); devtools::check(); goodpractice::gp()"
```

## Troubleshooting

### Tests Fail
1. Run individual test: `testthat::test_file("tests/testthat/test-X.R")`
2. Add `browser()` in test for interactive debugging
3. Check if test expectations need updating

### Documentation Issues
1. Rebuild: `devtools::document()`
2. Check roxygen2 syntax
3. Verify `@export` tags

### R CMD Check Warnings
1. Read warning carefully
2. Search CRAN policies
3. Check R-package-devel mailing list archives

## Success Criteria

Ready to commit when:
- ✓ No R CMD check errors or warnings
- ✓ All tests pass with >80% coverage
- ✓ Documentation complete and builds
- ✓ Code follows style guide
- ✓ Commit message prepared
- ✓ Changes staged appropriately

**Run this before every commit to maintain high quality!**
