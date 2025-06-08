# .profile

# Path
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/.config/composer/vendor/bin:$PATH"

# Varibles
export EDITOR="nvim"
export XDG_CONFIG_HOME="$HOME/.config"
export HOMEBREW_NO_INSTALL_CLEANUP=1

# Aliases
alias cd='z'
alias ci='zi'
alias vim="nvim"
alias cls="clear"
alias t="cd /tmp"
alias aws="aws --profile=bruno_mollo"

source $HOME/.keys 
