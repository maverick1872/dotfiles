#!/usr/bin/env bash

if [[ "${INTERACTIVE}" == "true" ]]; then
  BW_SESSION=$(bw login --raw)
  bw sync
  echo export BW_SESSION=${BW_SESSION}
fi
