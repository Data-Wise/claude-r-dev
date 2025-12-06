# MkDocs Usage Tutorial

A quick guide on using MkDocs with Material theme for the claude-r-dev documentation.

## Installation

```bash
# Install MkDocs and Material theme
pip install mkdocs-material mkdocs-minify-plugin
```

## Local Development

### Preview the site locally

```bash
# From the project root directory
mkdocs serve

# The site will be available at http://127.0.0.1:8000
```

### Build the site

```bash
mkdocs build
# Output goes to ./site/ directory
```

## Project Structure

```
claude-r-dev/
├── mkdocs.yml              # Configuration file
├── docs_mkdocs/            # Documentation source
│   ├── index.md            # Homepage
│   ├── getting-started.md
│   ├── commands-reference.md
│   ├── profiles.md
│   ├── config-schema.md
│   ├── customization-guide.md
│   └── tutorials/
│       ├── index.md
│       ├── r-package.md
│       ├── mediation.md
│       ├── causal.md
│       └── survival.md
└── .github/workflows/
    └── mkdocs.yml          # GitHub Actions deployment
```

## Configuration (mkdocs.yml)

Key sections:

### Site metadata

```yaml
site_name: claude-r-dev
site_url: https://data-wise.github.io/claude-r-dev/
docs_dir: docs_mkdocs
```

### Theme settings

```yaml
theme:
  name: material
  palette:
    - scheme: slate           # Dark mode
      primary: indigo
      toggle:
        icon: material/brightness-4
    - scheme: default         # Light mode
      primary: indigo
      toggle:
        icon: material/brightness-7
  features:
    - navigation.tabs         # Top tabs
    - navigation.sections     # Expandable sections
    - search.suggest          # Search suggestions
    - content.code.copy       # Copy code button
```

### Navigation

```yaml
nav:
  - Home: index.md
  - Getting Started: getting-started.md
  - Tutorials:
    - Overview: tutorials/index.md
    - R Package: tutorials/r-package.md
```

## Writing Content

### Admonitions (callout boxes)

```markdown
!!! note "Title"
    Content here

!!! tip
    Tips appear with a lightbulb icon

!!! warning
    Warnings appear with an exclamation mark

!!! danger
    Danger boxes for critical warnings
```

### Code blocks with copy button

```markdown
​```python
def hello():
    print("Hello, World!")
​```
```

### Tabs

```markdown
=== "Python"
    ​```python
    print("Hello")
    ​```

=== "R"
    ​```r
    print("Hello")
    ​```
```

### Task lists

```markdown
- [x] Completed task
- [ ] Incomplete task
```

### Tables

```markdown
| Column 1 | Column 2 |
|----------|----------|
| Value 1  | Value 2  |
```

### Cards (requires grid feature)

```markdown
<div class="grid cards" markdown>

-   :material-clock:{ .lg .middle } **Card Title**

    ---

    Card description here.

</div>
```

## Deployment

### Automatic (via GitHub Actions)

The `.github/workflows/mkdocs.yml` workflow automatically:

1. Triggers on push to `main` when docs change
2. Installs Python and MkDocs
3. Builds the site
4. Deploys to GitHub Pages

### Manual deployment

```bash
# Deploy directly (requires gh-pages branch)
mkdocs gh-deploy
```

## Customization

### Add custom CSS

Create `docs_mkdocs/stylesheets/extra.css` and add to config:

```yaml
extra_css:
  - stylesheets/extra.css
```

### Add custom JavaScript

```yaml
extra_javascript:
  - javascripts/extra.js
```

### Add social links

```yaml
extra:
  social:
    - icon: fontawesome/brands/github
      link: https://github.com/Data-Wise
    - icon: fontawesome/brands/twitter
      link: https://twitter.com/example
```

## Common Commands

| Command | Description |
|---------|-------------|
| `mkdocs serve` | Start local server with hot reload |
| `mkdocs build` | Build static site to ./site/ |
| `mkdocs gh-deploy` | Build and push to gh-pages branch |
| `mkdocs new [dir]` | Create new MkDocs project |

## Resources

- [MkDocs Documentation](https://www.mkdocs.org/)
- [Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)
- [Material Reference](https://squidfunk.github.io/mkdocs-material/reference/)
