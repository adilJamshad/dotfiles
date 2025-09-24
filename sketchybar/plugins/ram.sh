#!/bin/bash

# Get memory stats from vm_stat and sysctl
pages_active=$(vm_stat | grep "Pages active" | awk '{print $3}' | sed 's/\.//')
pages_inactive=$(vm_stat | grep "Pages inactive" | awk '{print $3}' | sed 's/\.//')
pages_speculative=$(vm_stat | grep "Pages speculative" | awk '{print $3}' | sed 's/\.//')
pages_wired=$(vm_stat | grep "Pages wired down" | awk '{print $4}' | sed 's/\.//')

page_size=$(sysctl -n hw.pagesize)

# Calculate used memory
used_mem=$(( (pages_active + pages_inactive + pages_speculative + pages_wired) * page_size ))

# Convert bytes to GB
used_gb=$(echo "scale=2; $used_mem/1024/1024/1024" | bc)

# Update SketchyBar item
sketchybar --set $NAME label="${used_gb} GB"

