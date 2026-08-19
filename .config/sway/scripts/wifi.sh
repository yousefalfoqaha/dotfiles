#!/usr/bin/env bash

known=$(nmcli -t -f NAME,TYPE connection | grep ':802-11-wireless$' | sed 's/:802-11-wireless$//' | sed 's/\\:/:/g')
available_with_signal=$(nmcli -t -f SSID,SIGNAL device wifi list | grep -v '^:' | sort -t: -k2 -nr | awk -F: '!seen[$1]++')
active=$(nmcli -t -f NAME,TYPE,STATE connection | grep ':802-11-wireless:activated$' | cut -d: -f1 | sed 's/\\:/:/g')

menu_items=$(echo "$available_with_signal" | while IFS=: read -r ssid signal; do
    if echo "$known" | grep -Fxq "$ssid"; then
        if [ "$ssid" = "$active" ]; then
            printf "* %s - %s%%\n" "$ssid" "$signal"
        else
            printf "  %s - %s%%\n" "$ssid" "$signal"
        fi
    fi
done)

if [ -z "$menu_items" ]; then
    notify-send "wifi" "no known networks in range."
    exit 0
fi

chosen_raw=$(echo "$menu_items" | tofi --prompt-text="wifi: ")
[ -z "$chosen_raw" ] && exit 0
chosen=$(echo "$chosen_raw" | sed -E 's/^..//; s/ - [0-9]+%$//')

if [ "$chosen" = "$active" ]; then
    notify-send "wifi" "disconnecting from $chosen..."
    if nmcli connection down id "$chosen" > /dev/null 2>&1; then
        notify-send "wifi" "disconnected from $chosen"
    else
        notify-send "wifi" "failed to disconnect from $chosen"
    fi
    exit 0
fi

notify-send "wifi" "connecting to $chosen..."

if nmcli connection up id "$chosen" > /dev/null 2>&1; then
    notify-send "wifi" "connected to $chosen"
else
    notify-send "wifi" "failed to connect to $chosen"
fi
