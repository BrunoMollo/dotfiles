
# Varibles
export PATH="$HOME/.local/bin:$PATH"
export EDITOR="nvim"
alias cd='z'
alias ci='zi'

# Aliases
alias vim="nvim"
alias cls="clear"


source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
eval "$(fnm env --use-on-cd --shell zsh)"
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"



