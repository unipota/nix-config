# ~/.zshrc sourced by home-manager
# Contains shell aliases and custom functions for better readability and portability.

# --- Aliases ---
alias ls="eza --icons"
alias ll="eza -l --icons --git"
alias la="eza -la --icons --git"
alias ..="cd .."
alias ...="cd ../.."

# Modern replacements
alias cd="z"
alias cat="bat"
alias find="fd"
alias grep="rg"

# Git
alias g="git"
alias ga="git add"
alias gc="git commit"
alias gs="git status"
alias gp="git push"
alias gl="git pull"

# System Update
alias darwin-update="nix run ~/Workspace/nix-darwin#update"

# --- FZF ---
export FZF_DEFAULT_OPTS='
--height 40% --layout=reverse --border
--preview "bat --style=numbers --color=always --line-range :500 {}"
--bind "ctrl-y:execute-silent(echo {} | pbcopy)+abort"
'

pf() {
  fzf --preview "bat --style=numbers --color=always --line-range :500 {}"
}

# --- Carapace ---
export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense' # optional
zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
source <(carapace _carapace)
