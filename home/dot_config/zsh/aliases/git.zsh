alias gst='git status'
# Overwrite ghostscript cause it's annoying
alias gs='gst'
alias glo='git log --pretty=format:"%Cred%cs%Creset - %C(auto)%h%Creset - %<(16,trunc)%Cgreen%an%Creset - %s %C(auto)%d" --date=local'
alias gcuwm='gau && gcmsg'
alias gdom='git diff origin/$(git_main_branch)'
alias gdod='git diff origin/$(git_develop_branch)'
alias gbdlocal='git branch -r | awk '{print $1}' | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk '{print $1}' | xargs git branch -d'
