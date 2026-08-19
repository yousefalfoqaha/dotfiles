#!/usr/bin/env bash

BAT_DIR=""
for b in /sys/class/power_supply/BAT*; do
    if [ -d "$b" ]; then
        BAT_DIR="$b"
        break
    fi
done

while true; do
    if ! command -v bluetoothctl >/dev/null 2>&1; then
        BT_STR="bt n/a"
    elif ! bluetoothctl show 2>/dev/null | grep -q "Powered: yes"; then
        BT_STR="bt off"
    else
        BT_CONNS=$(bluetoothctl devices Connected 2>/dev/null | wc -l)
        if [ "$BT_CONNS" -gt 0 ]; then
            BT_STR="bt ${BT_CONNS}"
        else
            BT_STR="bt"
        fi
    fi

    if ! command -v nmcli >/dev/null 2>&1; then
        NET_STR="net n/a"
    else
        if nmcli -t -f TYPE,STATE dev 2>/dev/null | grep -q -E '^(wifi|802-11-wireless):connected'; then
            SIGNAL=$(nmcli -t -f IN-USE,SIGNAL dev wifi 2>/dev/null | grep '^\*' | cut -d':' -f2 | head -n1)
            NET_STR="wifi ${SIGNAL}%"
        elif nmcli -t -f TYPE,STATE dev 2>/dev/null | grep -q -E '^(ethernet|802-3-ethernet):connected'; then
            NET_STR="eth"
        else
            NET_STR="offline"
        fi
    fi

    VOL_RAW=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null || echo "Volume: 0")
    if [[ "$VOL_RAW" == *"MUTED"* ]]; then
        VOL_STR="muted"
    else
        VOL_PCT=$(echo "$VOL_RAW" | awk '{print int($2 * 100)}')
        VOL_STR="vol ${VOL_PCT}%"
    fi

    if [ -n "$BAT_DIR" ] && [ -f "$BAT_DIR/capacity" ]; then
        BAT_CAP=$(< "$BAT_DIR/capacity")
        BAT_STAT=$(< "$BAT_DIR/status")
        
        case "$BAT_STAT" in
            "Charging")    BAT_STR="chr ${BAT_CAP}%" ;;
            "Full")        BAT_STR="bat full" ;;
            "Discharging") BAT_STR="bat ${BAT_CAP}%" ;;
            *)             BAT_STR="bat ${BAT_CAP}%" ;;
        esac
    else
        BAT_STR="no bat"
    fi

    TIME_STR=$(date +'%I:%M %p')

    echo "$BT_STR :: $NET_STR :: $VOL_STR :: $BAT_STR :: $TIME_STR"

    sleep 1
done
