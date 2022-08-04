#!/bin/sh

xrandr --output DisplayPort-0 --mode 1920x1200 --pos 0x0 --rotate left  \
  --output DisplayPort-1 --mode 3440x1440 --pos 1200x0 --rotate normal \
  --output DisplayPort-2 --off \
  --output HDMI-A-0 --off \
  --output DisplayPort-3 --mode 1920x1200 --pos 4640x360 --rotate right \
  --output DisplayPort-4 --off
