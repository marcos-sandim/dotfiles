#!/bin/sh

str="$*"
echo -n "$str" | xclip -selection clipboard
