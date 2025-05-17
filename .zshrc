
# Varibles
export PATH="$HOME/.local/bin:$PATH"
export EDITOR="lvim"

# Aliases
alias vim="lvim"
alias cls="clear"


source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
eval "$(fnm env --use-on-cd --shell zsh)"
eval "$(starship init zsh)"



