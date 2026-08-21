#!/usr/bin/env bash

OPTIONS="Poweroff\nReboot\nLogout"

CHOICE=$(echo -e "$OPTIONS" | tofi --prompt-text="system: ")

case "$CHOICE" in
    "Poweroff")
        systemctl poweroff
        ;;
    "Reboot")
        systemctl reboot
        ;;
    "Logout")
        swaymsg exit
        ;;
esac
