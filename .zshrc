# .zshrc

source $HOME/.profile

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
eval "$(fnm env --use-on-cd --shell zsh)"
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

