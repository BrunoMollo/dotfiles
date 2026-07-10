
fpath=(~/.zsh/completions $fpath)
autoload -Uz compinit
compinit

# Deshabilita la corrección de errores de tecleo de comandos
unsetopt correct
unsetopt correct_all

source $HOME/.profile

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
eval "$(fnm env --use-on-cd --shell zsh)"
eval "$(zoxide init zsh)"

export PATH="$HOME/.local/bin:$PATH"

# bun completions
[ -s "/Users/bruno/.bun/_bun" ] && source "/Users/bruno/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"


HYPHEN_INSENSITIVE="true"

# Uncomment the following line if pasting URLs and other text is messed up.
DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"


# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Muestra la ruta desde el directorio personal (~) en el prompt.
PROMPT="%(?:%{$fg_bold[green]%}%1{➜%} :%{$fg_bold[red]%}%1{➜%} ) %{$fg[cyan]%}%~%{$reset_color%}"
PROMPT+=' $(git_prompt_info)'


alias claude="/Users/bruno/.claude/local/claude"

alias gcd='echo "$(git gtr list --porcelain | fzf | awk '\''{print $1}'\'')" && pwd'

eval "$(fnm env)"
