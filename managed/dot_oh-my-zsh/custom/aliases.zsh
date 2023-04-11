# General
alias please='sudo'
alias catn='cat -n'
alias list-path-dirs='sed "s/:/\n/g" <<< "$PATH"'
alias lsdir='ls -d */'
alias lldir='ll -d */'
alias update-system='sudo apt update -y && sudo apt upgrade -y'

# GIT
alias glo='git log --pretty=format:"%Cred%cs%Creset - %C(auto)%h%Creset - %<(16,trunc)%Cgreen%an%Creset - %s %C(auto)%d" --date=local'
alias gcuwm='gau && gcmsg'
alias gbdlocal='git branch -r | awk '{print $1}' | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk '{print $1}' | xargs git branch -d'

# Github CLI
alias newpr='gh pr create'

# Docker & Docker Compose
#alias dco='docker compose'
alias clean-images='docker images -aq | xargs docker rmi'
alias clean-containers='docker ps -aq | xargs docker rm'
alias clean-volumes='docker volume ls -q | xargs docker volume rm'

# NODE & NPM
alias update-npm='npm install -g npm'
alias npmid='npm i -D'
alias npmip='npm i -P'

# Configurations
alias edit-zshconfig='vim ~/.zshrc'
alias edit-common-aliases='vim ${ZSH_CUSTOM}/aliases.zsh'
alias edit-private-aliases='vim ${ZSH_CUSTOM}/private-aliases.zsh'
alias edit-private-functions='vim ${ZSH_CUSTOM}/private-functions.zsh'
alias edit-functions='vim ${ZSH_CUSTOM}/functions.zsh'