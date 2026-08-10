#!/usr/bin/env bash

# Hyprland Grayscale Shader Toggle Script

SHADER_PATH="$HOME/.config/hypr/shaders/grayscale.frag"

CURRENT_SHADER=$(hyprctl getoption decoration:screen_shader | grep 'str:' | awk '{print $2}')

if [ -n "$CURRENT_SHADER" ] && [ "$CURRENT_SHADER" != "[[EMPTY]]" ]; then
    hyprctl eval 'hl.config({ decoration = { screen_shader = "" } })'
    notify-send -a "Grayscale Shader" -i "display" "Grayscale Disabled" "Screen shader turned off."
else
    hyprctl eval "hl.config({ decoration = { screen_shader = \"$SHADER_PATH\" } })"
    notify-send -a "Grayscale Shader" -i "display" "Grayscale Enabled" "Screen shader turned on."
fi
