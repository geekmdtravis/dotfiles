# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

alias fzf='fzf --height 40% --layout=reverse --border'
alias fzf-preview='fzf --preview "bat --style=numbers --color=always {}"'
alias fzf-nvim='nvim $(fzf --preview "bat -m --style=numbers --color=always {}")'

