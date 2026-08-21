#!/usr/bin/env bash

if pgrep -x "wlsunset" > /dev/null; then
    pkill -x "wlsunset"
    notify-send -h string:x-canonical-private-synchronous:nightlight \
                -t 2000 "nightlight" "disabled"
else
    wlsunset -t 4000 -T 4001 &
    
    notify-send -h string:x-canonical-private-synchronous:nightlight \
                -t 2000 "nightlight" "enabled (4000K)"
fi
