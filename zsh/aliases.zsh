# General
alias please='sudo'
alias catn='cat -n'
alias list-path-dirs='sed "s/:/\n/g" <<< "$PATH"'
alias update-system='sudo apt update -y && sudo apt upgrade -y'

# GIT
alias glo='git log --pretty=format:"%Cred%cs%Creset - %C(auto)%h%Creset - %<(16,trunc)%Cgreen%an%Creset - %s %C(auto)%d" --date=local'
alias gcuwm='gau && gcmsg'
alias gbdlocal='git branch -r | awk '{print $1}' | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk '{print $1}' | xargs git branch -d'
#alias git-rm-local-merged='git branch -d $(git branch --merged | cut -c 3- | grep -i -v master | grep -i -v develop | grep -i -v integration | grep -v "*")'
#alias git-list-merged='git branch --merged | cut -c 3- | grep -i -v master | grep -i -v develop | grep -i -v integration | grep -v "*"'
#alias git-list-not-merged='git branch --no-merged | cut -c 3- | grep -i -v master | grep -i -v develop | grep -i -v integration | grep -v "*"'
#alias branch-list='git branch | cut -c 3- | grep -i -v master | grep -i -v develop | grep -i -v integration | grep -v "*"'
#alias stash-list='git stash list | cat'

# Docker & Docker Compose
alias dco='docker-compose'

# NODE & NPM
alias update-npm='npm install -g npm'

# Configurations
alias reload-zsh='source ~/.zshrc'
alias edit-zshconfig='vim ~/.zshrc'
alias edit-common-aliases='vim ${ZSH_CUSTOM}/aliases.zsh'
alias edit-private-aliases='vim ${ZSH_CUSTOM}/private-aliases.zsh'
alias edit-functions='vim ${ZSH_CUSTOM}/functions.zsh'
