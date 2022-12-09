#!/bin/sh

# Display configurations
#xrandr --output DisplayPort-0 --mode 3440x1440 --pos 1200x75 --rotate normal
#xrandr --output DisplayPort-2 --mode 1920x1200 --pos 0x0 --rotate left
#xrandr --output DisplayPort-3 --mode 1920x1200 --pos 4640x0 --rotate right

# Potential fix for output name issue
#xrandr --newmode "2560x1440_33.00"  162.77  2560 2688 2960 3360  1440 1441 1444 1468  -HSync +Vsync
#xrandr --addmode DisplayPort-0 2560x1440_33.00
#xrandr --auto --output DisplayPort-0 --mode 2560x1440_33.00 --primary --left-of DisplayPort-1
