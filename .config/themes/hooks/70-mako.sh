#!/usr/bin/env bash
source "$HOME/.config/themes/current/base16.sh"
CURRENT="$HOME/.config/themes/current"

cat << EOF > "$CURRENT/mako"
font=Iosevka Nerd Font 10
background-color=${B00}
text-color=${B05}
border-color=${B02}
progress-color=${B0D}80

border-size=1
border-radius=0
padding=4
margin=8

anchor=top-right
default-timeout=5000
ignore-timeout=0
format=<b>%s</b>\n%b

[urgency=critical]
background-color=${B01}
text-color=${B08}
border-color=${B08}
border-size=1
default-timeout=0

[app-name=osd]
layer=overlay
history=0
anchor=top-center
group-by=app-name
format=<b>%s</b>\n%b

[app-name=osd grouped=false]
invisible=0
EOF

mkdir -p "$HOME/.config/mako"
ln -sf "$CURRENT/mako" "$HOME/.config/mako/config"

if [ -n "$SWAYSOCK" ]; then
    makoctl reload
fi
