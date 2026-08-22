#!/usr/bin/env bash
source "$HOME/.config/dotfiles/paths.sh"
source "$DOTFILES_THEME_STATE/base16.sh"

GTK_MODE="${MODE:-dark}"

if [[ "$GTK_MODE" == "light" ]]; then
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'
    gsettings set org.gnome.desktop.interface gtk-theme Adwaita
else
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
    gsettings set org.gnome.desktop.interface gtk-theme Adwaita-dark
fi
