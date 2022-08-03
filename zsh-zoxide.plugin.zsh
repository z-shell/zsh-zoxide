# zoxide commands x, xi
if (( $+commands[zoxide] )); then
  eval "$(zoxide init zsh --cmd x)"
fi
