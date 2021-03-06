#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

displays=($(xrandr | awk '/\ connected/ && /[[:digit:]]x[[:digit:]].*+/{printf ("%s\n",$1) }' | sort))

eth=$(ls /sys/class/net | grep -i '^en')
wlan=$(ls /sys/class/net | grep -i '^wl')
ac_adap=$(ls /sys/class/power_supply | grep -i '^AC')
battery=$(ls /sys/class/power_supply | grep -i '^BAT')

volumes=($(cat /etc/fstab | sed -E '/(^#.*|^\s*$)/d' | awk '{print $2}' | sed -E '/(^none|^\/boot|^swap)/d'))

export ETH=$eth
export WLAN=$wlan

export ACADAP=$ac_adap
export BAT=$battery

if [[ -v "volumes[0]" ]] ; then
  export MOUNT0=${volumes[0]}
else
  export MOUNT0='/BATATA'
fi

if [[ -v "volumes[1]" ]] ; then
  export MOUNT1=${volumes[1]}
else
  export MOUNT1='/BATATA'
fi

if [[ -v "volumes[2]" ]] ; then
  export MOUNT2=${volumes[2]}
else
  export MOUNT2='/BATATA'
fi

if [[ -v "volumes[3]" ]] ; then
  export MOUNT3=${volumes[3]}
else
  export MOUNT3='/BATATA'
fi

#if [[ $(wc -l <<< "$displays") = 2 ]]; then
if [[ ${#displays[@]} = 2 ]]; then
    # Launch bar1 and bar2
    MONITOR=${displays[1]} polybar main_bar &
    MONITOR=${displays[0]} polybar secondary_bar &
else
    MONITOR=${displays[0]} polybar main_bar &
fi

echo "Bars launched..."
