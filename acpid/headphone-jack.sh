#!/usr/bin/env bash
set -e -u

if [ "$1" = "jack/headphone" -a "$2" = "HEADPHONE" ]; then

  SOURCE="alsa_input.pci-0000_00_1f.3.analog-stereo"

  case "$3" in
    plug)
      SOURCE_PORT='analog-input-headset-mic'
      ;;
    *)
      SOURCE_PORT='analog-input-internal-mic'
      ;;
  esac

  for userdir in /run/user/*; do

    uid="$(basename $userdir)"
    user="$(id -un $uid)"
    if [ -f "$userdir/pulse/pid" ]; then

      PULSE_RUNTIME_PATH="$userdir/pulse" su "$user" -c "pactl set-source-port $SOURCE '$SOURCE_PORT'"

    fi

  done

fi
