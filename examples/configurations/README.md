# Example Configurations

This directory contains example `.claude-config.yml` files for different package types.

## Available Examples

| File | Package Type | Domain |
|------|--------------|--------|
| [mediation-analysis.yml](mediation-analysis.yml) | statistical-methods | Causal mediation |
| [longitudinal-models.yml](longitudinal-models.yml) | statistical-methods | Mixed effects |
| [data-pipeline.yml](data-pipeline.yml) | data-analysis | Data wrangling |

## Usage

Copy an example to your package root:

```bash
cp examples/configurations/mediation-analysis.yml .claude-config.yml
```

Then regenerate configuration:

```bash
cd your-package
claude
/project:init
```

The wizard will detect the existing config and offer to use it.
