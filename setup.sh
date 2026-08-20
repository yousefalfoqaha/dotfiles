#!/usr/bin/env bash
set -e

echo "starting system setup..."

CORE_PKGS=(
    base-devel bash-completion bat bluez bluez-utils brightnessctl docker 
    eza fd firefox foot fzf gnome-themes-extra grim htop j4-dmenu-desktop 
    libnotify libreoffice-fresh mako man-db man-pages mise noto-fonts 
    noto-fonts-cjk noto-fonts-emoji openssh pipewire-alsa pipewire-pulse 
    ripgrep slurp sway swaybg texinfo tmux tree-sitter tree-sitter-cli 
    ttf-iosevka-nerd ttf-liberation unzip wl-clipboard 
    xorg-xwayland xdg-desktop-portal-gtk xdg-desktop-portal-wlr zoxide
)

AUR_PKGS=(
    neovim-nightly-bin tofi ttf-ms-aptos-core
)

echo "installing native packages..."
sudo pacman -S --needed --noconfirm "${CORE_PKGS[@]}"

if ! command -v yay &> /dev/null; then
    echo "Installing yay..."
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    (cd /tmp/yay && makepkg -si --noconfirm)
    rm -rf /tmp/yay
fi

echo "installing AUR packages..."
yay -S --needed --noconfirm "${AUR_PKGS[@]}"

echo "symlinking dotfiles..."
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

for file in .bashrc .bash_profile .inputrc; do
    rm -f "$HOME/$file"
    ln -s "$DOTFILES_DIR/$file" "$HOME/$file"
done

mkdir -p "$HOME/.config"
for config_item in "$DOTFILES_DIR/.config/"*; do
    [ -e "$config_item" ] || continue
    item_name=$(basename "$config_item")
    rm -rf "$HOME/.config/$item_name"
    ln -s "$config_item" "$HOME/.config/$item_name"
done

echo "installing language runtimes via mise..."
mise install

echo "setup complete. reboot the machine."
