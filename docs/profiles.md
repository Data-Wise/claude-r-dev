# Available Profiles

claude-r-dev uses a modular profile system. Combine profiles to match your package needs.

## 🔧 base (Required)

**Essential R package development standards.**

The base profile is required for all installations. It provides universal standards that apply to any R package.

### What's Included

**Standards:**

- CRAN compliance automation
- Testing standards (testthat3, >80% coverage required)
- Code style enforcement (tidyverse)
- Git workflows and conventional commits
- Documentation standards (roxygen2, pkgdown)

**Slash Commands:**

| Command | Description |
|---------|-------------|
| `/project:fix-bug` | Systematic debugging workflow with test-first approach |
| `/project:pre-commit-check` | Comprehensive quality checks (style, tests, coverage, R CMD check) |
| `/project:setup-pkgdown` | Professional website design and configuration |
| `/project:init` | Interactive wizard to customize configuration |

**Sub-Agents:**

| Agent | Description |
|-------|-------------|
| `r-package-reviewer` | Expert code review for CRAN compliance and quality |
| `test-specialist` | Comprehensive test generation with edge cases |

### Usage

```bash
./scripts/install.sh --profile base --target ~/mypackage
```

---

## 📊 statistical-methods

**For statistical methodology and causal inference packages.**

This profile extends base with standards specific to packages implementing new statistical methods, estimators, or causal inference techniques.

### What's Included

**Standards:**

- Statistical notation (VanderWeele, Pearl, Rubin)
- Identification assumptions documentation
- Inference method requirements (bootstrap B ≥ 1000, delta method)
- Sensitivity analysis patterns
- S7 object system guidelines

**Domain Templates:**

| Template | Description |
|----------|-------------|
| `fit-model` | Systematic model fitting workflow |
| `bootstrap-inference` | Bootstrap CI implementation |
| `sensitivity-analysis` | Unmeasured confounding analysis |

**Domain Agents:**

| Agent | Description |
|-------|-------------|
| `statistical-methods-expert` | Reviews statistical correctness and methodology |
| `longitudinal-expert` | Specialist for mixed effects and repeated measures |

### Usage

```bash
./scripts/install.sh --profiles base,statistical-methods --target ~/mypackage
```

### Who Should Use This

- Packages implementing new estimators
- Causal inference methods
- Mediation analysis packages
- Any methodology targeting JASA, Biostatistics, etc.

---

## 📈 data-analysis *(Coming in v1.4)*

For packages focused on data analysis and visualization.

---

## 🌐 shiny *(Coming in v1.4)*

For Shiny application packages.

---

## 🧬 bioconductor *(Coming in v1.4)*

For Bioconductor package development.

---

## Combining Profiles

Profiles are additive. Later profiles extend earlier ones:

```bash
# Base only (general R package)
./scripts/install.sh --profile base --target ~/mypackage

# Base + statistical methods
./scripts/install.sh --profiles base,statistical-methods --target ~/mypackage

# Future: Base + statistical + domain-specific
./scripts/install.sh --profiles base,statistical-methods,longitudinal --target ~/mypackage
```

---

## Profile Files

Each profile contains:

```
profiles/<profile-name>/
├── CLAUDE.md          # Main configuration and standards
├── settings.json      # Tool permissions (optional)
├── commands/          # Slash commands
│   └── command.md
└── agents/            # Sub-agent definitions
    └── agent.md
```

---

## Creating Custom Profiles

See [Customization Guide](customization-guide.md) for creating your own profiles.
