#!/bin/bash

source "$CONFIG_DIR/colors.sh"

sketchybar --add item net right                  \
           --set net updates=on                  \
                     label.drawing=off           \
                     icon.color=$ACTIVE_LABEL    \
                     icon.padding_left=5         \
                     script="$PLUGIN_DIR/net.sh"
           --subscribe net wifi_change

