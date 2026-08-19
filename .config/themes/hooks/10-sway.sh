#!/usr/bin/env bash
source "$HOME/.config/themes/current/base16.sh"
CURRENT="$HOME/.config/themes/current"

cat << EOF > "$CURRENT/sway"
set \$base00 $B00
set \$base01 $B01
set \$base02 $B02
set \$base03 $B03
set \$base04 $B04
set \$base05 $B05
set \$base06 $B06
set \$base07 $B07
set \$base08 $B08
set \$base09 $B09
set \$base0A $B0A
set \$base0B $B0B
set \$base0C $B0C
set \$base0D $B0D
set \$base0E $B0E
set \$base0F $B0F
EOF

if [ -n "$SWAYSOCK" ]; then
    swaymsg reload
fi
