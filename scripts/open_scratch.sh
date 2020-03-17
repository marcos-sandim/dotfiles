#!/bin/bash

scratchesDir="$HOME/Scratchpads"

ls $scratchesDir | rofi -dmenu | xargs -I{} sh -c "date --rfc-3339=seconds | tr -d '\n' >> $scratchesDir/{}; echo -e ': \n========================\n' >> $scratchesDir/{};  alacritty -e nvim '+normal GA' $scratchesDir/{}"

# extensions=$(cat <<- EXTS
# sql
# txt
# md
# EXTS
# )
#
# echo "$extensions" | rofi -dmenu | xargs ~/.local/bin/scratchpad
