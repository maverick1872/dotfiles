_require_commands "kubectl.plugin.zsh" kubectl || return

# If Kubernetes CLI plugin manager is installed, modify path to include its binaries
if [[ -d "$HOME/.krew" ]]; then
  export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

  alias kubectx='kubectl-ctx'
  alias kubens='kubectl-ns'
fi
