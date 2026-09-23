eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

export EDITOR="nvim"
export PATH="$HOME/.local/bin:$PATH"

alias minecraft="prime-run freesmlauncher & disown"
alias ls="eza --icons -la"

source ~/.zsh/fsh/fsh.plugin.zsh
source ~/.zsh/cp.zsh
