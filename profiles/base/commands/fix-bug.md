Debug and fix issue: $ARGUMENTS

This command provides a systematic debugging workflow for R package development.

## Phase 1: Investigation

1. **Understand the problem**:
   - Read error messages carefully
   - Identify which function(s) are affected
   - Note conditions that trigger the issue
   - Check R and package versions: `sessionInfo()`

2. **Reproduce the issue**:
   - Create minimal reproducible example
   - Run the failing code
   - Capture exact error message
   - Save traceback if available: `traceback()`

3. **Locate the source**:
   - Review relevant function code
   - Check recent git commits: `git log --oneline -10`
   - Look for related issues: `gh issue list` (if using GitHub)

**STOP and show me your findings before proceeding**

## Phase 2: Diagnosis

1. **Identify root cause**:
   - Is it a logic error (wrong algorithm)?
   - Is it a coding issue (indexing, type mismatch)?
   - Is it an edge case (NA, zero-length, boundary)?
   - Is it a dependency issue?

2. **Check for side effects**:
   - Will fixing this break other functionality?
   - Are there related functions with same issue?
   - Review test suite for similar patterns

3. **Propose solution**:
   - Describe the fix approach
   - Explain why this solves the problem
   - Note any trade-offs

**STOP and confirm the solution approach before implementing**

## Phase 3: Fix Implementation

1. **Write a failing test FIRST**:
   - Create test that reproduces the bug
   - Run `devtools::test()` to confirm it fails
   - Commit the test: `git commit -m "test: Add failing test for #ISSUE"`

2. **Implement the fix**:
   - Make minimal changes to fix the issue
   - Add comments explaining non-obvious changes
   - Maintain code style consistency

3. **Verify the fix**:
   - Run the new test - confirm it passes
   - Run full test suite: `devtools::test()`
   - Ensure no regressions

## Phase 4: Validation

1. **Extended testing**:
   - Test edge cases related to the fix
   - Run `devtools::check()` for full validation
   - Verify examples still work: `devtools::run_examples()`

2. **Performance check** (if relevant):
   - Compare performance before/after with `bench::mark()`

3. **Manual testing**:
   - Run the original failing example
   - Test with different scenarios

## Phase 5: Documentation

1. **Update NEWS.md**:
   ```
   # packagename (development version)
   
   ## Bug fixes
   
   * Fixed issue where `function_name()` would fail with X condition (#ISSUE)
   ```

2. **Update function documentation** if behavior changed:
   - Clarify edge case handling
   - Update examples if needed

## Phase 6: Finalization

1. **Create descriptive commit**:
   ```
   fix: Correct NA handling in calculate_mean()
   
   - Fixed bug where all-NA inputs caused error
   - Added validation for zero-length inputs
   - Improved error messages
   - Added tests for edge cases
   
   Fixes #42
   ```

2. **Optional: Create pull request**:
   ```bash
   git push origin fix/issue-description
   gh pr create --title "Fix: ..." --body "Closes #..."
   ```

## Debugging Tools

```r
# Set breakpoint
debugonce(packagename::function_name)

# Trace function calls
trace(packagename::function_name, tracer = browser)

# Check object structure
str(result)
class(result)

# Find function definition
body(packagename::function_name)
```

## Common Bug Patterns

**Logic Errors**:
- Off-by-one indexing
- Wrong logical operators (& vs &&, | vs ||)
- Incorrect order of operations

**Data Handling**:
- NA propagation not handled
- Factor vs character confusion
- Missing value edge cases
- Empty data.frame/vector

**Type Issues**:
- Expecting numeric, getting integer
- NULL vs NA vs NaN
- List vs vector confusion

## Quality Checklist

Before marking complete:
- [ ] Bug fully reproduced
- [ ] Root cause identified
- [ ] Failing test created and committed
- [ ] Fix implemented with minimal changes
- [ ] New test passes
- [ ] All existing tests pass
- [ ] R CMD check passes
- [ ] NEWS.md updated
- [ ] Commit message is descriptive
