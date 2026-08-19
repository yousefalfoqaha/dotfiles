#!/usr/bin/env bash

BG_DIR="$HOME/.config/backgrounds"
SYMLINK="$HOME/.config/backgrounds/current"

CURRENT_BG=""
if [ -L "$SYMLINK" ]; then
    CURRENT_BG=$(basename "$(readlink -f "$SYMLINK")")
fi

OPTIONS=$(find "$BG_DIR" -maxdepth 1 -type f ! -name "current" \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) -exec basename {} \; | while read -r file; do
    if [ "$file" = "$CURRENT_BG" ]; then
        echo "* $file"
    else
        echo "$file"
    fi
done)

if [ -z "$OPTIONS" ]; then
    exit 1
fi

CHOICE=$(echo -e "$OPTIONS" | tofi --prompt-text="background: ")

if [ -n "$CHOICE" ]; then
    CLEAN_CHOICE="${CHOICE#\* }"
    TARGET="$BG_DIR/$CLEAN_CHOICE"

    ln -sf "$TARGET" "$SYMLINK"
    swaymsg output "*" bg "$TARGET" fill
fi
