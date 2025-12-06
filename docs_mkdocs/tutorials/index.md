# Tutorials

Step-by-step guides for using claude-r-dev with different types of R packages.

## Getting Started

<div class="grid cards" markdown>

- :material-package:{ .lg .middle } **R Package Development**

    ---

    Learn the basics of using claude-r-dev for any R package.

    [:octicons-arrow-right-24: Start Tutorial](r-package.md)

</div>

## Domain-Specific Tutorials

<div class="grid cards" markdown>

- :material-chart-scatter-plot:{ .lg .middle } **Mediation Analysis**

    ---

    VanderWeele notation, NDE/NIE, sensitivity analysis.

    [:octicons-arrow-right-24: Mediation Tutorial](mediation.md)

- :material-link-variant:{ .lg .middle } **Causal Inference**

    ---

    DAGs, propensity scores, AIPW, TMLE.

    [:octicons-arrow-right-24: Causal Tutorial](causal.md)

- :material-clock-outline:{ .lg .middle } **Survival Analysis**

    ---

    Cox models, Kaplan-Meier, competing risks.

    [:octicons-arrow-right-24: Survival Tutorial](survival.md)

</div>

## Quick Reference

| Tutorial | Key Commands | Expert Agent |
|----------|--------------|--------------|
| R Package Development | `/project:init`, `/project:pre-commit-check` | `r-package-reviewer`, `test-specialist` |
| Mediation Analysis | `/project:identify-mediation-effects` | `mediation-expert` |
| Causal Inference | `/project:validate-dag`, `/project:doubly-robust` | `causal-inference-expert` |
| Survival Analysis | `/project:survival-analysis` | `survival-expert` |
