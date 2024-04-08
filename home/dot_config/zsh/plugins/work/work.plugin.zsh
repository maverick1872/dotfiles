cloudflare() {
  strict_mode
  service_running=$(systemctl is-active --quiet warp-svc.service)
  
  if [[ $service_running == "NO" ]]; then
    sudo systemctl start warp-svc.service
  fi

  if [[ $1 == "on" ]]; then
    command warp-cli connect
  elif [[ $1 == "off" ]]; then
    command warp-cli disconnect
  fi

  strict_mode off
}
