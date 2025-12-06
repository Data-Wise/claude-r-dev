# claude-r-dev

**Supercharge your R package development with AI-powered workflows using Claude Code**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![GitHub release](https://img.shields.io/github/release/Data-Wise/claude-r-dev.svg)](https://github.com/Data-Wise/claude-r-dev/releases)
[![GitHub stars](https://img.shields.io/github/stars/Data-Wise/claude-r-dev.svg?style=social)](https://github.com/Data-Wise/claude-r-dev/stargazers)

---

## ✨ Features

<div class="grid cards" markdown>

- :material-wizard-hat:{ .lg .middle } **Configuration Wizard**

    ---

    Interactive `/project:init` command generates custom configurations for your package type.

- :material-chart-line:{ .lg .middle } **17 Domain Commands**

    ---

    Statistical, survival, Bayesian, causal inference, and mediation analysis workflows.

- :material-robot:{ .lg .middle } **8 Expert Agents**

    ---

    Specialized AI assistants for code review, testing, and domain methodology.

- :material-lightning-bolt:{ .lg .middle } **Quality Automation**

    ---

    Built-in CRAN compliance, test coverage, and code style enforcement.

- :material-palette:{ .lg .middle } **pkgdown Themes**

    ---

    5 professional color schemes for your package website.

- :material-package-variant:{ .lg .middle } **One-Line Install**

    ---

    Install directly from GitHub to any R package.

</div>

## 🚀 Quick Start

```bash
# Install to your R package
curl -fsSL https://raw.githubusercontent.com/Data-Wise/claude-r-dev/main/scripts/install.sh | bash -s -- \
  --profile base \
  --target /path/to/your/package

# Then in Claude Code:
cd /path/to/your/package
claude
/project:init
```

## 🎯 Domain Coverage

| Domain | Commands | Expert Agent |
|--------|----------|--------------|
| Statistical Methods | `fit-model`, `bootstrap-inference`, `sensitivity-analysis` | `statistical-methods-expert` |
| Survival Analysis | `survival-analysis`, `check-proportional-hazards` | `survival-expert` |
| Bayesian Inference | `bayesian-model`, `prior-selection` | `bayesian-expert` |
| Causal Inference | `validate-dag`, `propensity-score`, `doubly-robust`, `instrumental-variable` | `causal-inference-expert` |
| Mediation Analysis | `identify-mediation-effects`, `multiple-mediators` | `mediation-expert` |

## 📚 Documentation

- [Getting Started](getting-started.md) - Installation and first steps
- [Commands Reference](commands-reference.md) - All 17 commands and 8 agents
- [Profiles Guide](profiles.md) - Available configurations
- [Tutorials](tutorials/index.md) - Step-by-step guides

## 🤝 Contributing

Contributions are welcome! Please see our [GitHub repository](https://github.com/Data-Wise/claude-r-dev).

## 📄 License

MIT License - see [LICENSE](https://github.com/Data-Wise/claude-r-dev/blob/main/LICENSE) for details.
