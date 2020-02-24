#!/bin/bash

scratchesDir="$HOME/Documents/Scratch"

ls $scratchesDir | rofi -dmenu | xargs -I{} sh -c "date --rfc-3339=seconds | tr -d '\n' >> $scratchesDir/{}; echo -e ': \n========================\n' >> $scratchesDir/{};  neovide '+normal GA' $scratchesDir/{}"
