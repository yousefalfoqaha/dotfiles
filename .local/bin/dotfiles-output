#!/usr/bin/env bash

declare -A SINK_MAP
MENU_OPTIONS=""

RAW_SINKS=$(wpctl status | awk '/Sinks:/{f=1; next} /^[ \t]*(├─|└─)/{f=0} f' | grep -E '[0-9]+\.')

while IFS= read -r line; do
    [ -z "$line" ] && continue

    ID=$(echo "$line" | grep -oE '[0-9]+' | head -n 1)
    DESC=$(echo "$line" | sed -E -e 's/^[^0-9]*[0-9]+\.[ \t]*//' -e 's/\[.*\]//g' -e 's/[ \t]+$//')

    if [[ "$line" == *"*"* ]]; then
        DISPLAY="* $DESC"
    else
        DISPLAY="$DESC"
    fi

    SINK_MAP["$DISPLAY"]="$ID"

    if [ -n "$MENU_OPTIONS" ]; then
        MENU_OPTIONS+="\n$DISPLAY"
    else
        MENU_OPTIONS="$DISPLAY"
    fi
done <<< "$RAW_SINKS"

if [ -z "$MENU_OPTIONS" ]; then
    exit 1
fi

CHOICE=$(echo -e "$MENU_OPTIONS" | tofi --prompt-text "output: ")

if [ -n "$CHOICE" ]; then
    SELECTED_ID="${SINK_MAP["$CHOICE"]}"
    if [ -n "$SELECTED_ID" ]; then
        wpctl set-default "$SELECTED_ID"
    fi
fi
