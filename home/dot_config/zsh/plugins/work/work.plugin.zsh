cloudflare() {
  strict_mode
  service_running=$(systemctl is-active warp-svc.service)
  
  if [[ $service_running != "active" ]]; then
    sudo systemctl start warp-svc.service
		sleep 1
  fi

  if [[ $1 == "on" ]]; then
		echo "Connecting to Cloudflare..."
    command warp-cli connect
  elif [[ $1 == "off" ]]; then
		echo "Disconnecting from Cloudflare..."
    command warp-cli disconnect
  elif [[ $1 == "status" ]]; then
    command warp-cli status
  fi

  strict_mode off
}
