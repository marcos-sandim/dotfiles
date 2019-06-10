#! /bin/bash

curl https://www.bing.com/HPImageArchive.aspx\?format\=js\&idx\=0\&n\=1\&mkt\=en-US \
  | jq --raw-output '. | .images[0].url' \
  | sed 's/^/https:\/\/www.bing.com\//' \
  | xargs wget -O /tmp/bing_wp.jpg \

convert /tmp/bing_wp.jpg -compress Lossless -background black -gravity South -resize 1920x1200 -extent 1920x1200 /tmp/bing_wp1.png
convert /tmp/bing_wp.jpg -compress Lossless -background black -gravity Center -resize 1920x1200 -extent 1920x1200 /tmp/bing_wp2.png

montage /tmp/bing_wp1.png /tmp/bing_wp2.png -geometry +0+0 -tile x1 /tmp/out.png

i3lock -i /tmp/wallpaper.png
