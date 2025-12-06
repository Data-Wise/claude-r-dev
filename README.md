# claude-r-dev

> Supercharge your R package development with AI-powered workflows using Claude Code

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![GitHub release](https://img.shields.io/github/v/release/Data-Wise/claude-r-dev)](https://github.com/Data-Wise/claude-r-dev/releases)
[![GitHub stars](https://img.shields.io/github/stars/Data-Wise/claude-r-dev)](https://github.com/Data-Wise/claude-r-dev/stargazers)
[![GitHub Pages](https://img.shields.io/badge/docs-GitHub%20Pages-blue)](https://data-wise.github.io/claude-r-dev/)
[![Commands](https://img.shields.io/badge/commands-17-green)](https://data-wise.github.io/claude-r-dev/commands-reference/)
[![Agents](https://img.shields.io/badge/agents-8-purple)](https://data-wise.github.io/claude-r-dev/commands-reference/)

**claude-r-dev** is a comprehensive configuration system for [Claude Code](https://claude.ai/code) that transforms AI-assisted coding from helpful suggestions into systematic, production-ready R package development.

## ✨ What You Get

- 🔧 **Modular Profiles**: Mix and match configurations for your package type
- 🤖 **Specialized Sub-Agents**: Expert AI assistants for code review, testing, and more
- ⚡ **Custom Workflows**: Slash commands for common development tasks
- 📊 **Quality Automation**: Built-in checks for CRAN compliance, test coverage, style
- 🎓 **Best Practices**: Embedded standards from R package development, statistical methodology, and software engineering
- 🚀 **One-Line Install**: From GitHub directly to your package

## 🚀 Quick Start

### Install Claude Code CLI

```bash
npm install -g @anthropic-ai/claude-code
```

### Install claude-r-dev to Your Package

**Option 1: One-liner (recommended)**

```bash
curl -fsSL https://raw.githubusercontent.com/Data-Wise/claude-r-dev/main/scripts/install.sh | bash -s -- \
  --profile base \
  --target /path/to/your/package
```

**Option 2: With multiple profiles**

```bash
# For statistical methodology packages
bash <(curl -fsSL https://raw.githubusercontent.com/Data-Wise/claude-r-dev/main/scripts/install.sh) \
  --profiles base,statistical-methods \
  --target ~/projects/mypackage
```

**Option 3: Clone and customize**

```bash
git clone https://github.com/Data-Wise/claude-r-dev.git
cd claude-r-dev
./scripts/install.sh --profiles base,statistical-methods --target ~/mypackage
```

### Start Using

```bash
cd /path/to/your/package
claude

# Try these commands:
/permissions              # View configured tools
/project:                 # See available slash commands
/project:pre-commit-check # Run comprehensive quality checks
```

## 🎨 Create Your Custom Configuration

**NEW:** Interactive wizard to generate package-specific configurations!

```bash
cd your-package
claude

/project:init
```

The wizard asks about:

- Package type and domain
- Statistical notation preferences
- Object system (S3, S4, S7, R6)
- Function organization
- Inference methods
- Testing requirements
- Website design (5 color schemes!)

...and generates a custom configuration tailored to YOUR package!

[Learn more about customization →](https://data-wise.github.io/claude-r-dev/customization-guide/)

## 📦 Available Profiles

### 🔧 base (Required)

**Essential R package development standards**

- CRAN compliance automation
- Testing standards (testthat3, >80% coverage)
- Code style enforcement (tidyverse)
- Git workflows and best practices
- Documentation standards (roxygen2, pkgdown)

**Includes:**

- `/project:fix-bug` - Structured debugging workflow
- `/project:pre-commit-check` - Comprehensive quality checks
- `r-package-reviewer` sub-agent - Expert code review
- `test-specialist` sub-agent - Comprehensive test generation

### 📊 statistical-methods

**For methodology and causal inference packages**

- Statistical notation standards (VanderWeele, Pearl, Hernán & Robins)
- Identification assumptions documentation
- Sensitivity analysis patterns
- Simulation study workflows
- S7 object system guidelines

**Includes:**

- `/project:add-method` - Systematic new method development
- `/project:migrate-s7` - Safe S3/S4 to S7 migration
- Enhanced `r-package-reviewer` with statistical correctness checks
- Methods-specific testing patterns

### 📈 data-analysis *(Coming in v1.4)*

For packages focused on data analysis and visualization

### 🌐 shiny *(Coming in v1.4)*

For Shiny application packages

### 🧬 bioconductor *(Coming in v1.4)*

For Bioconductor package development

[See all profiles →](https://data-wise.github.io/claude-r-dev/profiles/)

## 💡 Usage Examples

### Basic Package Development

```bash
# Install base profile
./scripts/install.sh --profile base --target ~/mypackage
cd ~/mypackage
claude
```

```
# In Claude Code:
"Read the package structure and suggest improvements"
/project:pre-commit-check
/project:fix-bug "function X fails with negative inputs"
```

### Statistical Methods Package

```bash
# Install base + statistical-methods
./scripts/install.sh --profiles base,statistical-methods --target ~/causalmethod
cd ~/causalmethod
claude
```

```
# In Claude Code:
/project:add-method "doubly-robust-mediation"
# Follows guided workflow: Plan → Test → Implement → Document

"Use r-package-reviewer sub-agent to check statistical correctness"
# Reviews formulas, assumptions, inference methods

/project:migrate-s7 MediationResult
# Safely migrates S3/S4 classes to modern S7
```

### Test-Driven Development

```
"Use test-specialist to write comprehensive tests for my_function()"
# Generates tests for happy path, edge cases, validation

/project:pre-commit-check
# Ensures >80% coverage, style compliance, R CMD check passes

"Commit these changes with a descriptive message"
# Claude writes commit following conventional commits standard
```

## 🎯 Key Features

### Custom Slash Commands

Execute complex workflows with simple commands:

- `/project:add-method` - Add new statistical/analytical methods
- `/project:fix-bug` - Test-first debugging workflow
- `/project:migrate-s7` - S3/S4 to S7 class migration
- `/project:pre-commit-check` - Full quality assurance suite

### Specialized Sub-Agents

Expert AI assistants that maintain focused context:

- **r-package-reviewer**: Reviews for statistical correctness, CRAN compliance, code quality
- **test-specialist**: Writes comprehensive test suites with edge cases
- **documentation-writer**: Creates roxygen2 docs, vignettes, pkgdown sites

### Automated Quality Checks

Built-in automation for:

- ✅ Style checking (`styler`, `lintr`)
- ✅ Test coverage (`covr`, >80% required)
- ✅ R CMD check (CRAN compliance)
- ✅ Documentation completeness
- ✅ Spelling and grammar
- ✅ Git commit message standards

### Statistical Rigor

For methodology packages:

- Standard notation (VanderWeele 2015, Pearl 2009)
- Identification assumptions documentation
- Inference method requirements (bootstrap, delta method)
- Sensitivity analysis integration
- Edge case testing (missing data, collinearity, etc.)

## 📚 Documentation

**Documentation Site:** [https://data-wise.github.io/claude-r-dev/](https://data-wise.github.io/claude-r-dev/)

- **[Getting Started](https://data-wise.github.io/claude-r-dev/getting-started/)** - Installation and first steps
- **[Profiles Guide](https://data-wise.github.io/claude-r-dev/profiles/)** - Available profiles and features
- **[Customization](https://data-wise.github.io/claude-r-dev/customization-guide/)** - Wizard and manual customization
- **[Commands Reference](https://data-wise.github.io/claude-r-dev/commands-reference/)** - All commands and agents
- **[Config Schema](https://data-wise.github.io/claude-r-dev/config-schema/)** - Configuration file reference
- **[Contributing](https://data-wise.github.io/claude-r-dev/contributing/)** - How to contribute
- **[Tutorials](https://data-wise.github.io/claude-r-dev/tutorials/)** - Step-by-step guides
- **[Examples](examples/)** - Example configurations
- **[Changelog](CHANGELOG.md)** - Version history

## 🏗️ Architecture

### Profile System

```
base/                   # Core R package standards (required)
├── CLAUDE.md          # Main configuration
├── settings.json      # Tool permissions
├── commands/          # Slash commands
└── agents/            # Sub-agents

statistical-methods/    # Extends base for methodology
├── CLAUDE.md          # Additional standards
├── commands/          # Methods-specific commands
└── agents/            # Enhanced reviewers
```

### Installation Process

1. Validates target is R package (checks for DESCRIPTION)
2. Backs up existing configuration
3. Installs base profile
4. Merges additional profiles
5. Updates .gitignore
6. Generates installation report

## 🔧 Requirements

### Essential

- **Claude Code CLI**: `npm install -g @anthropic-ai/claude-code`
- **R** (≥ 4.0.0): With development tools
- **Git**: For version control

### R Packages (installed automatically on first use)

```r
install.packages(c(
  "devtools", "testthat", "roxygen2",
  "styler", "lintr", "covr", "pkgdown",
  "goodpractice", "spelling", "usethis"
))
```

For statistical-methods profile:

```r
install.packages("S7")  # Modern object system
```

## 🤝 Contributing

We welcome contributions! Ways to help:

- **Add new profiles**: Create configurations for new package types
- **Improve existing profiles**: Enhance standards and workflows
- **Submit slash commands**: Share useful workflow automations
- **Create sub-agents**: Build specialized AI assistants
- **Improve documentation**: Clarify usage and examples
- **Report issues**: Help us identify problems
- **Share feedback**: Tell us what works and what doesn't

See [CONTRIBUTING.md](CONTRIBUTING.md) for details.

## 📊 Real-World Examples

### mediationverse

Statistical methods package for causal mediation analysis using claude-r-dev:

- **Profiles**: `base` + `statistical-methods`
- **Result**: 50% faster feature development, 100% test coverage

### [Your Package Here]

Successfully using claude-r-dev? Submit a PR to share your story!

## 🎓 Learning Resources

- [Claude Code Documentation](https://claude.ai/code)
- [Claude Code Best Practices](https://www.anthropic.com/engineering/claude-code-best-practices)
- [R Packages Book](https://r-pkgs.org/)
- [Tidyverse Style Guide](https://style.tidyverse.org/)

## 🗺️ Roadmap

### v1.0 (Current)

- ✅ Base profile with core R package development
- ✅ Statistical-methods profile for methodology packages
- ✅ Smart installer with profile merging
- ✅ Comprehensive documentation

### v1.1 (Next)

- ⬜ Data-analysis profile
- ⬜ Shiny profile
- ⬜ Bioconductor profile
- ⬜ Profile update system
- ⬜ Community profile registry

### v1.2 (Future)

- ⬜ Web-based profile builder
- ⬜ VS Code extension integration
- ⬜ GitHub Actions workflow templates
- ⬜ Team collaboration features

## ❓ FAQ

**Q: Do I need Claude Pro to use this?**  
A: No, Claude Code works with any Claude account. Pro provides extended thinking, but is not required.

**Q: Can I use this with Cursor or other AI coding tools?**  
A: The configuration is optimized for Claude Code, but many patterns can be adapted.

**Q: Will this work with my existing package?**  
A: Yes! The installer checks for existing configurations and merges intelligently.

**Q: Can I customize the profiles?**  
A: Absolutely! See [Customization Guide](https://data-wise.github.io/claude-r-dev/customization-guide/) for details.

**Q: How do I update to the latest version?**  
A: Run `./scripts/update.sh` in your package, or reinstall with the latest version.

**Q: Is this only for R packages?**  
A: Currently yes, but the architecture could support other languages. Contributions welcome!

## 📝 License

MIT License - see [LICENSE](LICENSE) for details.

## 🙏 Acknowledgments

- **Anthropic** - For Claude Code and best practices documentation
- **R Core Team** - For R and package development infrastructure
- **Hadley Wickham** - For R package development standards and tidyverse
- **Contributors** - Everyone who improves and extends claude-r-dev

## 📬 Contact & Support

- **Issues**: [GitHub Issues](https://github.com/Data-Wise/claude-r-dev/issues)
- **Discussions**: [GitHub Discussions](https://github.com/Data-Wise/claude-r-dev/discussions)

---

**Transform your R package development from ad-hoc to systematic, from uncertain to rigorous, from solo to AI-collaborative.**

**Install. Configure. Excel.** 🚀

---

<p align="center">
  Made with ❤️ for the R community
</p>
