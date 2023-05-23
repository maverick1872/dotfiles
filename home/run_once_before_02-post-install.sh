#!/usr/bin/env bash

BW_SESSION=$(bw login --raw)
bw sync
echo export BW_SESSION=${BW_SESSION}
