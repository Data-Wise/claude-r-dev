#!/bin/bash
# install.sh - Smart installer for claude-r-dev
# Install claude-r-dev profiles to R packages

set -e  # Exit on error

# Script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && cd .. && pwd)"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Default values
PROFILES="base"
TARGET_DIR=""
MERGE_STRATEGY="append"
DRY_RUN=false
VERBOSE=false
INTERACTIVE=true
BACKUP=true

# Version
VERSION="1.0.0"

#######################################
# Print header
#######################################
print_header() {
    echo -e "${BLUE}"
    echo "╔══════════════════════════════════════════════════════╗"
    echo "║                                                      ║"
    echo "║           claude-r-dev Installer v${VERSION}           ║"
    echo "║                                                      ║"
    echo "╚══════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

#######################################
# Print usage
#######################################
usage() {
    cat << EOF
Usage: $0 [OPTIONS] [TARGET_DIR]

Install claude-r-dev configuration profiles to R packages.

OPTIONS:
    --profiles PROFILES   Comma-separated list of profiles (default: base)
                         Available: base,statistical-methods
    --target DIR         Target package directory (required)
    --merge-strategy     How to merge: append, replace (default: append)
    --dry-run           Show what would be done without doing it
    --no-backup         Don't create backup before modifying
    --no-interactive    Don't prompt for confirmations
    --verbose           Show detailed output
    -h, --help          Show this help message
    --version           Show version

EXAMPLES:
    # Install base profile only
    $0 --target ~/mypackage

    # Install base + statistical-methods
    $0 --profiles base,statistical-methods --target ~/mypackage

    # Dry run to see what would happen
    $0 --profiles base --target ~/mypackage --dry-run

    # Non-interactive installation
    $0 --profiles base,statistical-methods --target ~/mypackage --no-interactive

EOF
}

#######################################
# Parse command line arguments
#######################################
parse_args() {
    while [[ $# -gt 0 ]]; do
        case $1 in
            --profiles)
                PROFILES="$2"
                shift 2
                ;;
            --target)
                TARGET_DIR="$2"
                shift 2
                ;;
            --merge-strategy)
                MERGE_STRATEGY="$2"
                shift 2
                ;;
            --dry-run)
                DRY_RUN=true
                shift
                ;;
            --no-backup)
                BACKUP=false
                shift
                ;;
            --no-interactive)
                INTERACTIVE=false
                shift
                ;;
            --verbose)
                VERBOSE=true
                shift
                ;;
            --version)
                echo "claude-r-dev installer v${VERSION}"
                exit 0
                ;;
            -h|--help)
                usage
                exit 0
                ;;
            *)
                if [[ -z "$TARGET_DIR" ]]; then
                    TARGET_DIR="$1"
                else
                    echo -e "${RED}Error: Unknown option $1${NC}"
                    usage
                    exit 1
                fi
                shift
                ;;
        esac
    done
}

#######################################
# Validate inputs
#######################################
validate_inputs() {
    # Check target directory provided
    if [[ -z "$TARGET_DIR" ]]; then
        echo -e "${RED}Error: Target directory required${NC}"
        usage
        exit 1
    fi

    # Make target directory absolute
    TARGET_DIR="$(cd "$TARGET_DIR" 2>/dev/null && pwd || echo "$TARGET_DIR")"

    # Check if target exists
    if [[ ! -d "$TARGET_DIR" ]]; then
        echo -e "${RED}Error: Directory $TARGET_DIR does not exist${NC}"
        exit 1
    fi

    # Check if it's an R package
    if [[ ! -f "$TARGET_DIR/DESCRIPTION" ]]; then
        echo -e "${YELLOW}Warning: No DESCRIPTION file found${NC}"
        echo -e "${YELLOW}This doesn't appear to be an R package${NC}"
        if [[ "$INTERACTIVE" == "true" ]]; then
            read -p "Continue anyway? (y/n) " -n 1 -r
            echo
            if [[ ! $REPLY =~ ^[Yy]$ ]]; then
                exit 1
            fi
        fi
    fi

    # Parse and validate profiles
    IFS=',' read -ra PROFILE_ARRAY <<< "$PROFILES"
    for profile in "${PROFILE_ARRAY[@]}"; do
        if [[ ! -d "$SCRIPT_DIR/profiles/$profile" ]]; then
            echo -e "${RED}Error: Profile '$profile' not found${NC}"
            echo "Available profiles:"
            ls -1 "$SCRIPT_DIR/profiles/"
            exit 1
        fi
    done

    # Check if base is included (required)
    if [[ ! " ${PROFILE_ARRAY[@]} " =~ " base " ]]; then
        echo -e "${YELLOW}Note: base profile is required, adding it${NC}"
        PROFILE_ARRAY=("base" "${PROFILE_ARRAY[@]}")
    fi
}

#######################################
# Create backup
#######################################
create_backup() {
    if [[ "$BACKUP" == "false" ]] || [[ "$DRY_RUN" == "true" ]]; then
        return
    fi

    local backup_dir="$TARGET_DIR/.claude-backup-$(date +%Y%m%d-%H%M%S)"

    if [[ -d "$TARGET_DIR/.claude" ]] || [[ -f "$TARGET_DIR/CLAUDE.md" ]]; then
        echo -e "${BLUE}Creating backup...${NC}"
        mkdir -p "$backup_dir"

        if [[ -d "$TARGET_DIR/.claude" ]]; then
            cp -r "$TARGET_DIR/.claude" "$backup_dir/"
        fi

        if [[ -f "$TARGET_DIR/CLAUDE.md" ]]; then
            cp "$TARGET_DIR/CLAUDE.md" "$backup_dir/"
        fi

        echo -e "${GREEN}✓${NC} Backup created at $backup_dir"
    fi
}

#######################################
# Install profile
#######################################
install_profile() {
    local profile=$1
    local profile_dir="$SCRIPT_DIR/profiles/$profile"

    echo -e "${BLUE}Installing profile: $profile${NC}"

    if [[ "$VERBOSE" == "true" ]]; then
        echo "  Profile directory: $profile_dir"
    fi

    # Install CLAUDE.md
    if [[ -f "$profile_dir/CLAUDE.md" ]]; then
        if [[ "$DRY_RUN" == "true" ]]; then
            echo -e "  ${YELLOW}[DRY RUN]${NC} Would merge $profile_dir/CLAUDE.md"
        else
            merge_claude_md "$profile_dir/CLAUDE.md" "$profile"
        fi
    fi

    # Install settings.json
    if [[ -f "$profile_dir/settings.json" ]]; then
        if [[ "$DRY_RUN" == "true" ]]; then
            echo -e "  ${YELLOW}[DRY RUN]${NC} Would merge $profile_dir/settings.json"
        else
            merge_settings_json "$profile_dir/settings.json"
        fi
    fi

    # Install commands
    if [[ -d "$profile_dir/commands" ]]; then
        mkdir -p "$TARGET_DIR/.claude/commands"
        for cmd in "$profile_dir/commands"/*.md; do
            if [[ -f "$cmd" ]]; then
                local cmd_name=$(basename "$cmd")
                if [[ "$DRY_RUN" == "true" ]]; then
                    echo -e "  ${YELLOW}[DRY RUN]${NC} Would copy command: $cmd_name"
                else
                    cp "$cmd" "$TARGET_DIR/.claude/commands/"
                    echo -e "  ${GREEN}✓${NC} Installed command: $cmd_name"
                fi
            fi
        done
    fi

    # Install agents
    if [[ -d "$profile_dir/agents" ]]; then
        mkdir -p "$TARGET_DIR/.claude/agents"
        for agent in "$profile_dir/agents"/*.md; do
            if [[ -f "$agent" ]]; then
                local agent_name=$(basename "$agent")
                if [[ "$DRY_RUN" == "true" ]]; then
                    echo -e "  ${YELLOW}[DRY RUN]${NC} Would copy agent: $agent_name"
                else
                    cp "$agent" "$TARGET_DIR/.claude/agents/"
                    echo -e "  ${GREEN}✓${NC} Installed agent: $agent_name"
                fi
            fi
        done
    fi
}

#######################################
# Merge CLAUDE.md files
#######################################
merge_claude_md() {
    local source_file=$1
    local profile_name=$2
    local target_file="$TARGET_DIR/CLAUDE.md"

    if [[ ! -f "$target_file" ]]; then
        # No existing file, just copy
        cp "$source_file" "$target_file"
        echo -e "  ${GREEN}✓${NC} Installed CLAUDE.md"
    else
        # Append profile content
        echo "" >> "$target_file"
        echo "# ============================================" >> "$target_file"
        echo "# Profile: $profile_name" >> "$target_file"
        echo "# ============================================" >> "$target_file"
        echo "" >> "$target_file"
        cat "$source_file" >> "$target_file"
        echo -e "  ${GREEN}✓${NC} Merged CLAUDE.md (appended $profile_name)"
    fi
}

#######################################
# Merge settings.json files
#######################################
merge_settings_json() {
    local source_file=$1
    local target_file="$TARGET_DIR/.claude/settings.json"

    mkdir -p "$TARGET_DIR/.claude"

    if [[ ! -f "$target_file" ]]; then
        # No existing file, just copy
        cp "$source_file" "$target_file"
        echo -e "  ${GREEN}✓${NC} Installed settings.json"
    else
        # Merge JSON (simple append to allowedTools array)
        # In a production version, you'd want proper JSON merging
        cp "$source_file" "$target_file"
        echo -e "  ${GREEN}✓${NC} Updated settings.json"
    fi
}

#######################################
# Update .gitignore
#######################################
update_gitignore() {
    local gitignore="$TARGET_DIR/.gitignore"

    if [[ "$DRY_RUN" == "true" ]]; then
        echo -e "${YELLOW}[DRY RUN]${NC} Would update .gitignore"
        return
    fi

    echo -e "${BLUE}Updating .gitignore...${NC}"

    if [[ ! -f "$gitignore" ]]; then
        touch "$gitignore"
        echo -e "${GREEN}✓${NC} Created .gitignore"
    fi

    # Add Claude-specific ignores
    local additions=(
        "CLAUDE.local.md"
        ".Rproj.user/"
        ".Rhistory"
        ".RData"
        "*.Rcheck/"
    )

    for item in "${additions[@]}"; do
        if ! grep -q "$item" "$gitignore" 2>/dev/null; then
            echo "$item" >> "$gitignore"
            echo -e "  ${GREEN}✓${NC} Added $item"
        fi
    done
}

#######################################
# Create installation manifest
#######################################
create_manifest() {
    if [[ "$DRY_RUN" == "true" ]]; then
        return
    fi

    local manifest="$TARGET_DIR/.claude/manifest.json"
    mkdir -p "$TARGET_DIR/.claude"

    cat > "$manifest" << EOF
{
  "version": "${VERSION}",
  "installed_at": "$(date -u +"%Y-%m-%dT%H:%M:%SZ")",
  "profiles": [$(printf '"%s",' "${PROFILE_ARRAY[@]}" | sed 's/,$//')]
}
EOF

    echo -e "${GREEN}✓${NC} Created installation manifest"
}

#######################################
# Check prerequisites
#######################################
check_prerequisites() {
    echo -e "${BLUE}Checking prerequisites...${NC}"

    # Check for R
    if ! command -v R &> /dev/null; then
        echo -e "${YELLOW}⚠ R not found in PATH${NC}"
    else
        echo -e "${GREEN}✓${NC} R found: $(R --version | head -n1)"
    fi

    # Check for Claude Code
    if ! command -v claude &> /dev/null; then
        echo -e "${YELLOW}⚠ Claude Code CLI not found${NC}"
        echo "  Install: npm install -g @anthropic-ai/claude-code"
    else
        echo -e "${GREEN}✓${NC} Claude Code CLI found"
    fi

    # Check for git
    if ! command -v git &> /dev/null; then
        echo -e "${YELLOW}⚠ git not found${NC}"
    else
        echo -e "${GREEN}✓${NC} git found"
    fi

    echo ""
}

#######################################
# Print summary
#######################################
print_summary() {
    echo ""
    echo -e "${GREEN}╔══════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║                                                      ║${NC}"
    echo -e "${GREEN}║            Installation Complete! 🎉                ║${NC}"
    echo -e "${GREEN}║                                                      ║${NC}"
    echo -e "${GREEN}╚══════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${BLUE}Installed profiles:${NC}"
    for profile in "${PROFILE_ARRAY[@]}"; do
        echo "  - $profile"
    done
    echo ""
    echo -e "${BLUE}Target directory:${NC} $TARGET_DIR"
    echo ""
    echo -e "${YELLOW}Next steps:${NC}"
    echo ""
    echo "1. Navigate to your package:"
    echo -e "   ${BLUE}cd $TARGET_DIR${NC}"
    echo ""
    echo "2. Start Claude Code:"
    echo -e "   ${BLUE}claude${NC}"
    echo ""
    echo "3. Try these commands:"
    echo -e "   ${BLUE}/permissions${NC}              # View tool allowlist"
    echo -e "   ${BLUE}/project:${NC}                 # See custom commands"
    echo -e "   ${BLUE}/project:pre-commit-check${NC} # Run quality checks"
    echo ""
    echo -e "${GREEN}Happy coding with Claude! 🚀${NC}"
    echo ""
}

#######################################
# Main installation flow
#######################################
main() {
    print_header
    parse_args "$@"
    validate_inputs
    check_prerequisites

    if [[ "$DRY_RUN" == "true" ]]; then
        echo -e "${YELLOW}DRY RUN MODE - No changes will be made${NC}"
        echo ""
    fi

    echo -e "${BLUE}Installation Summary:${NC}"
    echo "  Target: $TARGET_DIR"
    echo "  Profiles: ${PROFILE_ARRAY[*]}"
    echo "  Backup: $BACKUP"
    echo ""

    if [[ "$INTERACTIVE" == "true" ]] && [[ "$DRY_RUN" == "false" ]]; then
        read -p "Continue with installation? (y/n) " -n 1 -r
        echo ""
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            echo "Installation cancelled"
            exit 0
        fi
    fi

    create_backup

    # Install each profile
    for profile in "${PROFILE_ARRAY[@]}"; do
        install_profile "$profile"
    done

    update_gitignore
    create_manifest

    if [[ "$DRY_RUN" == "false" ]]; then
        print_summary
    else
        echo ""
        echo -e "${YELLOW}Dry run complete. No changes were made.${NC}"
        echo "Run without --dry-run to actually install."
    fi
}

# Run main
main "$@"
