# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Autosuggest -- requires in order: zsh-syntax-highlighting zsh-autosuggestions
AUTOSUGGESTION="true"

# Faster, more descriptions, colored
ENHANCED_COMPLETION="true"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
#COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  zsh-syntax-highlighting
  zsh-autosuggestions
  history-search-multi-word
)
# TODO: Evaluate following plugins from catmeme/dotfiles
# plugins=(
#     git
#     z
#     zsh-syntax-highlighting
#     zsh-autosuggestions
#     history-substring-search
#     history-search-multi-word
#     docker
# )

### User configuration ###
## All of the following could likely be broken out to a custom zsh file that's sourced into the .zshrc ##

# ZSH_THEME and ZSH_CUSTOM must be configured prior to sourcing oh-my-zsh.sh
export ZSH_CUSTOM=$ZSH/custom
# ZSH_THEME="maverick1872"

source $ZSH/oh-my-zsh.sh

# Set path
export PATH=$PATH:$HOME/bin

# Set OS envvar
if [[ $(uname) == 'Linux' ]]; then
    export OS="linux"
elif [[ $(uname) == 'Darwin' ]]; then
    export OS="osx"
fi

# Set default editor
export EDITOR='vim'

## All of the following could likely be removed if the files end in .zsh ##

# # Source ZSH Custom aliases
# if [ -f $ZSH_CUSTOM/aliases ]; then
#     source $ZSH_CUSTOM/aliases
# fi
#
# # Source ZSH Custom functions
# if [ -f $ZSH_CUSTOM/functions ]; then
#     source $ZSH_CUSTOM/functions
# fi
#
# # Source ZSH Custom plugins
# if [ -f $ZSH_CUSTOM/plugins ]; then
#     source $ZSH_CUSTOM/plugins
# fi
#
# # Source ZSH Custom completions
# if [ -f $ZSH_CUSTOM/completions ]; then
#     source $ZSH_CUSTOM/completions
# fi
