# Load all env vars
source $ZDOTDIR/core/env.zsh

# Load all options
source $ZDOTDIR/core/options.zsh

# Load OMZ if not disabled
if [[ -z $NO_OMZ ]]; then
  # Autosuggest -- requires in order: zsh-syntax-highlighting zsh-autosuggestions
  AUTOSUGGESTION="true"
  ENHANCED_COMPLETION="true"

  # Which plugins would you like to load
  # Standard plugins can be found in ${ZSH}/plugins/*
  # Custom plugins may be added to ${ZSH_CUSTOM}/plugins/*
  plugins=(
    bitwarden
    chezmoi
    core
    docker
    fnm
    gcloud
    git
    github
    node
    rust
    zsh-syntax-highlighting
    zsh-autosuggestions
    history-search-multi-word
  )

  source $ZSH/oh-my-zsh.sh
  # Add alias to load zsh without OMZ
  alias custom-zsh="NO_OMZ=1 zsh"
else
  ## Consider moving the following order dependent setup to a a standalone file e.g. init.zsh or similar
  # Load Completion Configuration
  source $ZDOTDIR/core/completion.zsh

  # Add all themes to fpath and load the chosen theme if applicable
  FPATH="${ZDOTDIR}/omz/themes/:${FPATH}"
  autoload -Uz ${ZTHEME:=robbyrussell}.zsh-theme; ${ZTHEME:=robbyrussell}.zsh-theme

  # Load all plugins
  for file in $(find ${ZDOTDIR}/plugins -type f -name '*.plugin.zsh' -print); do
    source "$file"
  done
fi
