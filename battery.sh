#!/bin/sh

bat_state=$(upower -i /org/freedesktop/UPower/devices/battery_BAT1 | grep "state: " | awk '{print $2}')
bat_percent=$(upower -i /org/freedesktop/UPower/devices/battery_BAT1 | grep "percentage: " | awk '{print $2}' | sed 's/[^[:digit:]]//g')

echo $bat_state
echo $bat_percent

if [ $bat_state != 'charging' ]; then
	if [ $bat_percent -lt 15 ]; then
		#/bin/xcowsay --image=/home/sandim/Desktop/beefy-miracle.png --bubble-at=-50,-80 -t 0 "BATTERY LOW!"
		/bin/xcowsay --image=/home/sandim/Desktop/battery.png --left --bubble-at=0,0 -t 0 "oooohhhh shiiiiit!!"
	fi
fi
