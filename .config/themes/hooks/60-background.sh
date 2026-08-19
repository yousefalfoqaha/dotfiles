#!/usr/bin/env bash
source "$HOME/.config/themes/current/base16.sh"

if [ -n "$BACKGROUND" ]; then
    BG_DIR="$HOME/.config/backgrounds"
    TARGET="$BG_DIR/$BACKGROUND"
    SYMLINK="$HOME/.config/backgrounds/current"

    if [ -f "$TARGET" ]; then
        ln -sf "$TARGET" "$SYMLINK"
        swaymsg output "*" bg "$TARGET" fill
    fi
fi
