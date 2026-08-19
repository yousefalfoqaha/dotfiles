#!/usr/bin/env bash

chosen=$(bluetoothctl devices | sed 's/^Device //g' | awk '{ mac=$1; $1=""; sub(/^ /, ""); print $0 " - " mac }' | tofi --prompt-text="bluetooth: ")
[ -z "$chosen" ] && exit 0

mac=$(echo "$chosen" | awk '{print $NF}')
name=$(echo "$chosen" | sed -E "s/ - $mac$//")

if bluetoothctl info "$mac" | grep -q "Connected: yes"; then
    notify-send "bluetooth" "disconnecting $name..."
    bluetoothctl disconnect "$mac"
else
    notify-send "bluetooth" "connecting to $name..."
    bluetoothctl connect "$mac"
fi
