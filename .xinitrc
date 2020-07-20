#!/bin/bash

#xrandr --setprovideroutputsource modesetting NVIDIA-0
#xrandr --auto

xrandr --output eDP-1-1 --mode 1920x1080 --rate 59.93

# shellcheck source=.xprofile
[ -f ~/.xprofile ] && source ~/.xprofile

systemctl --user import-environment DISPLAY

exec bspwm

