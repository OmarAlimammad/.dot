#!/usr/bin/env bash

lock="Lock"
logout="Log Out"
suspend="Suspend"
reboot="Reboot"
shutdown="Shutdown"

options="$lock
$logout
$suspend
$reboot
$shutdown"

chosen=$(echo "$options" | rofi -dmenu -i -p "Power Menu")

case "$chosen" in
    "$lock")
        hyprlock
        ;;
    "$logout")
        loginctl terminate-user "$USER"
        ;;
    "$suspend")
        systemctl suspend
        ;;
    "$reboot")
        systemctl reboot
        ;;
    "$shutdown")
        systemctl poweroff
        ;;
esac
