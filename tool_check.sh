#!/usr/bin/env bash

get_platform() {
    case "$(uname -s)" in
        Darwin*) echo "macOS" ;;
        Linux*)  echo "Linux" ;;
        *)       echo "Unknown" ;;
    esac
}

PLATFORM=$(get_platform)

TOOLS=(
    "aider:--version:An open-source LLM coding agent:all"
    "bat:--version:Cat clone with syntax highlighting:all"
    "brew:--version:Homebrew package manager:macOS"
    "conda:--version:Conda package manager:all"
    "fd:--version:Fast find alternative:all"
    "fish:--version:Friendly Interactive Shell:all"
    "fzf:--version:Fuzzy finder:all"
    "gcc:--version:GNU Compiler Collection:all"
    "gemini:--version:Google Gemini CLI coding agent:all"
    "git:--version:Version control system:all"
    "htop:--version:Interactive process viewer:all"
    "make:--version:Build automation tool:all"
    "mas:--version:Mac App Store CLI:macOS"
    "neofetch:--version:System information tool:all"
    "npm:--version:Node Package Manager:all"
    "nu:--version:Nushell:all"
    "nvim:--version:Neovim text editor:all"
    "nvm:--version:Node Version Manager:all" 
    "opencode:--version:OpenCode IDE:all"
    "qmk:--version:Quantum Mechanical Keyboard firmware tooling:all"
    "rg:--version:Ripgrep text search:all"
    "starship:--version:Cross-shell prompt:all"
    "stow:--version:GNU Stow for managing symlinks:all"
    "tmux:-V:Terminal multiplexer:all"
    "unzip:-v:Archive extraction utility:all"
    "xclip:-version:X11 clipboard tool:Linux"
    "yazi:--version:Terminal file manager:all"
    "ykman:--version:YubiKey cli tooling:all"
    "zoxide:--version:Smart cd command:all"
    "zsh:--version:Z shell:all"
)

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

shell_fn_exists() {
    type "$1" >/dev/null 2>&1
}

print_result() {
    local cmd="$1"
    local version_flag="$2"
    local desc="$3"
    local platform="$4"
    
    if [[ "$platform" != "all" && "$platform" != "$PLATFORM" ]]; then
        return
    fi
    
    local cmd_status="missing"

    if command_exists "$cmd" || shell_fn_exists "$cmd" ; then
        cmd_status="found"
    fi
    
    if [[ "$cmd_status" == "found" ]] ; then  
        printf "${GREEN}✓${NC} %-15s %s\n" "$cmd" "$desc"
    else
        printf "${RED}✗${NC} %-15s %s ${RED}(not found)${NC}\n" "$cmd" "$desc"
    fi
}

# Source NVM if it exists, as it's typically loaded as a shell function.
# This is necessary because this script runs in a new non-interactive shell
# that does not source .zshrc, where nvm is usually initialized.
export NVM_DIR="$HOME/.nvm"
if [[ -s "$NVM_DIR/nvm.sh" ]]; then
  source "$NVM_DIR/nvm.sh"
fi

# Source fzf-git if it exists, as it's typically loaded as a shell function.
# This is necessary because this script runs in a new non-interactive shell
# that does not source .zshrc, where fzf-git is usually initialized.
export FZF_GIT_DIR="$HOME/.fzf-git"


echo -e "${BLUE}System Tools Checker${NC}"
echo -e "${BLUE}Platform: $PLATFORM${NC}"
echo -e "${BLUE}===================${NC}\n"

for tool in "${TOOLS[@]}"; do
    cmd="${tool%%:*}"
    rest="${tool#*:}"
    version_flag="${rest%%:*}"
    rest="${rest#*:}"
    desc="${rest%%:*}"
    platform="${rest#*:}"
    
    print_result "$cmd" "$version_flag" "$desc" "$platform"
done

echo -e "\n${BLUE}Check complete!${NC}" 


