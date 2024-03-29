# Based on Michele Bologna's theme
# http://michelebologna.net
#
# This a theme for oh-my-zsh. Features a colored prompt with:
# * username@host: [jobs] [git] workdir %
# * hostname color is based on hostname characters. When using as root, the
# prompt shows only the hostname in red color.
# * [jobs], if applicable, counts the number of suspended jobs tty
# * [git], if applicable, represents the status of your git repo (more on that
# later)
# * '%' prompt will be green if last command return value is 0, yellow otherwise.
#
# git prompt is inspired by official git contrib prompt:
# https://github.com/git/git/tree/master/contrib/completion/git-prompt.sh
# and it adds:
# * the current branch
# * '%' if there are untracked files
# * '$' if there are stashed changes
# * '*' if there are modified files
# * '+' if there are added files
# * '<' if local repo is behind remote repo
# * '>' if local repo is ahead remote repo
# * '=' if local repo is equal to remote repo (in sync)
# * '<>' if local repo is diverged
#
# RECOMMENDS: async-rprompt
# Configure your RPROMPT_MODE variable in your ~/.zshrc
# THREE RPROMPT MODES:
# 0 - no right prompt, all git info in the left
# 1 - right prompt with git info, not async
# 2 - right prompt with git info, async
#
# e.g. RPROMPT_MODE=2

# Support 256 colors
[[ "$TERM" == "xterm" ]] && export TERM=xterm-256color
setopt transient_rprompt
RPROMPT_MODE=2

export LS_COLORS='no=00:fi=00:di=01;34:ln=00;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=41;33;01:ex=00;32:*.cmd=00;32:*.exe=01;32:*.com=01;32:*.bat=01;32:*.btm=01;32:*.dll=01;32:*.tar=00;31:*.tbz=00;31:*.tgz=00;31:*.rpm=00;31:*.deb=00;31:*.arj=00;31:*.taz=00;31:*.lzh=00;31:*.lzma=00;31:*.zip=00;31:*.zoo=00;31:*.z=00;31:*.Z=00;31:*.gz=00;31:*.bz2=00;31:*.tb2=00;31:*.tz2=00;31:*.tbz2=00;31:*.avi=01;35:*.bmp=01;35:*.fli=01;35:*.gif=01;35:*.jpg=01;35:*.jpeg=01;35:*.mng=01;35:*.mov=01;35:*.mpg=01;35:*.pcx=01;35:*.pbm=01;35:*.pgm=01;35:*.png=01;35:*.ppm=01;35:*.tga=01;35:*.tif=01;35:*.xbm=01;35:*.xpm=01;35:*.dl=01;35:*.gl=01;35:*.wmv=01;35:*.aiff=00;32:*.au=00;32:*.mid=00;32:*.mp3=00;32:*.ogg=00;32:*.voc=00;32:*.wav=00;32:'
#eval $(dircolors -b)

local green="%{$fg[green]%}"
local red="%{$fg[red]%}"
local cyan="%{$fg[cyan]%}"
local yellow="%{$fg[yellow]%}"
local blue="%{$fg[blue]%}"
local magenta="%{$fg[magenta]%}"
local white="%{$fg[white]%}"
local greenb="%{$fg_bold[green]%}"
local redb="%{$fg_bold[red]%}"
local cyanb="%{$fg_bold[cyan]%}"
local yellowb="%{$fg_bold[yellow]%}"
local blueb="%{$fg_bold[blue]%}"
local magentab="%{$fg_bold[magenta]%}"
local whiteb="%{$fg_bold[white]%}"
local reset="%{$reset_color%}"

local -a color_array
color_array=($greenb $redb $cyanb $yellowb $blueb $magentab $whiteb)

local username_normal_color=$greenb
local username_root_color=$redb
local hostname_root_color=$redb

# calculating hostname color with hostname characters
for i in "localhost"; local hostname_normal_color=$color_array[$[((#i))%7+1]]
local -a hostname_color
hostname_color=%(!.$hostname_root_color.$hostname_normal_color)

local current_dir_color=$blueb
local username_command="%n"
# TODO: This doesn't work on OS X Apparently
if [[ $(uname) == 'Darwin' ]]; then
    local hostname_command="$(hostname)"
else
    local hostname_command="$(hostnamectl hostname)"
fi
local current_dir="%~"

local username_output="%(!..$username_normal_color$username_command$cyan@)"
local hostname_output="$hostname_color$hostname_command$reset"
local current_dir_output="$current_dir_color$current_dir$reset"
local jobs_bg="${red}[${redb}fg: %j$reset${red}]$reset"
local last_command_output="%(?.%(!.$redb.$greenb).%F{242})"

HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=blue,fg=white,bold'

ZSH_THEME_GIT_PROMPT_PREFIX=""
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_UNTRACKED="$blueb%%"
ZSH_THEME_GIT_PROMPT_MODIFIED="$redb*"
ZSH_THEME_GIT_PROMPT_ADDED="$greenb+"
ZSH_THEME_GIT_PROMPT_STASHED="$blueb$"
ZSH_THEME_GIT_PROMPT_EQUAL_REMOTE="$greenb="
ZSH_THEME_GIT_PROMPT_AHEAD_REMOTE="$yellowb>"
ZSH_THEME_GIT_PROMPT_BEHIND_REMOTE="$yellowb<"
ZSH_THEME_GIT_PROMPT_DIVERGED_REMOTE="$redb<>"


function build_prompt(){
  # Traverse the current directory path one parent at a time until we hit the root, or a directory that contains a .git
  # directory
  dir_under_test=$(pwd)
  unset git_root
  while [[ $dir_under_test != / && ! -e $dir_under_test/.git ]]; do
    dir_under_test=$dir_under_test:h
  done

  if [[ $dir_under_test != / ]]; then
    git_root=$dir_under_test
  fi

  if [[ -n $git_root ]]; then
    repo=$(git config --get remote.origin.url | sed -r 's/^.*\:(.*)\.git/\1/')
    repo_parts=(${(s|/|)repo})
    if [[ $git_root != $PWD ]]; then
      internal_repo_path=$(echo $PWD | sed 's|'"$git_root"'/||')
    else
      internal_repo_path='~'
    fi
    repo_org="$magentab$repo_parts[1]$cyanb@$reset"
    repo_name="$magentab$repo_parts[2]$reset"
    dir="$blueb$internal_repo_path$reset"

    echo "$repo_org$repo_name:$dir%1(j. $jobs_bg.)"
  else
    echo "$username_output$hostname_output:$current_dir_output%1(j. $jobs_bg.)"
  fi
}

function git_status_info {
  local trimmed_branch truncated_branch
  if [[ -n $(git_prompt_info) ]]; then
    # this is customized for work branch naming schemes
    trimmed_branch=$(git_prompt_info | sed -r 's/.*((sc-|jira-).*).*/\1/')

    info="%25>…>$trimmed_branch%>>"
    info+=$(git_prompt_status)$(git_remote_status)

    printf %s " $whiteb($reset$yellow$info$whiteb)$reset $blue| "
  fi
}

PROMPT='$(build_prompt)'
PROMPT+=" $last_command_output%(!.#.>)$reset "
RPROMPT='$(git_status_info)%F{yellow}%D{%b %d} %F{green}%D{%H:%M}'

# Autosuggest -- requires in order: zsh-syntax-highlighting zsh-autosuggestions
if [[ "${AUTOSUGGESTION}" == "true" ]]; then
    AUTOSUGGESTION_HIGHLIGHT_STYLE='fg=008'
    ZSH_AUTOSUGGEST_CLEAR_WIDGETS=("${(@)ZSH_AUTOSUGGEST_CLEAR_WIDGETS:#(up|down)-line-or-history}")
    ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(history-substring-search-up history-substring-search-down)
fi

# Completions
if [[ "${ENHANCED_COMPLETION}" == "true" ]]; then
    # Faster! (?)
    zstyle ':completion::complete:*' use-cache 1

    # generate descriptions with magic.
    zstyle ':completion:*' auto-description 'specify: %d'

    # man page completion (command params)
    zstyle ':completion:*:manuals'    separate-sections true
    zstyle ':completion:*:manuals.*'  insert-sections   true
    zstyle ':completion:*:man:*'      menu yes select

    # colored tab complete
    zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)(?)*==34=34}:${(s.:.)LS_COLORS}")';
fi
