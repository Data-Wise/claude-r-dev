# pkgdown Templates for R Packages

This directory contains professionally designed pkgdown configuration templates and custom CSS for R packages.

## Available Templates

### statistical-methods.yml

**Best for:** Statistical methodology packages, biostatistics packages, causal inference packages

**Features:**
- Professional academic design with blue color scheme
- Badges displayed in right sidebar
- Reference organized by: Estimation, Inference, Sensitivity Analysis, Utilities, Visualization, Data
- Article structure for Getting Started, Methodology, Advanced Topics
- Clean navigation with dropdown menus
- Bootstrap 5 with custom theming

**Ideal for packages like:**
- mediationverse, RMediation
- Causal inference packages
- Statistical methodology packages
- Biostatistics tools

### extra.css

**Custom CSS providing:**
- Professional badge styling in sidebar
- Hover effects and transitions
- Responsive design for mobile
- Consistent color scheme
- Accessible focus indicators
- Print-friendly styles
- Table and code block styling

## How to Use

### 1. Copy Template to Your Package

```bash
cp statistical-methods.yml /path/to/yourpackage/_pkgdown.yml
```

### 2. Customize for Your Package

Edit `_pkgdown.yml` and update:

```yaml
# Line 3: Your package URL
url: https://username.github.io/yourpackage/

# Line 29: Your package title and description
title: "yourpackage: Statistical Methods for [Your Topic]"

# Lines 37-42: Your badge URLs
badges:
  - text: |
      [![R-CMD-check](https://github.com/you/pkg/workflows/R-CMD-check/badge.svg)]...

# Lines 62-70: Your navigation items and articles

# Lines 75-125: Your function organization
reference:
  - title: Your Main Functions
    contents:
    - your_function_1
    - your_function_2
```

### 3. Add Custom CSS

```bash
# Create pkgdown directory if it doesn't exist
mkdir -p /path/to/yourpackage/pkgdown

# Copy CSS
cp extra.css /path/to/yourpackage/pkgdown/extra.css
```

### 4. Update Colors (Optional)

In `_pkgdown.yml`, customize the color scheme:

```yaml
template:
  bslib:
    primary: "#1F4788"      # Your primary color
    secondary: "#56B4E9"    # Your secondary color
    success: "#009E73"      # Green for success
```

### 5. Build and Test

```r
# In R
pkgdown::build_site()

# Or from command line
Rscript -e 'pkgdown::build_site()'
```

Then open `docs/index.html` in your browser to preview.

## Development Mode (Stable vs. Development Sites)

The template includes `development: mode: auto` which automatically manages separate documentation for stable and development versions.

### How It Works

**Version Detection:**
- **3-component versions** (e.g., `1.0.0`) → Stable release, builds to `docs/`
- **4-component versions** (e.g., `1.0.0.9000`) → Development, builds to `docs/dev/`

**Visual Indicators:**
- Development site shows version number in red with "in-development" tooltip
- Development site includes `noindex` meta tag (won't appear in Google)
- Users always find stable documentation first

### Best Practices

#### 1. Version Workflow
```bash
# After CRAN release (1.0.0), immediately bump version
usethis::use_dev_version()  # Creates 1.0.0.9000

# This ensures next pkgdown build goes to docs/dev/
pkgdown::build_site()  # Builds to docs/dev/
```

#### 2. Conditional Content
Show different badges/instructions on stable vs. development sites:

**In your README.Rmd:**
```markdown
::: {.pkgdown-release}
<!-- Shows only on stable site -->
Install from CRAN:
[![CRAN status](https://badge.svg)](https://CRAN.R-project.org/package=pkg)
:::

::: {.pkgdown-devel}
<!-- Shows only on development site -->
Install development version from GitHub:
[![R-CMD-check](https://badge.svg)](https://github.com/actions)
:::
```

#### 3. GitHub Actions
The standard pkgdown workflow automatically handles this:
```yaml
# Already configured in usethis::use_pkgdown_github_pages()
# Detects version in DESCRIPTION and builds accordingly
```

#### 4. Updating Stable Site
If you need to fix typos in stable documentation without a new release:
```bash
# Create branch from release tag
git checkout -b docs-update v1.0.0

# Make changes, commit
git commit -m "docs: Fix typo"

# Manually trigger pkgdown workflow
# (via GitHub Actions workflow_dispatch)
```

#### 5. Website Dependencies
Don't add pkgdown to `Suggests` in DESCRIPTION. Use:
```
Config/Needs/website: pkgdown, tidyverse/tidytemplate
```

This keeps website dependencies separate from user dependencies.

## Customization Guide


### Changing Colors

The template uses a professional blue color scheme. To change:

```yaml
template:
  bslib:
    primary: "#YOUR_COLOR"    # Main headers, navbar
    secondary: "#YOUR_COLOR"  # Accents, links
    bg: "#YOUR_COLOR"        # Background
```

**Color palette ideas:**
- **Academic Blue:** primary: #1F4788, secondary: #56B4E9 (default)
- **Forest Green:** primary: #2C5F2D, secondary: #97BC62
- **Deep Purple:** primary: #5B2C6F, secondary: #A059A0
- **Warm Orange:** primary: #D55E00, secondary: #F0AD4E

### Badge Placement

Badges are configured to appear in the right sidebar:

```yaml
home:
  sidebar:
    structure: [badges, links, license, community, citation, authors, dev]
    components:
      badges:
        - text: |
            [![Badge](url)](link)
```

**Important:** 
- Keep badges under `home.sidebar.components.badges`
- Use `|` for multiline text
- Each badge on a new line
- Include both badge image and link URLs

### Reference Organization

Organize your functions by topic, not alphabetically:

```yaml
reference:
  - title: User-Facing Functions
    desc: Main functions users will call
    contents:
    - main_function1
    - main_function2
  
  - title: Internal Helpers
    desc: Helper functions (usually not exported)
    contents:
    - starts_with("helper_")
```

**Tips:**
- Put most important functions first
- Group by workflow or purpose
- Use descriptive titles and descriptions
- Use `starts_with()`, `has_concept()` for patterns

### Navigation Structure

Customize the navbar:

```yaml
navbar:
  structure:
    left:  [home, reference, articles, news]  # Left side
    right: [search, github]                    # Right side
  components:
    articles:
      text: Articles
      menu:
      - text: Getting Started
        href: articles/intro.html
      - text: -------              # Separator
      - text: "Advanced"           # Section header
      - text: Advanced Topic
        href: articles/advanced.html
```

### Article Organization

Structure your vignettes/articles:

```yaml
articles:
  - title: Getting Started
    navbar: ~                      # Don't show in navbar
    contents:
    - getting-started
  
  - title: Tutorials
    desc: Step-by-step guides
    contents:
    - tutorial1
    - tutorial2
```

## Using with Claude Code

### Quick Setup

In Claude Code, use the `/setup-pkgdown` command:

```
/setup-pkgdown "Use the statistical-methods template with badges in right sidebar"
```

Claude will:
1. Copy the appropriate template
2. Customize it for your package
3. Add your functions to reference
4. Configure badges
5. Build and test the site

### Custom Design

For custom requirements:

```
/setup-pkgdown "I want a green color scheme, badges in right sidebar, and reference organized by: Data Manipulation, Analysis, Visualization"
```

Claude will create a custom configuration based on your needs.

## Troubleshooting

### Badges Don't Show in Sidebar

**Problem:** Badges appear in main content instead of sidebar

**Solution:** Ensure badges are under `home.sidebar.components.badges`:

```yaml
home:
  sidebar:
    structure: [badges, ...]  # Include "badges" here
    components:
      badges:                  # Define badges here
        - text: |
            [![Badge](url)](link)
```

### Colors Don't Apply

**Problem:** Custom colors don't show up

**Solution:** 
1. Check you're using `template.bslib` not `template.params`
2. Ensure `bootstrap: 5` is set
3. Clear browser cache
4. Rebuild site with `pkgdown::clean_site()` then `pkgdown::build_site()`

### CSS Not Loading

**Problem:** Custom CSS doesn't apply

**Solution:**
1. Ensure `extra.css` is in `pkgdown/` directory
2. Check `template.includes.in_header` references it:
   ```yaml
   template:
     includes:
       in_header: |
         <link rel="stylesheet" href="extra.css">
   ```
3. Rebuild the site

### Reference Functions Missing

**Problem:** Some functions don't appear in reference

**Solution:**
1. Ensure functions are exported (have `@export` in roxygen)
2. Run `devtools::document()` to update NAMESPACE
3. Check function names match exactly in `_pkgdown.yml`
4. Use `pkgdown::build_reference_index()` to debug

### Site Build Fails

**Problem:** `pkgdown::build_site()` throws errors

**Solution:**
1. Check YAML syntax is valid (use a YAML validator)
2. Ensure DESCRIPTION has URL field
3. Run `devtools::document()` first
4. Check all article files exist
5. Verify all links are valid

## Examples in the Wild

See how these templates are used in real packages:

- **mediationverse:** Full implementation with custom theming
- (More examples coming soon)

## Contributing

Have improvements or new templates? 

1. Fork the claude-r-dev repository
2. Add your template to `examples/pkgdown-templates/`
3. Update this README
4. Submit a pull request

## Resources

- [pkgdown documentation](https://pkgdown.r-lib.org/)
- [Bootstrap 5 variables](https://rstudio.github.io/bslib/articles/theming.html)
- [YAML syntax](https://yaml.org/spec/1.2/spec.html)
- [Font Awesome icons](https://fontawesome.com/icons) for navbar

## License

Templates are provided under MIT License - feel free to use and modify for your packages.
