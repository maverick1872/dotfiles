alias clean-images='docker images -aq | xargs docker rmi'
alias clean-containers='docker ps -aq | xargs docker rm'
alias clean-volumes='docker volume ls -q | xargs docker volume rm'

