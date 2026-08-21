#!/usr/bin/env bash
source "${XDG_CONFIG_HOME:-$HOME/.config}/dotfiles/paths.sh"
source "$DOTFILES_THEME_STATE/base16.sh"
source "$DOTFILES_FONT_HOME/$(cat "$DOTFILES_FONT_STATE").sh"

cat << EOF > "$DOTFILES_THEME_STATE/mako"
font=${FONT_BASE} ${FONT_BASE_SIZE}
background-color=${B00}DD
text-color=${B05}
border-color=${B01}
progress-color=${B0D}50

border-size=1
border-radius=0
padding=4
# Top, Right, Bottom, Left
outer-margin=8,0,8,8

anchor=bottom-right
default-timeout=5000
ignore-timeout=0
format=<b>%s</b>\n%b

[urgency=critical]
background-color=${B08}DD
text-color=${B00}
border-color=${B08}
default-timeout=0

[app-name=osd]
layer=overlay
history=0
anchor=bottom-center
group-by=app-name
format=<b>%s</b>
outer-margin=8,0,8,8
text-alignment=center

[category=media]
width=500

[app-name=osd grouped=false]
invisible=0
EOF

mkdir -p "$DOTFILES_CONFIG_HOME/mako"
ln -sfn "$DOTFILES_THEME_STATE/mako" "$DOTFILES_CONFIG_HOME/mako/config"

if [ -n "$SWAYSOCK" ]; then
    makoctl reload
fi
