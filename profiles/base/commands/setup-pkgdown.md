# Setup pkgdown Website

This command helps you create or update a pkgdown website with professional design standards.

## Usage

```
/setup-pkgdown
```

Or with specific design requirements:

```
/setup-pkgdown "Create a pkgdown site with badges in right sidebar, blue color scheme, and reference organized by function type"
```

## Workflow

### Phase 1: Assessment
1. Check if `_pkgdown.yml` exists
2. Review current configuration
3. Identify gaps and improvement areas
4. Ask user about design preferences:
   - Color scheme
   - Badge placement  
   - Navigation structure
   - Reference organization
   - Custom CSS needs

### Phase 2: Planning
1. Create comprehensive plan for `_pkgdown.yml`
2. Design reference structure based on package functions
3. Plan custom CSS if needed
4. Outline badge configuration for sidebar
5. **STOP** - Present plan to user for approval

### Phase 3: Implementation (After Approval)
1. Create or update `_pkgdown.yml`:
   - Set URL and development mode (auto)
   - Set template and theme
   - Configure colors and styling
   - Set up navigation structure
   - Add badges to right sidebar
   - Organize reference by topic
   - Configure articles section
   - Set footer links

2. Create `pkgdown/extra.css` if needed:
   - Badge styling
   - Sidebar customization
   - Responsive design
   - Custom color overrides

3. Update `DESCRIPTION` if needed:
   - Add URL field
   - Add BugReports field
   - Add Config/Needs/website for pkgdown dependencies

4. Configure development mode:
   - Ensure `development: mode: auto` is set
   - Verify version follows conventions (3 for release, 4 for dev)
   - Document version workflow for maintainers

### Phase 4: Testing
1. Run `pkgdown::build_site()`
2. Check for errors or warnings
3. Verify badge placement
4. Check responsive design
5. Test all navigation links

### Phase 5: Documentation
1. Document design decisions in comments
2. Add README note about pkgdown customization
3. Update NEWS.md if significant changes

### Phase 6: Verification
1. Open `docs/index.html` in browser
2. Verify badges appear in right sidebar
3. Check color scheme matches specifications
4. Ensure reference organization is clear
5. Test navigation and links

## Expected Outcomes

- Professional, customized pkgdown website
- Badges visible in right sidebar
- Clear reference organization
- Custom styling matches package branding
- Site builds without errors
- All links functional
- Responsive design works on mobile

## Common Customizations

### Badge Configuration
Badges should be in `home.sidebar.components` in `_pkgdown.yml`:

```yaml
home:
  sidebar:
    structure: [badges, links, license, community, citation, authors, dev]
    components:
      badges:
        - text: |
            [![R-CMD-check](badge-url)](action-url)
            [![Codecov](badge-url)](coverage-url)
```

### Color Scheme
Use `template.bslib` for Bootstrap 5 theming:

```yaml
template:
  bootstrap: 5
  bslib:
    primary: "#1F4788"
    secondary: "#56B4E9"
```

### Reference Organization
Group functions logically:

```yaml
reference:
  - title: Main Functions
    desc: Core functionality
    contents:
    - func1
    - func2
  
  - title: Utilities
    desc: Helper functions
    contents:
    - starts_with("helper_")
```

### Custom CSS
For advanced styling, create `pkgdown/extra.css`:

```css
/* Badge styling */
.sidebar .badges {
  margin-top: 20px;
  text-align: center;
}

.sidebar .badges img {
  display: block;
  margin: 10px auto;
  max-width: 100%;
}
```

## Best Practices

1. **Badges in Sidebar:** Always place badges in sidebar, not README content
2. **Reference Organization:** Group by functionality, not alphabetically
3. **Color Consistency:** Use consistent color scheme across site
4. **Responsive Design:** Test on mobile devices
5. **Accessibility:** Ensure good contrast ratios
6. **Documentation:** All exported functions should have examples
7. **Articles:** Link to vignettes from navbar
8. **Development Mode:** Use `development: mode: auto` for stable/dev sites
   - Release versions (3 components): `1.0.0` → builds to `docs/`
   - Dev versions (4 components): `1.0.0.9000` → builds to `docs/dev/`
   - After release, immediately bump to dev version
   - Use conditional content (`.pkgdown-release`, `.pkgdown-devel`)
9. **Website Dependencies:** Use `Config/Needs/website` in DESCRIPTION, not `Suggests`

## Troubleshooting

### Badges Don't Appear in Sidebar
- Check `home.sidebar.structure` includes "badges"
- Verify badge markdown is under `home.sidebar.components.badges`
- Ensure proper YAML indentation

### Colors Don't Apply
- Use `template.bslib` not `template.params`
- Check Bootstrap version is 5
- Clear browser cache

### Reference Index Issues
- Ensure all exported functions are listed
- Use `has_concept()` or `starts_with()` for patterns
- Check function names match exactly

### Site Build Fails
- Run `devtools::document()` first
- Check all links are valid
- Verify DESCRIPTION has URL field
- Ensure all referenced files exist

## Related Commands

- `/pre-commit-check` - Includes pkgdown build verification
- Use `r-package-reviewer` sub-agent to review pkgdown config
- Use `documentation-writer` sub-agent for vignettes

## References

- [pkgdown documentation](https://pkgdown.r-lib.org/)
- [Bootstrap 5 theming](https://rstudio.github.io/bslib/)
- [YAML configuration reference](https://pkgdown.r-lib.org/reference/build_site.html)
