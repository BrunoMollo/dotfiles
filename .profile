# .profile

# Path
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/.config/composer/vendor/bin:$PATH"
export PATH="$HOME/scripts:$PATH"
export PATH="$PATH:$(npm config get prefix)/bin"

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

alias op-nasini-dev="op run --environment blpiylpf4eungdcnqocpw6a7gy"
alias op-nasini-prd="op run --environment 4nihyv74qvalc2cbb4prrh4l6e"
alias op-bet="op run --environment oaqkp4qmhjha2a62j6hcypxshq"

# Comand to download a flag
alias flag='curl -s https://flagcdn.com/en/codes.json \
| jq -r "to_entries[] | \"\(.value) (\(.key))\"" \
| fzf --prompt="País: " \
| sed -E "s/.*\(([a-z]{2})\)/\1/" \
| xargs -I {} curl -o {}.svg https://flagcdn.com/{}.svg'

source $HOME/.keys 


eval "$(fnm env --use-on-cd --shell zsh)"

if command -v ngrok &>/dev/null; then
    eval "$(ngrok completion)"
fi
. "$HOME/.cargo/env"

# Vite+ bin (https://viteplus.dev)
. "/Users/bruno/.config/vite-plus/env"


# Added by Antigravity CLI installer
export PATH="/Users/bruno/.local/bin:$PATH"

alias gh-personal='GH_TOKEN=$(gh auth token --user BrunoMollo) gh'
