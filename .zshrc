# .zshrc

autoload -Uz compinit
compinit

source $HOME/.profile

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
eval "$(fnm env --use-on-cd --shell zsh)"
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

export PATH="$HOME/.local/bin:$PATH"

# bun completions
[ -s "/Users/bruno/.bun/_bun" ] && source "/Users/bruno/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
