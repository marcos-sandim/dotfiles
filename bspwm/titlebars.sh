#!/bin/bash

# use lemonboys bar to display titlebars
activeDesk=$(bspc query -M -n)
barPids=/tmp/titleBarPids$activeDesk
echo $barPids
touch $barPids
windowIds="$(bspc query -N --desktop | sort 2> /dev/null)"

if [[ "$windowIds" == "" ]];then
    kill $(cat $barPids | awk '{print $2}')
    rm $barPids
    exit 0
fi

bla=""
while read id; do

    windowTitle=$(xtitle $id)

    if [[ $windowTitle == "" ]]; then
        continue
    fi
    nodeDesc=$(bspc query -T --node $id)
    windowState=$(echo $nodeDesc | jq -r .client.state 2> /dev/null)

    if [[ $windowState == "tiled" ]]; then
        geo=$(echo $nodeDesc | jq .client.tiledRectangle 2> /dev/null)
    elif [ $windowState == "floating" ]; then
        geo=$(echo $nodeDesc | jq .client.floatingRectangle 2> /dev/null)
    else
        continue
    fi
    geoBar=$(echo $geo | jq -r '"\(.width)x16+\(.x)+\(.y-16)"')

    bla="${bla}${id}${geoBar}"
done <<< "$windowIds"

bla2=$(cat $barPids | awk 'BEGIN{ORS=""}{print $1}')

echo bla @${bla}@
echo bar *$bla2*

if [[ $bla == $bla2 ]]; then
    echo "same"
    exit 0
fi

kill $(cat $barPids | awk '{print $2}')
rm $barPids

echo "$windowIds"| while read id; do

    windowTitle=$(xtitle $id)

    if [[ $windowTitle == "" ]]; then
        continue
    fi

    nodeDesc=$(bspc query -T --node $id)
    windowState=$(echo $nodeDesc | jq -r .client.state 2> /dev/null)

    if [[ $windowState == "tiled" ]]; then
        geo=$(echo $nodeDesc | jq .client.tiledRectangle 2> /dev/null)
    elif [ $windowState == "floating" ]; then
        geo=$(echo $nodeDesc | jq .client.floatingRectangle 2> /dev/null)
    else
        continue
    fi
    geoBar=$(echo $geo | jq -r '"\(.width)x16+\(.x)+\(.y-16)"')

    if [[ $geoBar == "" ]]; then
        continue
    fi

    echo "%{c}$windowTitle"| lemonbar -g $geoBar -p -d &
    barPid=$!
    echo $id${geoBar} ${barPid} >> $barPids
done

#!ps aux | grep lemonbar


#!cat /tmp/titleBarPids
