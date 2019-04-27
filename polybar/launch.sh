#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

displays=$(xrandr | awk '/\ connected/ && /[[:digit:]]x[[:digit:]].*+/{printf ("%s\n",$1) }')

if [[ $(wc -l <<< "$displays") = 2 ]]; then
    # Launch bar1 and bar2
    MONITOR=HDMI-1 polybar main_bar &
    MONITOR=eDP-1 polybar secondary_bar &
else
    MONITOR=eDP-1 polybar main_bar &
fi

echo "Bars launched..."
