#!/usr/bin/env bash
source "$HOME/.config/themes/current/base16.sh"

if [ -n "$BACKGROUND" ]; then
    BG_DIR="$HOME/.config/backgrounds"
    TARGET="$BG_DIR/$BACKGROUND"
    SYMLINK="$HOME/.config/backgrounds/current"

    if [ -f "$TARGET" ]; then
        ln -sf "$TARGET" "$SYMLINK"

        if [ -n "$SWAYSOCK" ]; then
            swaymsg output "*" bg "$TARGET" fill
        fi
    fi
fi
