# Contributing to claude-r-dev

Thank you for your interest in contributing to claude-r-dev! This document provides guidelines for contributing.

## Ways to Contribute

- **Add new profiles**: Create configurations for new package types (e.g., Shiny, Bioconductor)
- **Improve existing profiles**: Enhance standards and workflows
- **Submit slash commands**: Share useful workflow automations
- **Create sub-agents**: Build specialized AI assistants
- **Improve documentation**: Clarify usage and examples
- **Report issues**: Help us identify problems
- **Share feedback**: Tell us what works and what doesn't

## Getting Started

1. Fork the repository
2. Clone your fork:

    ```bash
    git clone https://github.com/YOUR-USERNAME/claude-r-dev.git
    ```

3. Create a feature branch:

    ```bash
    git checkout -b feature/your-feature-name
    ```

## Profile Structure

When creating a new profile, follow this structure:

```
profiles/your-profile/
├── CLAUDE.md          # Main configuration
├── settings.json      # Tool permissions (optional)
├── commands/          # Slash commands (optional)
│   └── command-name.md
└── agents/            # Sub-agents (optional)
    └── agent-name.md
```

### CLAUDE.md Format

```markdown
# Profile Name

Brief description of what this profile provides.

## Standards
- List of standards this profile enforces

## Workflows
- Workflows specific to this profile

## Best Practices
- Domain-specific best practices
```

### Slash Command Format

Commands should be markdown files with clear step-by-step instructions:

```markdown
# Command Name

Brief description.

## Steps
1. Step one
2. Step two
...
```

### Sub-Agent Format

Sub-agents should define:

- Role and expertise
- Specific tasks they handle
- Output format expectations

## Submitting Changes

1. Ensure your changes follow the existing patterns
2. Test your profile with an actual R package
3. Update documentation if needed
4. Submit a pull request with:
    - Clear title describing the change
    - Description of what/why
    - Any testing you've done

## Development Workflow

### Testing Locally

```bash
# Test installation on a package
./scripts/install.sh --profiles base --target ~/test-package --dry-run

# Actually install
./scripts/install.sh --profiles base --target ~/test-package
```

### Documentation

We use MkDocs with Material theme for documentation. To preview locally:

```bash
# Install MkDocs
pip install mkdocs-material mkdocs-minify-plugin

# Serve locally
mkdocs serve

# Build site
mkdocs build
```

### Commit Messages

Follow conventional commits format:

```
type(scope): description

feat(profiles): add Shiny application profile
fix(installer): handle spaces in paths
docs(readme): update installation instructions
```

## Code of Conduct

- Be respectful and inclusive
- Focus on constructive feedback
- Help others learn and grow

## Questions?

- **Issues**: [GitHub Issues](https://github.com/Data-Wise/claude-r-dev/issues)
- **Discussions**: [GitHub Discussions](https://github.com/Data-Wise/claude-r-dev/discussions)
