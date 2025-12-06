# Getting Started with claude-r-dev

This guide will help you install and use claude-r-dev in your R package.

## Prerequisites

### Required
- **Claude Code CLI**: `npm install -g @anthropic-ai/claude-code`
- **R** (≥ 4.0.0)
- **Git**

### R Packages
These will be installed on first use if needed:
```r
install.packages(c(
  "devtools", "testthat", "roxygen2",
  "styler", "lintr", "covr", "pkgdown",
  "goodpractice", "spelling", "usethis"
))
```

For statistical-methods profile, also install:
```r
install.packages("S7")
```

## Installation

### Option 1: One-Liner (Recommended)

```bash
# For general R packages (base profile)
curl -fsSL https://raw.githubusercontent.com/username/claude-r-dev/main/scripts/install.sh | \
  bash -s -- --profile base --target /path/to/your/package

# For statistical methods packages
bash <(curl -fsSL https://raw.githubusercontent.com/username/claude-r-dev/main/scripts/install.sh) \
  --profiles base,statistical-methods \
  --target /path/to/your/package
```

### Option 2: Clone and Install

```bash
# Clone repository
git clone https://github.com/username/claude-r-dev.git
cd claude-r-dev

# Install to your package
./scripts/install.sh --profiles base --target ~/projects/mypackage
```

### Option 3: Interactive Installation

```bash
cd claude-r-dev
./scripts/install.sh

# You'll be prompted for:
# - Target package directory
# - Which profiles to install
# - Confirmation before changes
```

## First Session

### 1. Navigate to Your Package
```bash
cd /path/to/your/package
```

### 2. Start Claude Code
```bash
claude
```

### 3. Verify Installation
```
/permissions
```
You should see a list of allowed tools including R commands, git operations, etc.

```
/project:
```
You should see available custom commands (fix-bug, pre-commit-check, etc.)

### 4. Try a Command
```
/project:pre-commit-check
```
This runs a comprehensive quality check on your package.

## Common Usage Patterns

### Daily Development

```bash
# Morning: Start Claude
cd ~/mypackage
claude
```

```
# Check package status
"Show git status and recent changes"

# Development work
/project:fix-bug "function fails with NA inputs"

# Before lunch: Review
"Use r-package-reviewer sub-agent to review my changes"

# Before commit: Quality check
/project:pre-commit-check

# Commit
"Create descriptive commit message for these changes"
```

### Adding New Functionality

```
# 1. Plan first
"Read the existing code structure and create a plan for adding calculate_variance()"

# 2. Write tests first (TDD)
"Use test-specialist sub-agent to write comprehensive tests for calculate_variance()"

# 3. Implement
"Now implement calculate_variance() following our standards"

# 4. Verify
/project:pre-commit-check

# 5. Commit
"Commit with descriptive message"
```

### Fixing Bugs

```
/project:fix-bug "calculate_mean fails when all values are NA"
```
Follow the guided workflow:
1. Investigation
2. Diagnosis
3. Write failing test
4. Implement fix
5. Verify all tests pass
6. Commit

### Code Review

```
"Use r-package-reviewer sub-agent to review R/my-function.R"
```
Get comprehensive feedback on:
- CRAN compliance
- Code quality
- Testing coverage
- Documentation

### Writing Tests

```
"Use test-specialist sub-agent to add edge case tests for my_function()"
```
Generates tests for:
- Happy path
- NA values
- Zero-length inputs
- Invalid types
- Boundary conditions

## Understanding Profiles

### Base Profile
**Everyone gets this.** Includes:
- R package development standards
- Git workflows
- Essential commands: `/project:fix-bug`, `/project:pre-commit-check`
- Sub-agents: `r-package-reviewer`, `test-specialist`

### Statistical-Methods Profile
**For methodology packages.** Adds:
- Causal inference standards
- Statistical notation (VanderWeele, Pearl, etc.)
- Commands for adding methods and sensitivity analysis
- Enhanced reviewer with statistical correctness checks

## Key Commands Reference

### Slash Commands
```
/permissions                  # View/modify tool allowlist
/project:                     # List available custom commands
/project:fix-bug <desc>       # Guided debugging workflow
/project:pre-commit-check     # Comprehensive quality checks
/clear                        # Clear context for new task
```

### Sub-Agents
```
"Use r-package-reviewer sub-agent to review [file/changes]"
"Use test-specialist sub-agent to write tests for [function]"
```

### Keyboard Shortcuts
- `Escape` - Interrupt Claude
- `Escape` (x2) - Go back in history
- `Shift+Tab` - Toggle auto-accept mode
- `Tab` - Autocomplete file paths
- `#` - Add to CLAUDE.md

## Customization

### Add to CLAUDE.md
Press `#` in Claude Code to add notes that will be remembered:
```
# Add your team's specific standards
# Document project-specific patterns
# Note common issues and solutions
```

### Create Custom Commands
Add `.md` files to `.claude/commands/`:
```markdown
<!-- .claude/commands/my-workflow.md -->
My custom workflow: $ARGUMENTS

## Steps
1. First do this
2. Then do that
```

Use with: `/project:my-workflow some-argument`

### Modify Tool Permissions
Edit `.claude/settings.json` to adjust allowed tools.

## Troubleshooting

### Command Not Found
```bash
# Make sure Claude Code is installed
npm install -g @anthropic-ai/claude-code

# Verify installation
claude --version
```

### Slash Commands Don't Appear
- Restart Claude Code session
- Check `.claude/commands/` directory exists
- Verify `.md` files have correct format

### R CMD check Fails
```
/project:pre-commit-check
```
This will identify and help fix issues.

### Tests Failing
```
"Use test-specialist to review and fix failing tests in test-my-function.R"
```

## Getting Help

### In Claude Code
```
"Explain how to use the r-package-reviewer sub-agent"
"What does /project:pre-commit-check do?"
"Show me an example of writing tests"
```

### Documentation
- [Profiles Guide](profiles.md) - Detailed profile descriptions
- [Customization](customization.md) - Extending configurations
- [Contributing](contributing.md) - Adding improvements

### External Resources
- [Claude Code Docs](https://claude.ai/code)
- [Best Practices](https://www.anthropic.com/engineering/claude-code-best-practices)
- [R Packages Book](https://r-pkgs.org/)

## Next Steps

1. ✅ Complete installation
2. ✅ Run first `/project:pre-commit-check`
3. ✅ Try fixing a bug with `/project:fix-bug`
4. ✅ Use sub-agents for code review and testing
5. ✅ Customize CLAUDE.md for your package
6. ✅ Share with your team!

## Tips for Success

1. **Use `/clear` liberally** - Start fresh for new tasks
2. **Let Claude explore first** - "Read files before making changes"
3. **Be specific in requests** - More details = better results
4. **Use sub-agents** - Keep main conversation focused
5. **Test first, always** - Write tests before implementation
6. **Review before committing** - Run pre-commit-check every time

---

Ready to revolutionize your R package development! 🚀
