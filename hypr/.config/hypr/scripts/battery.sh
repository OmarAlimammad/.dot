#!/bin/bash

THRESHOLD=30
CHECK_INTERVAL=30

STATE_FILE="/tmp/battery_low_notified"

while true; do
  if [ -d "/sys/class/power_supply/BAT0" ]; then
    BATTERY_CAPACITY=$(cat /sys/class/power_supply/BAT0/capacity)
    BATTERY_STATUS=$(cat /sys/class/power_supply/BAT0/status)
  else
    BATTERY_CAPACITY=$(cat /sys/class/power_supply/BAT*/capacity | head -n 1)
    BATTERY_STATUS=$(cat /sys/class/power_supply/BAT*/status | head -n 1)
  fi

  if [ "$BATTERY_STATUS" = "Discharging" ] && [ "$BATTERY_CAPACITY" -le "$THRESHOLD" ]; then
    if [ ! -f "$STATE_FILE" ]; then
      notify-send -u critical \
        -a "System" \
        -i "battery-low" \
        "Battery Low" \
        "Battery has dropped to ${BATTERY_CAPACITY}%. Please plug in your charger."

      touch "$STATE_FILE"
    fi
  else
    if [ -f "$STATE_FILE" ]; then
      rm "$STATE_FILE"
    fi
  fi

  sleep "$CHECK_INTERVAL"
done
