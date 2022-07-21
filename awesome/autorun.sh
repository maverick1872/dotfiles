#!/bin/sh

xrandr --output DisplayPort-0 --off \
  --output DisplayPort-1 --mode 1920x1200 --pos 0x0 --rotate left \
  --output DisplayPort-2 --off \
  --output HDMI-A-0 --off \
  --output DisplayPort-3 --mode 1920x1200 --pos 1200x360 --rotate normal \
  --output DisplayPort-4 --off \
  --output DisplayPort-5 --mode 1920x1200 --pos 3120x0 --rotate right \
  --output DisplayPort-6 --off
