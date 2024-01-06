alias clean-images='docker images -aq | xargs docker rmi'
alias clean-containers='docker ps -aq | xargs docker rm'
alias clean-volumes='docker volume ls -q | xargs docker volume rm'

dco() {
# Can be improved with a proper jq function? https://stackoverflow.com/questions/62665537/how-to-calculate-time-duration-from-two-date-time-values-using-jq
  if [[ $1 == "ps" ]]; then
    local header="NAME\tSERVICE\tSTATUS\tCREATED\tPORTS"
    local containerDeets=$(command docker compose ps --format json)
    local formattedDeets=$(echo $containerDeets | jq -r '[
      .Name,
      .Service,
      .Status,
      (.CreatedAt | if type=="number" then (.|strflocaltime("%Y-%m-%dT%H:%M:%S")) else . end),
      (if .Publishers then (.Publishers | map(.PublishedPort) | unique | .[]) else "none" end)
		] | @tsv')
    print $header'\n'$formattedDeets | column -ts $'\t'
    return
  fi;

  command docker compose "$@"
}

# Traverses directory structure and updates all docker images
update-docker-containers() {
  for dir in $(find ${DOCKER_DIR} -maxdepth 1 -mindepth 1 -type d); do
    containerName=$(basename $dir)
    cd $dir || return
    if [[ `docker compose ps -q 2> /dev/null` ]]; then
      echo "Updating container: $containerName"
      docker compose pull && docker compose up --force-recreate --build -d
      cd - > /dev/null || return
    else
      echo "Container is not running: $containerName"
    fi
    echo
  done
}

# List IPs of all running docker containers for each network they are attached to
docker-ips() {
  docker ps --format "table {{.ID}}|{{.Names}}|{{.Status}}" | while read line; do
    if $(echo $line | grep -q 'CONTAINER ID'); then
      output="${line}|IP ADDRESSES\n"
    else
      CID=$(echo $line | awk -F '|' '{print $1}')
      IP=$(docker inspect $CID | jq -r ".[0].NetworkSettings.Networks | to_entries[] | \"\(.key): \(.value.IPAddress)\"")
      output+="${line}|${IP}\n"
    fi
  done
  echo $output | column -t -s '|'
}

docker-volumes() {
  volumes=$(docker volume ls  --format '{{.Name}}')

  for volume in $volumes
  do
    echo $volume
    docker ps -a --filter volume="$volume"  --format '{{.Names}}' | sed 's/^/  /'
  done
}
