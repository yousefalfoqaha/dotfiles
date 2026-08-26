#!/usr/bin/env bash
set -e

echo "starting system setup..."

CORE_PKGS=(
    # wayland desktop 
    sway swaybg swayidle xdg-desktop-portal-wlr xdg-desktop-portal-gtk xorg-xwayland
    # system
    grim slurp wl-clipboard mako libnotify wlsunset brightnessctl bluez bluez-utils networkmanager pipewire-pulse mpd mpc mpd-mpris playerctl
    # build
    base-devel
    # shell
    foot bash-completion tmux openssh man-db man-pages mise podman opencode
    # graphical
    firefox zathura zathura-pdf-mupdf libreoffice-fresh
    # fonts
    noto-fonts noto-fonts-emoji ttf-iosevka-nerd ttf-jetbrains-mono-nerd ttf-liberation
)

AUR_PKGS=(
    neovim-nightly-bin tofi
)

echo "installing native packages..."
sudo pacman -Syu --needed --noconfirm "${CORE_PKGS[@]}"

if ! command -v yay &> /dev/null; then
    echo "Installing yay..."
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    (cd /tmp/yay && makepkg -si --noconfirm)
    rm -rf /tmp/yay
fi

echo "installing AUR packages..."
yay -S --needed --noconfirm "${AUR_PKGS[@]}"

echo "installing language runtimes via mise..."
mise install

echo "install complete."
