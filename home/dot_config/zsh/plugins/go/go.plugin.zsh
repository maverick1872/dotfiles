_require_commands "go.plugin.zsh" go || return

export PATH="$PATH:$(go env GOPATH)/bin"
