# Initialize Claude Code Configuration

Create a customized Claude Code configuration for your R package.

## Usage

```
/project:init
```

## Interactive Setup Wizard

When you run this command, I will ask you a series of questions to customize Claude Code for your specific package. Answer each question, and I'll generate a tailored configuration.

---

## Question 1: Package Type

**What type of package are you developing?**

1. **Statistical methodology** - New estimators, inference methods, causal analysis
2. **Data analysis** - tidyverse-style data manipulation and visualization
3. **Visualization** - ggplot2 extensions, interactive plots
4. **Shiny application** - Interactive web applications
5. **Bioconductor** - Genomics and bioinformatics
6. **General utility** - Helper functions, tools, wrappers

*Enter your choice (1-6):*

---

## Question 2: Package Domain

**What is your package about?**

Describe your package's focus in a few words.

*Examples:*

- "causal mediation analysis"
- "longitudinal mixed effects models"
- "survival analysis"
- "Bayesian inference"
- "time series forecasting"

*Your answer:*

---

## Question 3: Statistical Notation (for statistical packages)

**What notation system do you prefer?**

1. **VanderWeele** - NDE, NIE, TE, PM (mediation/causal inference)
2. **Pearl** - do-operator, counterfactuals (causal inference)
3. **Rubin** - Potential outcomes, SUTVA (causal inference)
4. **Standard mathematical** - Generic notation
5. **Custom** - You'll specify your own

*Enter your choice (1-5):*

---

## Question 4: Object System

**Which object-oriented system will you use?**

1. **S3** - Simple, widely used, flexible
2. **S4** - Formal, Bioconductor standard
3. **S7** - Modern, type-safe, recommended for new packages
4. **R6** - Reference classes, mutable objects
5. **Mix** - You use multiple systems

*Enter your choice (1-5):*

---

## Question 5: Function Categories

**How should we organize your reference documentation?**

Enter categories separated by commas.

*Examples:*

- "Estimation, Inference, Visualization"
- "Data Import, Analysis, Reporting"
- "Model Fitting, Diagnostics, Prediction"

*Your categories:*

---

## Question 6: Inference Methods (for statistical packages)

**Which inference methods does your package use?**

Select all that apply (enter numbers separated by commas):

1. Bootstrap
2. Delta method (asymptotic)
3. Influence functions
4. MCMC/Bayesian
5. Permutation tests
6. Cross-validation

*Your selections:*

---

## Question 7: Critical Edge Cases

**What edge cases are critical for your package?**

Select all that apply (enter numbers separated by commas):

1. Missing data (NA values)
2. Zero variance
3. Perfect collinearity
4. Singular matrices
5. Small sample sizes (n < 100)
6. Unbalanced data
7. Convergence issues
8. Numerical instability

*Your selections:*

---

## Question 8: Website (pkgdown)

**Would you like to set up a pkgdown website?**

Enter Y or N:

---

## Question 8a: Color Scheme (if yes to Q8)

**Choose a color scheme:**

1. **Academic Blue** - #1F4788, #56B4E9 (professional, scholarly)
2. **Forest Green** - #2C5F2D, #97BC62 (natural, calm)
3. **Deep Purple** - #5B2C6F, #A059A0 (creative, modern)
4. **Warm Orange** - #D55E00, #F0AD4E (energetic, friendly)
5. **Ocean Teal** - #008080, #20B2AA (fresh, technical)
6. **Custom** - You'll specify hex codes

*Enter your choice (1-6):*

---

## Question 9: Special Dependencies

**Does your package have special dependencies or workflows?**

*Examples:*

- "Heavy Matrix operations"
- "Parallel processing with future"
- "C++ integration via Rcpp"
- "External API calls"

*Your answer (or leave blank):*

---

## Question 10: Code Style

**Preferred code style guide?**

1. **Tidyverse style guide** - Recommended
2. **Google R style guide**
3. **Custom** - You'll configure

*Enter your choice (1-3):*

---

## Configuration Summary

After collecting your answers, I will display a summary like:

```
✅ Configuration Summary
════════════════════════
Package Type: Statistical methodology
Domain: Causal mediation analysis
Notation: VanderWeele (NDE, NIE, TE, PM)
Object System: S7
Categories: Estimation, Inference, Sensitivity Analysis
Inference: Bootstrap (B ≥ 1000), Delta method
Edge Cases: Missing data, Singular matrices
Website: Yes (Academic Blue)
Dependencies: None specified
Style: Tidyverse

Proceed with setup? [Y/n]:
```

---

## File Generation

Upon confirmation, I will create the following files:

### 1. `.claude/CLAUDE.md`

Main configuration file with:

- Package-specific standards
- Object system guidelines (S3/S4/S7)
- Notation conventions
- Edge case requirements
- Inference method specifications

### 2. `.claude/settings.json`

Tool permissions for:

- R development commands
- Git operations
- Code quality tools

### 3. `.claude-config.yml`

Saved configuration for:

- Future regeneration
- Version control
- Team sharing

### 4. `_pkgdown.yml` (if website enabled)

Website configuration with:

- Chosen color scheme
- Badge placement in sidebar
- Reference organized by your categories

### 5. `pkgdown/extra.css` (if website enabled)

Custom styling for professional appearance.

---

## Next Steps

After generation:

1. **Review** `CLAUDE.md` and adjust as needed
2. **Test** by running `claude` in your package directory
3. **Try** your new configuration with a simple task
4. **Regenerate** anytime by running `/project:init` again

---

## Notes

- All generated files can be edited manually
- Configuration is saved to `.claude-config.yml` for future reference
- Run this command again to regenerate or update
- Generated files follow CRAN compliance standards
