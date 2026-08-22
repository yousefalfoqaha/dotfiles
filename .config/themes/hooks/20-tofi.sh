#!/usr/bin/env bash

source "$HOME/.config/dotfiles/paths.sh"
source "$DOTFILES_THEME_STATE/base16.sh"
source "$DOTFILES_FONT_HOME/$(cat "$DOTFILES_FONT_STATE").sh"

cat << EOF > "$DOTFILES_THEME_STATE/tofi"
font = "$FONT_BASE, Noto Sans"
font-size = $FONT_MENU_SIZE
background-color = ${B00}d9
text-color = $B05
prompt-color = $B0D
input-color = $B05
default-result-color = $B05
placeholder-color = $B03
selection-color = $B0D
selection-match-color = $B0A
EOF

cat << EOF > "$HOME/.config/tofi/theme"
include = $DOTFILES_THEME_STATE/tofi
EOF
