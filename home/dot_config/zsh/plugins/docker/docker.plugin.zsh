alias clean-images='docker images -aq | xargs docker rmi'
alias clean-containers='docker ps -aq | xargs docker rm'
alias clean-volumes='docker volume ls -q | xargs docker volume rm'

dco() {
  if [[ $1 == "ps" ]]; then
    strict_mode
    local header="Name|Status|Created At|Ports|Networks"
    local container_info=$(docker compose ps -q | xargs docker inspect --format "{{index .Config.Labels \"com.docker.compose.service\"}}|\
{{.State.Status}}|\
{{slice .Created 0 19}}|\
{{range .NetworkSettings.Ports}}{{.HostIp}}:{{.HostPort}}->{{.ContainerPort}}{{end}}|\
{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}")
    strict_mode off

    print $header'\n'$container_info | column -ts '|'
    return
  elif [[ $1 == "down" ]]; then
    command docker compose "$@" --remove-orphans
    return
  fi

  command docker compose "$@"
}

# Traverses directory structure and updates all docker images
update-containers() {
  strict_mode
  for dir in $(find ${DOCKER_CONTAINERS_DIR} -maxdepth 1 -mindepth 1 -type d); do
    composeSpec=$(basename $dir)
    pushd $dir 
    if [[ `docker compose ps -q 2> /dev/null` ]]; then
      echo "Updating containers for spec: $composeSpec"
      docker compose pull -q && docker compose up --no-recreate -d
    else
      echo "Updating images for spec: $composeSpec"
      docker compose pull -q
    fi
    popd
  done
  strict_mode off
}

docker-volumes() {
  volumes=$(docker volume ls  --format '{{.Name}}')

  for volume in $volumes
  do
    echo $volume
    docker ps -a --filter volume="$volume"  --format '{{.Names}}' | sed 's/^/  /'
  done
}
