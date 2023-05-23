#!/usr/bin/env bash

echo "Should we login to Bitwarden: ${INTERACTIVE}"
if [[ "${INTERACTIVE}" == "true" ]]; then
  echo "Starting login for Bitwarden"
  BW_SESSION=$(bw login --raw)
  bw sync
  echo export BW_SESSION=${BW_SESSION}
fi
