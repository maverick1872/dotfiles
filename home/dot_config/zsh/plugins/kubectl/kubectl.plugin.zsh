## If Kubernetes CLI is not installed, don't load this plugin
if (( ! $+commands[kubectl] )); then
  return
fi

# If Kubernetes CLI plugin manager is installed, modify path to include its binaries
if [[ -d "$HOME/.krew" ]]; then
  export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
fi

alias kubectx='kubectl-ctx'
alias kubens='kubectl-ns'
