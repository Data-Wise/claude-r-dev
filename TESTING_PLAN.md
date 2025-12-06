# Pre-Release Testing Plan for v1.2.0

**Created:** December 6, 2024  
**Status:** Pending  
**Target Release:** After testing complete

---

## 🧪 Testing Categories

### 1. MkDocs Documentation

| Test | Command | Expected Result | Status |
|------|---------|-----------------|--------|
| Local build | `mkdocs build` | No errors, site built to `site/` | ⬜ |
| Local serve | `mkdocs serve` | Site accessible at localhost:8000 | ⬜ |
| All pages render | Manual check | No 404s, all content visible | ⬜ |
| Navigation works | Manual check | All menu items clickable | ⬜ |
| Dark/light mode | Click toggle | Theme switches correctly | ⬜ |
| Mobile responsive | Browser resize | Content adapts properly | ⬜ |
| Code highlighting | View code blocks | R code has syntax colors | ⬜ |
| Internal links | Click through | All relative links work | ⬜ |

### 2. Installer Script

| Test | Command | Expected Result | Status |
|------|---------|-----------------|--------|
| Help flag | `./scripts/install.sh --help` | Shows usage information | ⬜ |
| Dry run (base) | `./scripts/install.sh --profile base --target ~/test-pkg --dry-run` | Shows what would happen | ⬜ |
| Actual install (base) | `./scripts/install.sh --profile base --target ~/test-pkg` | Creates `.claude/` directory | ⬜ |
| Multi-profile | `./scripts/install.sh --profiles base,statistical-methods --target ~/test-pkg` | Merges both profiles | ⬜ |
| Invalid target | `./scripts/install.sh --profile base --target /nonexistent` | Error message | ⬜ |
| Non-R-package | `./scripts/install.sh --profile base --target ~/` | Warns about missing DESCRIPTION | ⬜ |

### 3. Profile Validation

| Test | What to Check | Status |
|------|--------------|--------|
| `profiles/base/CLAUDE.md` | Valid markdown, no broken links | ⬜ |
| `profiles/base/settings.json` | Valid JSON | ⬜ |
| `profiles/base/commands/*.md` | All commands have proper structure | ⬜ |
| `profiles/base/agents/*.md` | All agents have proper structure | ⬜ |
| `profiles/base/templates/` | Templates have placeholders | ⬜ |

### 4. Example Configurations

| Test | File | Check | Status |
|------|------|-------|--------|
| Mediation example | `examples/configurations/mediation-package.yml` | Valid YAML | ⬜ |
| Longitudinal example | `examples/configurations/longitudinal-package.yml` | Valid YAML | ⬜ |
| Data pipeline example | `examples/configurations/data-pipeline-package.yml` | Valid YAML | ⬜ |
| pkgdown template | `examples/pkgdown-templates/statistical-methods.yml` | Valid YAML | ⬜ |
| CSS template | `examples/pkgdown-templates/extra.css` | Valid CSS | ⬜ |

### 5. GitHub Integration

| Test | What to Check | Status |
|------|--------------|--------|
| GitHub Pages | Site loads at <https://data-wise.github.io/claude-r-dev/> | ⬜ |
| MkDocs workflow | `.github/workflows/mkdocs.yml` triggers on push | ⬜ |
| README links | All links in README.md work | ⬜ |
| Badge links | All badge URLs resolve | ⬜ |

### 6. Real-World Test

| Test | Package | Status |
|------|---------|--------|
| Install on mediationverse | Use installer with `base,statistical-methods` | ⬜ |
| Run `/project:pre-commit-check` | Should execute workflow | ⬜ |
| Run `/project:init` | Should show wizard | ⬜ |
| Use sub-agent | `r-package-reviewer` works | ⬜ |

---

## 📋 Pre-Commit Checklist

Before final release:

- [ ] All MkDocs tests pass
- [ ] Installer works on fresh package
- [ ] All YAML/JSON files validate
- [ ] GitHub Pages deploys correctly  
- [ ] Real-world test on mediationverse
- [ ] CHANGELOG.md updated with release date
- [ ] Git tag created (v1.2.0)
- [ ] GitHub release created

---

## ⏭️ Next Session Actions

1. Run MkDocs locally: `mkdocs serve`
2. Test installer on a test package
3. Validate YAML files
4. Push changes and verify GitHub Pages
5. Create release tag

---

## 📝 Notes

- The lint warnings for fenced code blocks are intentional (wizard output)
- The duplicate heading warnings in CHANGELOG are expected (Keep a Changelog format)
- UPDATE_SUMMARY.md can be archived after release (historical v1.1.0 info)
