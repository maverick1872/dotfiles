alias clean-images='docker images -aq | xargs docker rmi'
alias stop-containers='docker ps -aq | xargs docker stop'
alias clean-containers='docker ps -aq | xargs docker rm'
alias clean-volumes='docker volume ls -q | xargs docker volume rm'

make_completion_wrapper() {
  eval "_$1 () {
    COMP_LINE=\${COMP_LINE/$1/$2}
    COMP_POINT=\$((\$COMP_POINT + ${#2} - ${#1}))
    _$(cut -d" " -f1 <<< $2)
  }
  complete -F _$1 $1
  "
}

compdefas () {
  if (($+_comps[$1])); then
    compdef $_comps[$1] ${^@[2,-1]}=$1
  fi
}


dco() {
  local subcommand=$1
  shift || true

  case "$subcommand" in
    ps)
      # Ensure we only run inspect if containers exist
      local container_ids
      container_ids=("${(@f)$(docker compose ps -q)}")
      if [[ -z $container_ids ]]; then
        echo "No containers found."
        return
      fi

      local header="Name|Status|Created At|Ports|Networks"
      local container_info=""
      local raw_container_info_json

      raw_container_info_json=$(docker inspect "${container_ids[@]}")

      container_info=$(jq -r '
        def age_string($seconds):
          if $seconds < 60 then "\($seconds)s"
          elif $seconds < 3600 then "\(($seconds / 60) | floor)m"
          elif $seconds < 86400 then "\(($seconds / 3600) | floor)h"
          else "\(($seconds / 86400) | floor)d"
          end;

        
        .[] |
        [
          .Config.Labels["com.docker.compose.service"],
          .State.Status + (if .State.Health? then " (" + .State.Health.Status + ")" else "" end),
          (.Created | sub("\\..*"; "")),
          (
            .NetworkSettings.Ports
            | to_entries
            | map(select(.value != null) | "\(.value[0].HostIp):\(.value[0].HostPort) -> \(.key)")
            | join(" ")
          ),
          (
            .NetworkSettings.Networks
            | to_entries
            | map("\(.key):\(.value.IPAddress)")
            | join(" ")
          )
        ] | @tsv
      ' <<< "$raw_container_info_json" | sed 's/\t/|/g')

      echo -e "$header\n$container_info" | column -ts '|'
      ;;

    down)
      docker compose down --remove-orphans "$@"
      ;;

    up)
      docker compose up -d "$@"
      ;;

    *)
      docker compose "$subcommand" "$@"
      ;;
  esac
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

function recreate_docker_volume() {
  docker volume rm $1
  docker volume create $1
}
