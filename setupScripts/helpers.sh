#!/usr/bin/env bash

promptUser() {
  echo -e "$1 (Yy/Nn)\c"
  read -r answer
  if [[ $answer != "${answer#[Yy]}" ]]; then
    return 0
  else
    return 1
  fi
}