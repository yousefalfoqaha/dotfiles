#!/usr/bin/env bash

THEMES="$HOME/.config/themes"
CURRENT="$THEMES/current"

CHOICE=$(find "$THEMES" -maxdepth 1 -type f -name "*.sh" -exec basename {} .sh \; | tofi --prompt-text="theme: ")
[ -z "$CHOICE" ] && exit 1

ln -sf "$THEMES/$CHOICE.sh" "$CURRENT/base16.sh"

for hook in "$THEMES/hooks/"*; do
    if [ -x "$hook" ]; then
        "$hook"
    fi
done
