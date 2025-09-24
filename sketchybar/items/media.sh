#!/bin/bash

source "$CONFIG_DIR/colors.sh"

sketchybar --add item media e \
           --set media label.color=$ACTIVE_LABEL \
                       label.max_chars=20 \
                       icon.padding_left=5 \
                       scroll_texts=on \
                       icon=󰲹             \
                       icon.color=$ACTIVE_LABEL   \
                       background.color=$ACCENT_COLOR \
                       background.drawing=off \
                       script="$PLUGIN_DIR/media.sh" \
           --subscribe media media_change

