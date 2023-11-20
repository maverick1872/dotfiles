# Load all env vars
source $ZDOTDIR/core/env.zsh

# Load all options
source $ZDOTDIR/core/options.zsh

# Load OMZ if not disabled
if [[ -z $NO_OMZ ]]; then
  # Define where Oh My ZSH is installed
  export ZSH=$XDG_DATA_HOME/oh-my-zsh
  # Define where Oh My ZSH overrides live
  export ZSH_CUSTOM=$ZDOTDIR

  # Autosuggest -- requires in order: zsh-syntax-highlighting zsh-autosuggestions
  AUTOSUGGESTION="true"
  ENHANCED_COMPLETION="true"

  # Which plugins would you like to load
  # Standard plugins can be found in ${ZSH}/plugins/*
  # Custom plugins may be added to ${ZSH_CUSTOM}/plugins/*
  plugins+=(
    git-custom
  )

  source $ZSH/oh-my-zsh.sh
  # Add alias to load zsh without OMZ
  alias custom-zsh="NO_OMZ=1 zsh"
else
  plugins+=(git-custom)
  
  # Load Completion Configuration
  source $ZDOTDIR/core/completion.zsh

  # Add all themes to fpath and load the chosen theme if applicable
  FPATH="${ZDOTDIR}/themes/:${FPATH}"
  autoload -Uz ${ZTHEME:=robbyrussell}.zsh-theme; ${ZTHEME:=robbyrussell}.zsh-theme

  # Load all plugins
  for plugin ($plugins); do
    source "${ZDOTDIR}/plugins/$plugin/$plugin.plugin.zsh"
  done
fi
