#!/usr/bin/env bash

if [[ "${INTERACTIVE}" == "true" ]]; then
  echo "Start login for Bitwarden"
  BW_SESSION=$(bw login --raw)
  bw sync
  echo export BW_SESSION=${BW_SESSION}
fi
