# Customization Guide

Learn how to customize claude-r-dev for your specific package needs.

## Quick Customization: `/project:init` Wizard

The easiest way to customize is using the interactive wizard:

```bash
cd /path/to/your/package
claude

/project:init
```

The wizard asks about:

1. **Package type** (statistical, data analysis, visualization, etc.)
2. **Domain** (mediation, survival, longitudinal, etc.)
3. **Notation** (VanderWeele, Pearl, Rubin, standard)
4. **Object system** (S3, S4, S7, R6)
5. **Function categories** (for reference organization)
6. **Inference methods** (bootstrap, delta method, MCMC)
7. **Critical edge cases** (NA, singular matrices, convergence)
8. **Website** (pkgdown color scheme)
9. **Dependencies** (special handling)
10. **Code style** (tidyverse, Google)

After answering, it generates:

- Custom `CLAUDE.md`
- Tool permissions (`settings.json`)
- Saved configuration (`.claude-config.yml`)
- Website configuration (`_pkgdown.yml`)

---

## Manual Customization

### Editing CLAUDE.md

The main configuration is `.claude/CLAUDE.md`. Edit directly to:

**Add package-specific standards:**

```markdown
## Package-Specific Standards

### Effect Definitions
- NDE: Natural Direct Effect = E[Y(1,M(0)) - Y(0,M(0))]
- NIE: Natural Indirect Effect = E[Y(1,M(1)) - Y(1,M(0))]
```

**Add custom notation:**

```markdown
## Notation

Always use:
- θ for parameters
- β₀ᵢ for random intercepts
- Var(ε) for residual variance
```

**Add project context:**

```markdown
## Project Context

This package implements doubly-robust mediation estimators following:
- Tchetgen Tchetgen (2012)
- VanderWeele (2015)
```

### Using `#` to Add Notes

In Claude Code, press `#` to add persistent notes:

```
# Always run tests after modifying R/mediate.R
# The bootstrap implementation uses parallel::mclapply
# Check convergence manually for complex models
```

These are saved to CLAUDE.md automatically.

---

## Creating Custom Commands

### File Location

`.claude/commands/your-command.md`

### Template

```markdown
# Command Title

Brief description of what this command does.

## Usage

\`\`\`
/project:your-command
\`\`\`

## Workflow

### Phase 1: [Phase Name]
1. Step one
2. Step two

**STOP and confirm before proceeding**

### Phase 2: [Phase Name]
1. Step one
2. Step two

## Quality Checklist

- [ ] Item one
- [ ] Item two
```

### Using Arguments

Use `$ARGUMENTS` to capture user input:

```markdown
# Fix Bug

Debug and fix issue: $ARGUMENTS

## Steps
1. Understand the problem from the description
...
```

Usage: `/project:fix-bug "function fails with NA"`

---

## Creating Custom Agents

### File Location

`.claude/agents/your-agent.md`

### Template

```markdown
---
name: your-agent-name
description: Brief description
tools: read, grep, bash
---

You are an expert in [domain]. Your role is to [purpose].

## Expertise Areas

1. **Area One**
   - Detail
   - Detail

## Review Priorities

### 1. Priority One
- [ ] Checklist item
- [ ] Checklist item

## Common Issues to Flag

### Issue Category
- Issue description
- How to fix

## Review Output Format

### Section One
- [Findings]

### Summary
- Overall assessment
- Top priorities
```

### Using Custom Agents

```
"Use your-agent-name sub-agent to review my code"
```

---

## Modifying Tool Permissions

Edit `.claude/settings.json`:

```json
{
  "permissions": {
    "allow": [
      "Bash(R:*)",
      "Bash(Rscript:*)",
      "Bash(git:*)",
      "Bash(devtools::*)"
    ],
    "deny": []
  }
}
```

Add new tools:

```json
"Bash(quarto:*)",
"Bash(renv::*)"
```

---

## Configuration File (`.claude-config.yml`)

Save your wizard answers for regeneration:

```yaml
package:
  name: "mypackage"
  type: "statistical-methods"
  domain: "mediation analysis"

notation:
  style: "vanderweele"

object_system: "S7"

inference:
  methods: ["bootstrap", "delta_method"]
  bootstrap:
    default_samples: 1000

pkgdown:
  enabled: true
  color_scheme: "academic_blue"
```

Regenerate anytime:

```
/project:init
```

It will detect existing config and offer to update.

---

## Color Schemes

Available pkgdown color schemes:

| Scheme | Primary | Secondary | Style |
|--------|---------|-----------|-------|
| `academic-blue` | #1F4788 | #56B4E9 | Professional, scholarly |
| `forest-green` | #2C5F2D | #97BC62 | Natural, calm |
| `deep-purple` | #5B2C6F | #A059A0 | Creative, modern |
| `warm-orange` | #D55E00 | #F0AD4E | Energetic, friendly |
| `ocean-teal` | #008080 | #20B2AA | Fresh, technical |

Custom colors:

```yaml
pkgdown:
  colors:
    primary: "#YOUR_COLOR"
    secondary: "#YOUR_COLOR"
```

---

## Best Practices

1. **Start with the wizard** - Get a baseline configuration
2. **Add project notes with `#`** - Build context over time
3. **Create domain commands** - Automate repetitive workflows
4. **Share configurations** - Version control `.claude/` directory
5. **Update regularly** - Run `/project:init` after major changes
