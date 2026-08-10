#!/usr/bin/env bash

# Caffeine/Idle Inhibitor toggle script for Hyprland
# Allows manual toggling of hypridle to keep the system awake.

enable_caffeine() {
    if pgrep -x "hypridle" > /dev/null; then
        pkill -x hypridle
    fi
    notify-send -a "Caffeine" -i "coffee" "Caffeine Active" "System sleep and lock disabled."
}

disable_caffeine() {
    if ! pgrep -x "hypridle" > /dev/null; then
        # Start hypridle in the background, fully detached
        nohup hypridle >/dev/null 2>&1 &
        disown
        # Wait a tiny bit to make sure it starts successfully
        sleep 0.1
    fi
    notify-send -a "Caffeine" -i "coffee" "Caffeine Inactive" "System sleep and lock enabled."
}

toggle_caffeine() {
    if pgrep -x "hypridle" > /dev/null; then
        enable_caffeine
    else
        disable_caffeine
    fi
}

status_caffeine() {
    if pgrep -x "hypridle" > /dev/null; then
        echo "Inactive" # Caffeine is inactive (hypridle is running)
    else
        echo "Active" # Caffeine is active (hypridle is paused/stopped)
    fi
}

status_json() {
    if pgrep -x "hypridle" > /dev/null; then
        # Caffeine is inactive (hypridle is running)
        echo '{"text": "", "alt": "inactive", "class": "inactive", "tooltip": "Caffeine Inactive"}'
    else
        # Caffeine is active (hypridle is stopped)
        echo '{"text": "", "alt": "active", "class": "active", "tooltip": "Caffeine Active"}'
    fi
}

case "$1" in
    --enable)
        enable_caffeine
        ;;
    --disable)
        disable_caffeine
        ;;
    --status)
        status_caffeine
        ;;
    --waybar)
        status_json
        ;;
    --toggle|*)
        toggle_caffeine
        ;;
esac
