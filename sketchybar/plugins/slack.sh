#!/usr/bin/env sh
source "$CONFIG_DIR/colors.sh"

STATUS_LABEL=$(lsappinfo info -only StatusLabel "Slack")
ICON="󰒱"
if [[ $STATUS_LABEL =~ \"label\"=\"([^\"]*)\" ]]; then
    LABEL="${BASH_REMATCH[1]}"

    if [[ $LABEL == "" ]]; then
        ICON_COLOR=$INACTIVE_LABEL
    elif [[ $LABEL == "•" ]]; then
        ICON_COLOR="0xffeed49f"
    elif [[ $LABEL =~ ^[0-9]+$ ]]; then
        ICON_COLOR="0xffed8796"
    else
        exit 0
    fi
else
  exit 0
fi

sketchybar --set $NAME icon=$ICON label="${LABEL}" icon.color=${ICON_COLOR}
