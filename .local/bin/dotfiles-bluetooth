#!/usr/bin/env bash

if ! command -v bluetoothctl >/dev/null 2>&1 || [ -z "$(bluetoothctl list 2>/dev/null)" ]; then
    exit 0
fi

chosen=$(bluetoothctl devices | sed 's/^Device //g' | awk '{ mac=$1; $1=""; sub(/^ /, ""); print $0 " - " mac }' | tofi --prompt-text="bluetooth: ")
[ -z "$chosen" ] && exit 0

mac=$(echo "$chosen" | awk '{print $NF}')
name=$(echo "$chosen" | sed -E "s/ - $mac$//")

if bluetoothctl info "$mac" | grep -q "Connected: yes"; then
    notify-send -h string:x-canonical-private-synchronous:bluetooth -t 2000 "bluetooth" "disconnecting $name..."
    bluetoothctl disconnect "$mac"
else
    notify-send -h string:x-canonical-private-synchronous:bluetooth -t 2000 "bluetooth" "connecting to $name..."
    bluetoothctl connect "$mac"
fi
