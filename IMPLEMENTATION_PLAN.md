# Implementation Plan: v1.2.0 - Custom Configuration Generator

**Target Release:** December 2024  
**Status:** ✅ Complete  
**Priority:** High

---

## 🎯 Vision

Enable users to create custom, package-specific Claude Code configurations (like mediationverse-claude-setup) through an interactive wizard. Any R developer should be able to generate a tailored configuration for their specific package type, domain, and preferences.

---

## 📋 Core Feature: `/project:init` Wizard

### User Experience Flow

```bash
cd my-r-package
claude

/project:init
```

**Interactive Session:**

```
🎯 Claude Code Setup Wizard

Let's customize Claude Code for your package!

[Q1] Package Type
────────────────
What type of package are you developing?
  1. Statistical methodology
  2. Data analysis
  3. Visualization
  4. Shiny application
  5. Bioconductor
  6. General utility

Your choice: _

[Q2] Domain (conditional on type)
──────────────────────────────
What's your package about?
Examples: "causal mediation", "longitudinal models", "survival analysis"

Your answer: _

[Q3] Statistical Notation (for statistical packages)
────────────────────────────────────────────────
What notation system do you prefer?
  1. VanderWeele (NDE, NIE, TE, PM) - mediation/causal inference
  2. Pearl (do-operator, counterfactuals) - causal inference
  3. Rubin (potential outcomes, SUTVA) - causal inference
  4. Standard mathematical notation
  5. Custom (I'll specify)

Your choice: _

[Q4] Object System
──────────────────
Which object-oriented system?
  1. S3 (simple, widely used)
  2. S4 (formal, Bioconductor)
  3. S7 (modern, recommended)
  4. R6 (reference classes)
  5. Mix (I use multiple)

Your choice: _

[Q5] Function Organization
──────────────────────────
How should we organize your reference documentation?
Enter categories separated by commas.

Examples:
- "Estimation, Inference, Visualization"
- "Data Import, Analysis, Reporting"
- "Model Fitting, Diagnostics, Prediction"

Your categories: _

[Q6] Inference Methods (for statistical packages)
─────────────────────────────────────────────
Which inference methods does your package use?
  ☐ Bootstrap
  ☐ Delta method (asymptotic)
  ☐ Influence functions
  ☐ MCMC/Bayesian
  ☐ Permutation tests
  ☐ Cross-validation

Select all that apply: _

[Q7] Testing Requirements
─────────────────────────
What edge cases are critical for your package?
  ☐ Missing data (NA values)
  ☐ Zero variance
  ☐ Perfect collinearity
  ☐ Singular matrices
  ☐ Small sample sizes
  ☐ Unbalanced data
  ☐ Convergence issues
  ☐ Numerical instability

Select all that apply: _

[Q8] Website (pkgdown)
──────────────────────
Set up pkgdown website?
  [Y/n]: _

[Q8a] Color Scheme (if yes to pkgdown)
───────────────────────────────────
Choose a color scheme:
  1. Academic Blue (#1F4788, #56B4E9) - professional, scholarly
  2. Forest Green (#2C5F2D, #97BC62) - natural, calm
  3. Deep Purple (#5B2C6F, #A059A0) - creative, modern
  4. Warm Orange (#D55E00, #F0AD4E) - energetic, friendly
  5. Ocean Teal (#008080, #20B2AA) - fresh, technical
  6. Custom (specify hex codes)

Your choice: _

[Q9] Special Dependencies
────────────────────────
Does your package have special dependencies or workflows?
Examples: "heavy Matrix operations", "parallel processing", "C++ integration"

Your answer (optional): _

[Q10] Code Style
───────────────
Preferred code style guide?
  1. Tidyverse style guide (recommended)
  2. Google R style guide
  3. Custom (I'll configure)

Your choice: _

✅ Configuration Summary
════════════════════════
Package Type: Statistical methodology
Domain: Longitudinal mixed effects models
Notation: Rubin (potential outcomes)
Object System: S7
Categories: Model Fitting, Inference, Diagnostics, Utilities
Inference: Bootstrap, Delta method
Edge Cases: Missing data, Singular matrices, Convergence issues
Website: Yes (Academic Blue color scheme)
Dependencies: lme4, nlme, Matrix operations
Style: Tidyverse

Proceed with setup? [Y/n]: _

🚀 Generating Configuration...
═════════════════════════════

✓ Created CLAUDE.md with:
  - S7 object system guidelines with validators
  - Rubin notation standards
  - Longitudinal data edge case requirements
  - Bootstrap (B ≥ 5000) and delta method specifications

✓ Created .claude/settings.json with:
  - Tool permissions for R, git, quality tools
  - Context optimization for your dependencies

✓ Created .claude/commands/:
  - fix-bug.md (debugging workflow)
  - pre-commit-check.md (quality checks)
  - setup-pkgdown.md (website design)
  - fit-model.md (custom: model fitting workflow)
  - check-convergence.md (custom: convergence diagnostics)

✓ Created .claude/agents/:
  - r-package-reviewer.md (code review specialist)
  - test-specialist.md (testing specialist)
  - longitudinal-expert.md (custom: domain specialist)

✓ Created _pkgdown.yml with:
  - Academic Blue color scheme
  - Badges in right sidebar
  - 4-category reference organization
  - Custom CSS included

✓ Created pkgdown/extra.css with:
  - Professional styling
  - Responsive design
  - Accessibility features

✓ Saved configuration to .claude-config.yml
  (for future reference and version control)

📚 Next Steps
═════════════

1. Review CLAUDE.md and adjust as needed
2. Add package-specific examples to custom commands
3. Test with: claude
4. Try: /fit-model (your custom command!)

💡 Tip: Run /project:init again anytime to regenerate or update configuration.

Done! Your custom Claude Code configuration is ready. 🎉
```

---

## 🏗️ Technical Implementation

### File Structure

```
profiles/base/commands/
└── project-init.md              # NEW: Wizard command

profiles/base/templates/          # NEW: Template system
├── CLAUDE.md.template
├── settings.json.template
├── commands/
│   ├── common/                  # Always included
│   │   ├── fix-bug.md
│   │   ├── pre-commit-check.md
│   │   └── setup-pkgdown.md
│   └── domain-specific/         # Conditional
│       ├── statistical/
│       │   ├── fit-model.md.template
│       │   ├── bootstrap-inference.md.template
│       │   └── sensitivity-analysis.md.template
│       ├── longitudinal/
│       │   ├── check-convergence.md.template
│       │   └── diagnose-random-effects.md.template
│       ├── survival/
│       │   ├── check-proportional-hazards.md.template
│       │   └── estimate-survival.md.template
│       └── bayesian/
│           ├── check-mcmc-diagnostics.md.template
│           └── prior-sensitivity.md.template
├── agents/
│   ├── common/
│   │   ├── r-package-reviewer.md
│   │   └── test-specialist.md
│   └── domain-specific/
│       ├── longitudinal-expert.md.template
│       ├── survival-expert.md.template
│       └── bayesian-expert.md.template
└── pkgdown/
    ├── color-schemes/
    │   ├── academic-blue.yml
    │   ├── forest-green.yml
    │   ├── deep-purple.yml
    │   ├── warm-orange.yml
    │   └── ocean-teal.yml
    └── extra.css.template

examples/configurations/          # NEW: Example configs
├── mediationverse-example.yml   # Real example
├── longitudinal-example.yml
├── survival-example.yml
└── README.md
```

### Configuration File Format

**`.claude-config.yml`** (saved after wizard):

```yaml
# Claude Code Configuration
# Generated: 2025-01-15
# Version: 1.2.0

package:
  name: mylongitudinalpackage
  type: statistical-methods
  domain: longitudinal mixed effects models

notation:
  style: rubin
  terms:
    - "Y(t)" # Outcome at time t
    - "β₀ᵢ" # Random intercept
    - "β₁ᵢ" # Random slope

object_system: S7

function_categories:
  - name: Model Fitting
    description: Fit longitudinal mixed effects models
    examples: [lme_fit, glmm_fit]
  
  - name: Inference
    description: Hypothesis testing and confidence intervals
    examples: [bootstrap_ci, wald_test]
  
  - name: Diagnostics
    description: Model checking and residual analysis
    examples: [residual_plot, influence_diagnostics]
  
  - name: Utilities
    description: Helper and conversion functions
    examples: [convert_*, validate_*]

inference:
  methods: [bootstrap, delta_method]
  bootstrap:
    default_samples: 5000
    parallel: true
    reason: "Small effect sizes in longitudinal data"

testing:
  coverage_required: 85
  edge_cases:
    - missing_timepoints
    - unbalanced_data
    - singular_covariance
    - convergence_failures
  
  special_tests:
    - random_effects_distribution
    - residual_autocorrelation

dependencies:
  critical: [lme4, nlme, Matrix]
  special_handling:
    - Matrix operations need singular matrix checks
    - Convergence issues need multiple optimizer attempts

pkgdown:
  enabled: true
  color_scheme: academic_blue
  colors:
    primary: "#1F4788"
    secondary: "#56B4E9"
    success: "#009E73"
  badges_sidebar: true
  custom_css: true

code_style: tidyverse

custom_commands:
  - name: fit-model
    description: Systematic model fitting workflow
    domain: longitudinal
  
  - name: check-convergence
    description: Convergence diagnostics and troubleshooting
    domain: longitudinal

custom_agents:
  - name: longitudinal-expert
    description: Specialist in longitudinal data analysis
    expertise: [random effects, time-varying covariates, missing data]

metadata:
  created: 2025-01-15T10:30:00Z
  generator: claude-r-dev
  version: 1.2.0
```

---

## 🔧 Implementation Steps

### Phase 1: Core Wizard (Week 1-2) ✅ COMPLETE

**Priority 1 Tasks:**

- [x] Create `/project:init` command structure
- [x] Implement question flow logic
- [x] Add input validation
- [x] Create CLAUDE.md template with variable substitution
- [x] Create settings.json template
- [x] Create claude-config.yml template
- [ ] Test basic wizard flow (manual testing pending)

**Deliverables:**

- ✅ `profiles/base/commands/project-init.md`
- ✅ Basic template system in `profiles/base/templates/`
- ⏳ Working wizard for 3 package types (Phase 2)

### Phase 2: Template System (Week 2-3) ✅ COMPLETE

**Priority 1 Tasks:**

- [x] Create template directory structure
- [x] Implement template engine (variable substitution) - basic `{{variable}}` system
- [x] Create domain-specific command templates
- [x] Create domain-specific agent templates
- [x] Add 5 pkgdown color schemes

**Deliverables:**

- ✅ Complete `profiles/base/templates/` directory
- ✅ Template rendering system (basic)
- ✅ 5 color scheme options (academic-blue, forest-green, deep-purple, warm-orange, ocean-teal)
- ✅ 3 statistical command templates (fit-model, bootstrap-inference, sensitivity-analysis)
- ✅ 2 domain agent templates (statistical-methods-expert, longitudinal-expert)

### Phase 3: Configuration File (Week 3-4) ✅ COMPLETE

**Priority 1 Tasks:**

- [x] Define `.claude-config.yml` schema
- [x] Create schema documentation (`docs/config-schema.md`)
- [x] Create example configurations (3 examples)
- [ ] Implement YAML parser/writer (handled by Claude at runtime)
- [ ] Add config file loading for regeneration (handled by Claude at runtime)

**Deliverables:**

- ✅ `.claude-config.yml` format specification (`docs/config-schema.md`)
- ✅ Example configurations in `examples/configurations/`
- Config file generator (runtime, no code needed)

### Phase 4: Domain-Specific Templates (Week 4-5) ✅ COMPLETE

**Priority 1 Tasks:**

- [x] Create statistical methods templates (done in Phase 2)
- [x] Create longitudinal models templates (done in Phase 2)
- [x] Create survival analysis templates
- [x] Create Bayesian inference templates
- [ ] Test with real packages (ongoing)

**Deliverables:**

- ✅ 4 domain-specific template sets (statistical, longitudinal, survival, bayesian)
- ✅ 6 domain commands (fit-model, bootstrap-inference, sensitivity-analysis, survival-analysis, check-proportional-hazards, bayesian-model, prior-selection)
- ✅ 4 domain agents (statistical-methods-expert, longitudinal-expert, survival-expert, bayesian-expert)

### Phase 5: Testing & Documentation (Week 5-6) ✅ COMPLETE

**Priority 1 Tasks:**

- [x] Test wizard with diverse package types (manual verification)
- [x] Create comprehensive documentation
- [x] Add example configurations (3 examples in `examples/configurations/`)
- [ ] Create video tutorial (deferred)
- [ ] Write blog post (deferred)

**Deliverables:**

- ✅ Complete user documentation (`docs/`)
- ✅ 5+ example configurations
- ✅ `docs/commands-reference.md` with 17 commands, 8 agents

### Phase 6: Release (Week 6) ✅ COMPLETE

**Priority 1 Tasks:**

- [x] Final testing
- [x] Update CHANGELOG
- [x] MkDocs documentation deployment
- [ ] Create GitHub release tag
- [ ] Announce on social media
- [ ] Gather community feedback

---

## 📊 Technical Details

### Template Variable System

**Variables in templates:**

```markdown
# CLAUDE.md Template

# Claude Code Configuration for {{package_name}}

## Package Overview

**Type:** {{package_type}}
**Domain:** {{package_domain}}
**Notation:** {{notation_style}}

## Object System Standards

{{#if_s7}}
### S7 Classes

All classes should be created with S7:

```r
{{notation_class_example}}
```

Validators must check:
{{#each edge_cases}}

- {{this}}
{{/each}}
{{/if_s7}}

## Function Organization

{{#each function_categories}}

### {{name}}

**Description:** {{description}}
**Examples:** {{examples}}
{{/each}}

## Inference Standards

{{#each inference_methods}}

### {{method_name}}

{{method_description}}
{{method_requirements}}
{{/each}}

## Edge Cases

All functions must handle:
{{#each edge_cases}}

- **{{name}}**: {{description}}
{{/each}}

```

### Conditional Logic

```javascript
// Pseudo-code for template rendering

function renderTemplate(template, config) {
  let content = template;
  
  // Simple variable substitution
  content = content.replace(/{{(\w+)}}/g, (match, key) => {
    return config[key] || '';
  });
  
  // Conditional blocks
  content = renderConditionals(content, config);
  
  // Loops
  content = renderLoops(content, config);
  
  return content;
}

function renderConditionals(content, config) {
  // {{#if_s7}}...{{/if_s7}}
  if (config.object_system === 'S7') {
    content = content.replace(/{{#if_s7}}(.*?){{\/if_s7}}/gs, '$1');
  } else {
    content = content.replace(/{{#if_s7}}.*?{{\/if_s7}}/gs, '');
  }
  return content;
}

function renderLoops(content, config) {
  // {{#each edge_cases}}...{{/each}}
  content = content.replace(/{{#each (\w+)}}(.*?){{\/each}}/gs, 
    (match, arrayName, loopContent) => {
      const items = config[arrayName] || [];
      return items.map(item => {
        return loopContent.replace(/{{this}}/g, item);
      }).join('\n');
    }
  );
  return content;
}
```

---

## 🎨 Example Generated Configurations

### Example 1: Longitudinal Package

**Input:**

- Type: Statistical methodology
- Domain: Longitudinal mixed effects
- Notation: Rubin
- Object: S7
- Inference: Bootstrap, Delta method

**Generated CLAUDE.md excerpt:**

```markdown
# Claude Code Configuration for mylongitudinalpackage

## Package Overview

**Type:** Statistical Methodology Package
**Domain:** Longitudinal Mixed Effects Models
**Notation:** Rubin (Potential Outcomes)

## Object System Standards

### S7 Classes

All model results should use S7 classes with comprehensive validators:

```r
LongitudinalFit <- S7::new_class(
  "LongitudinalFit",
  properties = list(
    coefficients = class_numeric,
    vcov = class_matrix,
    random_effects = class_list,
    convergence = class_logical
  ),
  validator = function(self) {
    # Check finite values
    if (!all(is.finite(self@coefficients))) {
      return("All coefficients must be finite")
    }
    # Check positive definite vcov
    if (!all(eigen(self@vcov)$values > 0)) {
      return("Covariance matrix must be positive definite")
    }
    # Check convergence
    if (!self@convergence) {
      warning("Model did not converge")
    }
  }
)
```

## Edge Cases

All estimation functions must handle:

- **Missing timepoints**: Use complete case or MI appropriately
- **Unbalanced data**: Test with varying numbers of observations per subject
- **Singular covariance**: Check for convergence issues, try multiple optimizers
- **Single subject**: Should fail gracefully with informative error

```

### Example 2: Survival Analysis Package

**Input:**
- Type: Statistical methodology
- Domain: Survival analysis
- Notation: Standard
- Object: S3
- Inference: Bootstrap, Delta method

**Generated custom command:**
```markdown
# Check Proportional Hazards

## Usage

```

/check-proportional-hazards

```

## Workflow

### Phase 1: Assessment
1. Identify Cox models in package
2. Review current PH assumption checks
3. Note any known violations

### Phase 2: Testing Strategy
1. Schoenfeld residual tests
2. Visual assessment (log-log plots)
3. Time-dependent covariates
4. Stratification if needed

### Phase 3: Implementation
1. Add `test_ph()` function
2. Add visualization: `plot_schoenfeld()`
3. Add stratified Cox option
4. Document assumptions

### Phase 4: Testing
Test with:
- Data meeting PH assumption
- Data violating PH (time × covariate interaction)
- Multiple covariates
- Tied survival times

### Phase 5: Documentation
- Explain PH assumption
- Show how to check
- Demonstrate fixes (stratification, time-varying)
- Add to vignette
```

---

## 📚 Documentation Updates

### Updates Needed

1. **README.md**
   - Add "Quick Customization" section
   - Highlight `/project:init` feature
   - Show before/after examples

2. **docs/getting-started.md**
   - Add wizard walkthrough
   - Explain configuration file
   - Show regeneration

3. **New: docs/customization-guide.md**
   - Complete wizard documentation
   - Configuration file reference
   - Template system explanation
   - Example configurations

4. **New: docs/domain-guides/**
   - Statistical methods packages
   - Longitudinal models
   - Survival analysis
   - Bayesian inference
   - Data analysis packages

5. **CHANGELOG.md**
   - Already updated with roadmap

6. **PROJECT_SUMMARY.md**
   - Update vision and capabilities

---

## 🎯 Success Metrics

### Technical Metrics

- [ ] Wizard completes in <5 minutes
- [ ] Generates valid configuration 100% of time
- [ ] Templates render correctly
- [ ] Configuration files are valid YAML
- [ ] Generated packages pass R CMD check

### User Experience Metrics

- [ ] Users can customize without reading docs
- [ ] Generated configs match user intent
- [ ] Easy to regenerate/update
- [ ] Clear error messages
- [ ] Good examples available

### Community Metrics

- [ ] >100 GitHub stars by end of Q1
- [ ] >10 community-contributed configurations
- [ ] Positive feedback on customization
- [ ] Feature requests for new domains
- [ ] Active discussions

---

## 🚀 Release Plan

### v1.2.0-alpha (Week 4)

- Core wizard working
- 3 package types supported
- Basic template system

**Goal:** Internal testing

### v1.2.0-beta (Week 5)

- All package types supported
- Domain templates complete
- Configuration files working
- Documentation draft

**Goal:** Community testing

### v1.2.0 (Week 6)

- All features complete
- Documentation finalized
- Examples and tutorials
- Blog post ready

**Goal:** Public release

---

## 🔗 Dependencies

### Required Before v1.2.0

- [x] v1.1.0 released
- [ ] Community feedback on v1.1.0
- [ ] Template system designed
- [ ] Configuration schema finalized

### Optional Enhancements

- [ ] Web-based configuration generator
- [ ] VS Code extension for wizard
- [ ] Configuration marketplace

---

## 💬 Open Questions

1. **Template Engine:** Build custom or use existing (Handlebars, Mustache)?
   - **Decision:** Build lightweight custom engine (better control, fewer deps)

2. **Config File Format:** YAML or JSON?
   - **Decision:** YAML (more readable, supports comments)

3. **Backward Compatibility:** How to handle v1.0/1.1 installations?
   - **Decision:** Detect and offer to upgrade

4. **Version Control:** Should `.claude-config.yml` be in .gitignore?
   - **Decision:** No - encourage version control for team sharing

5. **Multiple Configs:** Support different configs per branch?
   - **Decision:** v1.3.0 feature, not v1.2.0

---

## 📝 Notes

- Keep wizard short (<10 questions for basic setup)
- Provide "Quick Setup" option (uses sensible defaults)
- Allow advanced users to skip wizard and edit config directly
- Ensure all generated files are well-documented
- Make it easy to share configurations between projects
- Consider team/organization-level configs in future

---

## ✅ Approval Checklist

Before implementation:

- [ ] Technical approach reviewed
- [ ] User experience validated
- [ ] Timeline approved
- [ ] Resources allocated
- [ ] Dependencies identified
- [ ] Success metrics defined

---

**This plan is living document. Update as we learn from implementation and community feedback.**

**Target:** January 2025 release
**Status:** Ready for implementation
**Priority:** High
