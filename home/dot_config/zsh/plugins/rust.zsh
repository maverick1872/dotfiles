if [[ -d $HOME/.cargo ]]; then
  export CARGO_HOME="$HOME/.cargo"
  export RUSTUP_HOME="$HOME/.config/rustup"

  # The following will preprend to PATH the cargo bin directory
  if [[ -f "$CARGO_HOME/env" ]]; then
    source "$CARGO_HOME/env"
  fi
fi
