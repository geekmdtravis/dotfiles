# Always set XDG_CONFIG_HOME
export XDG_CONFIG_HOME="$HOME/.config"
if [[ ! -d "$XDG_CONFIG_HOME" ]]; then
    echo "XDG_CONFIG_HOME does not exist at $HOME/.config. This is a necessary folder."
fi

# Initialize utilities
eval "$(zoxide init zsh)"
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    eval "$(ssh-agent)"
fi
eval "$(starship init zsh)"

# Use vi mode
# bindkey -v

# Architecture-specific configurations
ARCH=$(uname -m)
case "$ARCH" in
    "arm64")
        export PATH="/opt/homebrew/bin:$PATH"
        [[ -s "$(brew --prefix)/share/nvm/nvm.sh" ]] && {
            export NVM_DIR="$HOME/.nvm"
            source "$(brew --prefix)/share/nvm/nvm.sh"
        }
        ;;
    "x86_64")
        if [[ "$OSTYPE" == "darwin"* ]]; then
            export PATH="/usr/local/bin:$PATH"
            [[ -s "/usr/local/opt/nvm/nvm.sh" ]] && {
                export NVM_DIR="$HOME/.nvm"
                source "/usr/local/opt/nvm/nvm.sh"
            }
        elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
            export NVM_DIR="$HOME/.nvm"
            [[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
        fi
        ;;
    *)
        echo "Unknown OS/architecture: $OSTYPE on $ARCH"
        ;;
esac

# Source additional configurations if they exist
[[ -f "$XDG_CONFIG_HOME/zsh/fzf.zsh" ]] && source "$XDG_CONFIG_HOME/zsh/fzf.zsh"
[[ -f "$XDG_CONFIG_HOME/zsh/anaconda.zsh" ]] && source "$XDG_CONFIG_HOME/zsh/anaconda.zsh"
[[ -f "$XDG_CONFIG_HOME/env.zsh" ]] && source "$XDG_CONFIG_HOME/env.zsh"

# Add common paths if they exist
[[ -d "$HOME/.local/bin" ]] && export PATH="$HOME/.local/bin:$PATH"

# Aliases
alias g='git'
alias ll='ls -l'
alias la='ls -la'
alias gd='git difftool'
alias ga='git add'
alias gc='git commit'
alias gs='git status'

# Source plugins and configurations if they exist
[[ -f "$XDG_CONFIG_HOME/zsh/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh" ]] && source "$XDG_CONFIG_HOME/zsh/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh"
[[ -f "$XDG_CONFIG_HOME/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]] && source "$XDG_CONFIG_HOME/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

