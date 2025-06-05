export XDG_CONFIG_HOME=$HOME/.config

source $XDG_CONFIG_HOME/zsh/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh 

# Start zoxide 
eval "$(zoxide init zsh)"

# Start ssh-agent
eval `ssh-agent`

# Initialize starship prompt
eval "$(starship init zsh)"

# Use vi mode
# bindkey -v

# Oh My Zsh plugins
plugins=(git)

# Architecture-specific configurations
ARCH=$(uname -m)
case "$ARCH" in
    "arm64")
        # Apple Silicon (M1/M2/M3) specific settings
        export PATH="/opt/homebrew/bin:$PATH"
        # Fixed: Set NVM_DIR correctly and source nvm.sh
        if [[ -s "$(brew --prefix)/share/nvm/nvm.sh" ]]; then
            export NVM_DIR="$HOME/.nvm"
            source "$(brew --prefix)/share/nvm/nvm.sh"
        elif [[ -s "/opt/homebrew/opt/nvm/nvm.sh" ]]; then
            export NVM_DIR="$HOME/.nvm"
            source "/opt/homebrew/opt/nvm/nvm.sh"
        fi
        ;;
    "x86_64")
        # Intel Mac specific settings
        if [[ "$OSTYPE" == "darwin"* ]]; then
            # macOS Intel
            export PATH="/usr/local/bin:$PATH"
            if [[ -s "/usr/local/opt/nvm/nvm.sh" ]]; then
                export NVM_DIR="$HOME/.nvm"
                source "/usr/local/opt/nvm/nvm.sh"
            fi
        else
            # Linux x86_64
            export NVM_DIR="$HOME/.nvm"
            [[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
        fi
        ;;
    *)
        # Other architectures (Linux ARM, etc.)
        if [[ "$OSTYPE" == "linux-gnu"* ]]; then
            export NVM_DIR="$HOME/.nvm"
            [[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
        else
            echo "Unknown OS/architecture: $OSTYPE on $ARCH"
        fi
        ;;
esac

# Universal sourcing (if files exist)
[[ -f "$XDG_CONFIG_HOME/zsh/fzf.zsh" ]] && source "$XDG_CONFIG_HOME/zsh/fzf.zsh"
[[ -f "$XDG_CONFIG_HOME/zsh/anaconda.zsh" ]] && source "$XDG_CONFIG_HOME/zsh/anaconda.zsh"

# Machine-specific configuration
export PATH="$HOME/.local/bin:$PATH"
[[ -f "$XDG_CONFIG_HOME/env.zsh" ]] && source "$XDG_CONFIG_HOME/env.zsh"

# Aliases
alias g='git' 
alias ll='ls -l'
alias la='ls -la' 
alias gd='git difftool'
alias ga='git add'
alias gc='git commit'
alias gs='git status'

# Must be at the end.
source $XDG_CONFIG_HOME/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
