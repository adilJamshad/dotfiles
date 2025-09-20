#!/bin/bash

echo "called with $1"
echo "$FOCUSED_WORKSPACE"

source "$CONFIG_DIR/colors.sh"

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    sketchybar --set $NAME background.drawing=on \
                           icon.color=$ACTIVE_LABEL
else
    sketchybar --set $NAME background.drawing=off \
                           icon.color=$INACTIVE_LABEL
fi

