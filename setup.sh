#!/usr/bin/env bash
set -e

echo "starting system setup..."

CORE_PKGS=(
    # wayland desktop 
    sway
    swaybg
    swayidle
    xdg-desktop-portal-wlr
    xdg-desktop-portal-gtk

    # x11 compatibility
    xorg-xwayland

    # system utils
    grim
    slurp
    wl-clipboard
    mako
    libnotify
    wlsunset
    brightnessctl
    bluez
    bluez-utils
    networkmanager
    pipewire-pulse
    mpd
    mpc
    mpd-mpris
    playerctl

    # dev
    base-devel
    bash-completion
    man-db
    man-pages
    mise
    podman
    opencode

    # shell
    foot
    tmux
    bat
    eza
    htop
    openssh

    # graphical
    firefox
    zathura
    zathura-pdf-mupdf
    libreoffice-fresh

    # fonts
    noto-fonts
    noto-fonts-emoji
    ttf-iosevka-nerd
    ttf-jetbrains-mono-nerd
    ttf-liberation
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

echo "symlinking dotfiles..."
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

rm -f "$HOME/.bashrc"
ln -s "$DOTFILES_DIR/.bashrc" "$HOME/.bashrc"
rm -f "$HOME/.bash_profile"
ln -s "$DOTFILES_DIR/.bash_profile" "$HOME/.bash_profile"
rm -f "$HOME/.inputrc"
ln -s "$DOTFILES_DIR/.inputrc" "$HOME/.inputrc"

mkdir -p "$HOME/.config"
rm -rf "$HOME/.config/backgrounds"
rm -rf "$HOME/.config/dotfiles"
ln -s "$DOTFILES_DIR/.config/dotfiles" "$HOME/.config/dotfiles"
rm -rf "$HOME/.config/fonts"
ln -s "$DOTFILES_DIR/.config/fonts" "$HOME/.config/fonts"
rm -rf "$HOME/.config/foot"
ln -s "$DOTFILES_DIR/.config/foot" "$HOME/.config/foot"
rm -rf "$HOME/.config/mise"
ln -s "$DOTFILES_DIR/.config/mise" "$HOME/.config/mise"
rm -rf "$HOME/.config/nvim"
ln -s "$DOTFILES_DIR/.config/nvim" "$HOME/.config/nvim"
rm -rf "$HOME/.config/sway"
ln -s "$DOTFILES_DIR/.config/sway" "$HOME/.config/sway"
rm -rf "$HOME/.config/themes"
ln -s "$DOTFILES_DIR/.config/themes" "$HOME/.config/themes"
rm -rf "$HOME/.config/tmux"
ln -s "$DOTFILES_DIR/.config/tmux" "$HOME/.config/tmux"
rm -rf "$HOME/.config/tofi"
ln -s "$DOTFILES_DIR/.config/tofi" "$HOME/.config/tofi"
rm -rf "$HOME/.config/xdg-desktop-portal-wlr"
ln -s "$DOTFILES_DIR/.config/xdg-desktop-portal-wlr" "$HOME/.config/xdg-desktop-portal-wlr"
rm -rf "$HOME/.config/mpd"
ln -s "$DOTFILES_DIR/.config/mpd" "$HOME/.config/mpd"

mkdir -p "$HOME/.local/bin" "$HOME/.local/share" "$HOME/.local/state/theme" "$HOME/.local/state" "$HOME/Music"
rm -f "$HOME/.local/bin/dotfiles-background"
ln -s "$DOTFILES_DIR/.local/bin/dotfiles-background" "$HOME/.local/bin/dotfiles-background"
rm -f "$HOME/.local/bin/dotfiles-bluetooth"
ln -s "$DOTFILES_DIR/.local/bin/dotfiles-bluetooth" "$HOME/.local/bin/dotfiles-bluetooth"
rm -f "$HOME/.local/bin/dotfiles-brightness"
ln -s "$DOTFILES_DIR/.local/bin/dotfiles-brightness" "$HOME/.local/bin/dotfiles-brightness"
rm -f "$HOME/.local/bin/dotfiles-nightlight"
ln -s "$DOTFILES_DIR/.local/bin/dotfiles-nightlight" "$HOME/.local/bin/dotfiles-nightlight"
rm -f "$HOME/.local/bin/dotfiles-output"
ln -s "$DOTFILES_DIR/.local/bin/dotfiles-output" "$HOME/.local/bin/dotfiles-output"
rm -f "$HOME/.local/bin/dotfiles-status"
ln -s "$DOTFILES_DIR/.local/bin/dotfiles-status" "$HOME/.local/bin/dotfiles-status"
rm -f "$HOME/.local/bin/dotfiles-system"
ln -s "$DOTFILES_DIR/.local/bin/dotfiles-system" "$HOME/.local/bin/dotfiles-system"
rm -f "$HOME/.local/bin/dotfiles-clock"
ln -s "$DOTFILES_DIR/.local/bin/dotfiles-clock" "$HOME/.local/bin/dotfiles-clock"
rm -f "$HOME/.local/bin/dotfiles-theme"
ln -s "$DOTFILES_DIR/.local/bin/dotfiles-theme" "$HOME/.local/bin/dotfiles-theme"
rm -f "$HOME/.local/bin/dotfiles-font"
ln -s "$DOTFILES_DIR/.local/bin/dotfiles-font" "$HOME/.local/bin/dotfiles-font"
rm -f "$HOME/.local/bin/dotfiles-media"
ln -s "$DOTFILES_DIR/.local/bin/dotfiles-media" "$HOME/.local/bin/dotfiles-media"
rm -f "$HOME/.local/bin/dotfiles-volume"
ln -s "$DOTFILES_DIR/.local/bin/dotfiles-volume" "$HOME/.local/bin/dotfiles-volume"
rm -f "$HOME/.local/bin/dotfiles-wifi"
ln -s "$DOTFILES_DIR/.local/bin/dotfiles-wifi" "$HOME/.local/bin/dotfiles-wifi"
rm -f "$HOME/.local/bin/dotfiles-pdf"
ln -s "$DOTFILES_DIR/.local/bin/dotfiles-pdf" "$HOME/.local/bin/dotfiles-pdf"
rm -f "$HOME/.local/bin/dotfiles-music"
ln -s "$DOTFILES_DIR/.local/bin/dotfiles-music" "$HOME/.local/bin/dotfiles-music"
rm -f "$HOME/.local/bin/music-dl"
ln -s "$DOTFILES_DIR/.local/bin/music-dl" "$HOME/.local/bin/music-dl"
rm -f "$HOME/.local/bin/dotfiles-mpd-watcher"
ln -s "$DOTFILES_DIR/.local/bin/dotfiles-mpd-watcher" "$HOME/.local/bin/dotfiles-mpd-watcher"
rm -f "$HOME/.local/bin/dotfiles-screenshot"
ln -s "$DOTFILES_DIR/.local/bin/dotfiles-screenshot" "$HOME/.local/bin/dotfiles-screenshot"

rm -rf "$HOME/.local/share/backgrounds"
ln -s "$DOTFILES_DIR/.local/share/backgrounds" "$HOME/.local/share/backgrounds"

echo "enabling user services..."
systemctl --user enable --now mpd mpd-mpris

echo "enabling system services..."
sudo systemctl enable --now bluetooth NetworkManager


echo "installing language runtimes via mise..."
mise install

echo "setup complete. reboot the machine."
