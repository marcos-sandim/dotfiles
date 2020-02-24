#!/bin/bash
coproc acpi_listen
trap 'kill $COPROC_PID' EXIT

while read -u "${COPROC[0]}" -a event; do
    echo "${event[@]}"
done
