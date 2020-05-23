#!/bin/sh
set -xe

setxkbmap -layout us -variant intl

exit 0

# re-execute this script as "$xuser" if that's not root, in case the root user is not permitted to access the X session.
xuser=$(ps -C Xorg -C X -ouser=)
[ $(id -un) = root ] && [ "$xuser" != root ] && exec su -c $0 "$xuser"

# First find the X input ID corresponding to the
# keyboard we're interested in.
xinput_dev_id() {
  keyboard="$1"
  xinput list |
  sed -n "s/.*$keyboard\s*id=\([0-9]*\).*keyboard.*/\1/p"
}
# In our case the USB:ID was shown in the `xinput list` output,
# but this is unusual and you may have to match
# on names or even correlate with /dev/input/by-id/*
device_id=$(xinput_dev_id 'Cooler Master Technology Inc. MasterKeys Pro M Intelligent RGB Keyboard')
#echo $device_id
[ "$device_id" ] || exit

# Write out the XKB config to remap just
# the keys we're interested in
mkdir -p /tmp/xkb/symbols
cat >/tmp/xkb/symbols/custom <<\EOF
xkb_symbols "mysymbols" {
    key <KPEN> { [ Return ] };
    key <AB11> { [ XF86Launch0 ] };
};
EOF

# Amend the current keyboard map with
# the above key mappings, and apply to the particular device.
# Note xkbcomp >= 1.2.1 is needed to support this
setxkbmap -device $device_id -print |
sed 's/\(xkb_symbols.*\)"/\1+custom(mysymbols)"/' | #sed -e '/xkb_keycodes/s/"[[:space:]]/+local&/' |
xkbcomp -I/tmp/xkb -i $device_id -synch - $DISPLAY # 2>/dev/null
