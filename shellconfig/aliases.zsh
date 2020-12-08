# General
alias please='sudo'
alias c='clear'

# GIT
#alias git-rm-local-merged='git branch -d $(git branch --merged | cut -c 3- | grep -i -v master | grep -i -v develop | grep -i -v integration | grep -v "*")'
#alias git-list-merged='git branch --merged | cut -c 3- | grep -i -v master | grep -i -v develop | grep -i -v integration | grep -v "*"'
#alias git-list-not-merged='git branch --no-merged | cut -c 3- | grep -i -v master | grep -i -v develop | grep -i -v integration | grep -v "*"'
#alias branch-list='git branch | cut -c 3- | grep -i -v master | grep -i -v develop | grep -i -v integration | grep -v "*"'
#alias stash-list='git stash list | cat'


# Configurations
alias edit-zshconfig='vim ~/.zshrc'
alias edit-aliases='vim ${ZSH_CUSTOM}/aliases'
alias reload-zshrc='source ~/.zshrc'
