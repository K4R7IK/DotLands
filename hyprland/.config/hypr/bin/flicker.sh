#!/usr/bin/env bash

if [[ $(hyprctl getoption opengl:nvidia_anti_flicker -j | jq .int) == "1" ]]; then
  hyprctl keyword opengl:nvidia_anti_flicker false && notify-send "60 FPS" 
else
  hyprctl keyword opengl:nvidia_anti_flicker true && notify-send "30 FPS" 
fi
