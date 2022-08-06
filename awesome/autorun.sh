#!/bin/sh

xrandr \
  --output DisplayPort-0 --mode 3440x1440 --pos 1200x75 --rotate normal \
  --output DisplayPort-1 --off \
  --output DisplayPort-2 --mode 1920x1200 --pos 0x0 --rotate left  \
  --output HDMI-A-0 --off \
  --output DisplayPort-3 --mode 1920x1200 --pos 4640x0 --rotate right \
  --output DisplayPort-4 --off
