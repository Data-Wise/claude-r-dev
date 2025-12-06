# Configuration Schema Reference

The `.claude-config.yml` file stores your wizard configuration for regeneration.

## Schema

```yaml
# Package Information
package:
  name: string                    # Package name from DESCRIPTION
  type: enum                      # statistical-methods | data-analysis | visualization | shiny | bioconductor | general
  domain: string                  # Free-text domain description

# Notation System
notation:
  style: enum                     # vanderweele | pearl | rubin | standard | custom
  custom_terms: list[string]      # Optional custom notation (if style=custom)

# Object System
object_system: enum               # s3 | s4 | s7 | r6 | mixed

# Function Categories (for pkgdown reference)
function_categories:
  - name: string                  # Category title
    description: string           # Category description
    patterns: list[string]        # Function name patterns (e.g., "estimate_*")

# Inference Methods
inference:
  methods: list[enum]             # bootstrap | delta_method | influence_functions | mcmc | permutation | cv
  bootstrap:
    default_samples: integer      # Default B (minimum 1000)
    parallel: boolean             # Use parallel processing

# Testing Requirements
testing:
  coverage_required: integer      # Minimum coverage % (default 80)
  edge_cases: list[enum]          # missing_data | zero_variance | collinearity | singular | small_n | unbalanced | convergence | numerical

# Website (pkgdown)
pkgdown:
  enabled: boolean                # Whether to set up pkgdown
  color_scheme: enum              # academic_blue | forest_green | deep_purple | warm_orange | ocean_teal | custom
  colors:                         # Custom colors (if color_scheme=custom)
    primary: string               # Hex color
    secondary: string             # Hex color
  badges_sidebar: boolean         # Place badges in sidebar

# Code Style
code_style: enum                  # tidyverse | google | custom

# Special Dependencies
dependencies:
  critical: list[string]          # Critical package dependencies
  special_handling: string        # Notes about special requirements

# Metadata (auto-generated)
metadata:
  created: datetime               # ISO 8601 timestamp
  updated: datetime               # Last modified
  generator: string               # Always "claude-r-dev"
  version: string                 # Generator version
```

## Enum Values

### package.type

- `statistical-methods` - Estimators, inference, causal analysis
- `data-analysis` - tidyverse-style data manipulation
- `visualization` - ggplot2 extensions, plotting
- `shiny` - Interactive applications
- `bioconductor` - Genomics/bioinformatics
- `general` - Utility packages

### notation.style

- `vanderweele` - NDE, NIE, TE, PM (mediation)
- `pearl` - do-operator, counterfactuals
- `rubin` - Potential outcomes, SUTVA
- `standard` - Generic mathematical notation
- `custom` - User-defined

### object_system

- `s3` - Simple, flexible
- `s4` - Formal, Bioconductor
- `s7` - Modern, type-safe (recommended)
- `r6` - Reference classes
- `mixed` - Multiple systems

### inference.methods

- `bootstrap` - Resampling-based
- `delta_method` - Asymptotic/analytical
- `influence_functions` - Semiparametric
- `mcmc` - Bayesian
- `permutation` - Permutation tests
- `cv` - Cross-validation

### testing.edge_cases

- `missing_data` - NA handling
- `zero_variance` - Constant variables
- `collinearity` - Perfect correlation
- `singular` - Singular matrices
- `small_n` - Small samples (n < 100)
- `unbalanced` - Unequal group sizes
- `convergence` - Optimization failures
- `numerical` - Numerical instability

### pkgdown.color_scheme

- `academic_blue` - #1F4788, #56B4E9
- `forest_green` - #2C5F2D, #97BC62
- `deep_purple` - #5B2C6F, #A059A0
- `warm_orange` - #D55E00, #F0AD4E
- `ocean_teal` - #008080, #20B2AA
- `custom` - Use `colors.primary`/`colors.secondary`
