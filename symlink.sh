#!/usr/bin/env bash
set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "creating base directories..."
mkdir -p "$HOME/.config" "$HOME/.local/bin" "$HOME/.local/share" "$HOME/.local/state/theme" "$HOME/Music"

rm -rf "$HOME/.config/backgrounds"

echo "symlinking top-level hidden files..."
TOP_LEVEL_FILES=(
    ".bashrc"
    ".bash_profile"
    ".inputrc"
)

for file in "${TOP_LEVEL_FILES[@]}"; do
    if [[ -f "$DOTFILES_DIR/$file" ]]; then
        rm -f "$HOME/$file"
        ln -s "$DOTFILES_DIR/$file" "$HOME/$file"
        echo " -> $file"
    fi
done

echo "symlinking .config directories..."
for item in "$DOTFILES_DIR/.config"/*; do
    if [[ -e "$item" ]]; then
        base=$(basename "$item")
        rm -rf "$HOME/.config/$base"
        ln -s "$item" "$HOME/.config/$base"
        echo " -> .config/$base"
    fi
done

echo "symlinking .local/bin scripts..."
for item in "$DOTFILES_DIR/.local/bin"/*; do
    if [[ -e "$item" ]]; then
        base=$(basename "$item")
        rm -f "$HOME/.local/bin/$base"
        ln -s "$item" "$HOME/.local/bin/$base"
        echo " -> .local/bin/$base"
    fi
done

echo "symlinking .local/share data..."
for item in "$DOTFILES_DIR/.local/share"/*; do
    if [[ -e "$item" ]]; then
        base=$(basename "$item")
        rm -rf "$HOME/.local/share/$base"
        ln -s "$item" "$HOME/.local/share/$base"
        echo " -> .local/share/$base"
    fi
done

echo "symlinking complete."
