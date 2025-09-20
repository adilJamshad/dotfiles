#!/bin/bash
source "$CONFIG_DIR/colors.sh"

sketchybar --add event aerospace_workspace_change

for sid in $(aerospace list-workspaces --all); do
    sketchybar --add item "space.$sid" left \
        --subscribe "space.$sid" aerospace_workspace_change \
        --set "space.$sid" \
        icon="$sid"\
                              icon.padding_left=10                          \
                              icon.padding_right=10                         \
                              label.padding_right=10                        \
                              background.color=$ACCENT_COLOR \
                              background.corner_radius=5 \
                              background.height=30 \
                              background.drawing=off                         \
                              label.font="sketchybar-app-font:Regular:16.0" \
                              label.background.height=30                    \
                              label.background.drawing=on                   \
                              background.color=$ACCENT_COLOR             \
                              label.background.corner_radius=9              \
                              icon.color=$INACTIVE_LABEL   \
                              label.drawing=off                             \
        click_script="aerospace workspace $sid" \
        script="$CONFIG_DIR/plugins/aerospacer.sh $sid"
done

# sketchybar   --add item       separator left                          \
#              --set separator  icon=                                  \
#                               icon.font="JetBrainsMono Nerd Font:Regular:16.0" \
#                               background.padding_left=10              \
#                               background.padding_right=10             \
#                               label.drawing=off                       \
#                               associated_display=active               \
#                               icon.color=$WHITE

# SPACE_SIDS=(1 2 3 4 5 6)
#
# for sid in "${SPACE_SIDS[@]}"
# do
#   sketchybar --add space space.$sid left                                 \
#              --set space.$sid space=$sid                                 \
#                               icon=$sid                                  \
#                               label.font="sketchybar-app-font:Regular:16.0" \
#                               label.padding_right=20                     \
#                               label.y_offset=-1                          \
#                               script="$PLUGIN_DIR/space.sh"              
# done
#
# sketchybar --add item space_separator left                             \
#            --set space_separator icon="􀆊"                                \
#                                  icon.color=$ACCENT_COLOR \
#                                  icon.padding_left=4                   \
#                                  label.drawing=off                     \
#                                  background.drawing=off                \
#                                  script="$PLUGIN_DIR/space_windows.sh" \
#            --subscribe space_separator space_windows_change                           
