# Load all env vars
source $ZDOTDIR/core/env.zsh

# Load all options
source $ZDOTDIR/core/options.zsh

# Load theme configuration
if [[ $ZSH_THEME = "powerlevel10k/powerlevel10k" ]]; then
  source $ZDOTDIR/themes/p10k-config.zsh
fi

# Load OMZ if not disabled
if [[ -z $NO_OMZ ]]; then
  _debug "Initializing with OMZ"
  # Define where Oh My ZSH is installed
  export ZSH=$XDG_DATA_HOME/oh-my-zsh
  # Define where Oh My ZSH overrides live
  export ZSH_CUSTOM=$ZDOTDIR

  # Autosuggest -- requires in order: zsh-syntax-highlighting zsh-autosuggestions
  AUTOSUGGESTION="true"
  ENHANCED_COMPLETION="true"

  # Which OMZ plugins would you like to load
  # plugins+=()

  source $ZSH/oh-my-zsh.sh
  # Add alias to load zsh without OMZ
  alias custom-zsh="NO_OMZ=1 zsh"
else
  _debug "Initializing without omz"

  has_plugin() {
    local name=$1
    builtin test -f $ZDOTDIR/plugins/$name/$name.plugin.zsh
  }

  has_completion() {
    local name=$1
    builtin test -f $ZDOTDIR/plugins/$name/_$name
  }


  FPATH="/usr/share/zsh/${ZSH_VERSION}/functions:${FPATH}"

  # Load Completion Configuration
  source $ZDOTDIR/core/completion.zsh

  # Load theme utils
  source $ZDOTDIR/themes/utils.zsh

  # Add all themes to fpath and load the chosen theme if applicable
  FPATH="${ZDOTDIR}/themes/:${FPATH}"
  source $ZDOTDIR/themes/utils.zsh
  source "${ZDOTDIR}/themes/${ZTHEME:=default}.zsh-theme"

  # Load all plugins
  for plugin ($plugins); do
    if has_plugin "$plugin"; then
      source "${ZDOTDIR}/plugins/$plugin/$plugin.plugin.zsh"
    fi
    # Add all defined plugins to fpath. This must be done
    # before running compinit.
    # if has_completion "$plugin"; then
    #   fpath=("$ZSH/plugins/$plugin" $fpath)
    # fi
  done
fi

