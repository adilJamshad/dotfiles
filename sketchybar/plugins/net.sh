
#!/bin/bash

source "$CONFIG_DIR/resources.sh"
source "$CONFIG_DIR/colors.sh"

services=$(networksetup -listnetworkserviceorder)
device=$(scutil --nwi | sed -n "s/.*Network interfaces: \([^,]*\).*/\1/p" | awk '{print $1}')

if [[ -n "$device" ]]; then
  service=$(echo "$services" \
    | sed -n "s/.*Hardware Port: \([^,]*\), Device: $device.*/\1/p")
fi

echo "DEBUG: service=$service"

color=$ACTIVE_LABEL
case "$service" in
  "iPhone USB")         icon=$NET_USB ;;
  "Thunderbolt Bridge") icon=$NET_THUNDERBOLT ;;
  "Wi-Fi")
    ssid=$(networksetup -getairportnetwork "$device" \
      | sed -n "s/Current Wi-Fi Network: \(.*\)/\1/p")
    case "$ssid" in
      *iPhone*) icon=$NET_HOTSPOT ;;
      "")       icon=$NET_DISCONNECTED;;
      *)        icon=$NET_WIFI ;;
    esac ;;
  *)
    wifi_device=$(echo "$services" \
      | sed -n "s/.*Hardware Port: Wi-Fi, Device: \([^\)]*\).*/\1/p")
    if [[ -n "$wifi_device" ]]; then
      status=$(networksetup -getairportpower "$wifi_device" | awk '{print $NF}')
    fi
    if [[ "$status" == "On" ]]; then
      icon=$NET_DISCONNECTED
    else
      icon=$NET_OFF
    fi
esac

sketchybar --animate sin 5 --set net icon="$icon" icon.color="$color"

