#!/usr/bin/env bash
source "$HOME/.config/dotfiles/paths.sh"
source "$DOTFILES_THEME_STATE/base16.sh"

if [ -n "$BACKGROUND" ]; then
    BG_DIR="$DOTFILES_BACKGROUND_DIR"
    TARGET="$BG_DIR/$BACKGROUND"
    SYMLINK="$DOTFILES_BACKGROUND_STATE"

    if [ -f "$TARGET" ]; then
        mkdir -p "$(dirname "$SYMLINK")"
        ln -sfn "$TARGET" "$SYMLINK"

        if [ -n "$SWAYSOCK" ]; then
            swaymsg output "*" bg "$TARGET" fill
        fi
    fi
fi
