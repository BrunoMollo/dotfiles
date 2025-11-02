# .profile

# Path
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/.config/composer/vendor/bin:$PATH"
export PATH="$HOME/scripts:$PATH"

# Varibles
export EDITOR="nvim"
export XDG_CONFIG_HOME="$HOME/.config"
export HOMEBREW_NO_INSTALL_CLEANUP=1

# Aliases
alias cd='z'
alias ci='zi'
alias vim="nvim"
alias cls="clear"
alias t="mkdir -p /tmp/tmp && cd /tmp/tmp/"

# Comand to download a flag
alias flag='curl -s https://flagcdn.com/en/codes.json \
| jq -r "to_entries[] | \"\(.value) (\(.key))\"" \
| fzf --prompt="País: " \
| sed -E "s/.*\(([a-z]{2})\)/\1/" \
| xargs -I {} curl -o {}.svg https://flagcdn.com/{}.svg'

source $HOME/.keys 


if command -v ngrok &>/dev/null; then
    eval "$(ngrok completion)"
fi
