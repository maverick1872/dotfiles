# If .cargo/bin/ does not exist, we don't need to do anything
if [[ ! -d $XDG_CONFIG_HOME/cargo/bin ]]; then
  return
fi

export CARGO_HOME="$XDG_CONFIG_HOME/cargo"
export RUSTUP_HOME="$XDG_CONFIG_HOME/rustup"

# The following will preprend to PATH the cargo bin directory
if [[ -f "$CARGO_HOME/env" ]]; then
  source "$CARGO_HOME/env"
fi

### The following is taken from the OMZ Rust plugin ###

# If the completion file doesn't exist yet, we need to autoload it and
# bind it to `cargo`. Otherwise, compinit will have already done that
if [[ ! -f "$ZSH_CACHE_DIR/completions/_cargo" ]]; then
  autoload -Uz _cargo
  typeset -g -A _comps
  _comps[cargo]=_cargo
fi

# If the completion file doesn't exist yet, we need to autoload it and
# bind it to `rustup`. Otherwise, compinit will have already done that
if [[ ! -f "$ZSH_CACHE_DIR/completions/_rustup" ]]; then
  autoload -Uz _rustup
  typeset -g -A _comps
  _comps[rustup]=_rustup
fi

# Generate completion files in the background
rustup completions zsh >| "$ZSH_CACHE_DIR/completions/_rustup" &|
cat >| "$ZSH_CACHE_DIR/completions/_cargo" <<'EOF'
#compdef cargo
source "$(rustc +${${(z)$(rustup default)}[1]} --print sysroot)"/share/zsh/site-functions/_cargo
EOF

