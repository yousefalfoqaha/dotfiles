#!/usr/bin/env bash
source "$HOME/.config/themes/current/base16.sh"
CURRENT="$HOME/.config/themes/current"

cat << EOF > "$CURRENT/foot"
[colors-dark]
background=${B00:1}
foreground=${B05:1}
regular0=${B00:1}
regular1=${B08:1}
regular2=${B0B:1}
regular3=${B0A:1}
regular4=${B0D:1}
regular5=${B0E:1}
regular6=${B0C:1}
regular7=${B05:1}
bright0=${B03:1}
bright1=${B09:1}
bright2=${B01:1}
bright3=${B02:1}
bright4=${B04:1}
bright5=${B06:1}
bright6=${B0F:1}
bright7=${B07:1}
EOF

ESC=$'\033'
BEL=$'\a'

SEQ="${ESC}]10;${B05}${BEL}"
SEQ+="${ESC}]11;${B00}${BEL}"
SEQ+="${ESC}]4;0;${B00}${BEL}"
SEQ+="${ESC}]4;1;${B08}${BEL}"
SEQ+="${ESC}]4;2;${B0B}${BEL}"
SEQ+="${ESC}]4;3;${B0A}${BEL}"
SEQ+="${ESC}]4;4;${B0D}${BEL}"
SEQ+="${ESC}]4;5;${B0E}${BEL}"
SEQ+="${ESC}]4;6;${B0C}${BEL}"
SEQ+="${ESC}]4;7;${B05}${BEL}"
SEQ+="${ESC}]4;8;${B03}${BEL}"
SEQ+="${ESC}]4;9;${B09}${BEL}"
SEQ+="${ESC}]4;10;${B01}${BEL}"
SEQ+="${ESC}]4;11;${B02}${BEL}"
SEQ+="${ESC}]4;12;${B04}${BEL}"
SEQ+="${ESC}]4;13;${B06}${BEL}"
SEQ+="${ESC}]4;14;${B0F}${BEL}"
SEQ+="${ESC}]4;15;${B07}${BEL}"

TMUX_TTYS=$(tmux list-panes -a -F "#{pane_tty}" 2>/dev/null || true)

for tty in /dev/pts/[0-9]*; do
    if [ -w "$tty" ]; then
        if echo "$TMUX_TTYS" | grep -Fqx "$tty"; then
            continue
        fi

        printf "%s" "$SEQ" > "$tty"
    fi
done

