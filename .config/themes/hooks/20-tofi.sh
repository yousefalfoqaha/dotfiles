#!/usr/bin/env bash

source "${XDG_CONFIG_HOME:-$HOME/.config}/dotfiles/paths.sh"
source "$DOTFILES_THEME_STATE/base16.sh"

cat << EOF > "$DOTFILES_THEME_STATE/tofi"
background-color = ${B00}d9
text-color = $B05
prompt-color = $B0D
input-color = $B05
default-result-color = $B05
placeholder-color = $B03
selection-color = $B0D
selection-match-color = $B0A
EOF
