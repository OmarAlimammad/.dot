eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

alias cl="clear"
alias nv="nvim"
alias py="python"
alias ls="eza --icons -la"

if [[ -z "$TMUX" ]] && command -v tmux &> /dev/null; then
    tmux attach || tmux
fi

source ~/.zsh/fsh/fsh.plugin.zsh
source ~/.dot/zsh/cp.zsh
