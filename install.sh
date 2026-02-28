#!/bin/bash
set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Updating package lists..."
sudo apt-get update -y

echo "Installing system dependencies..."
sudo apt-get install -y curl wget tar gzip unzip ripgrep fd-find

echo "Installing tree-sitter-cli..."
curl -fLo tree-sitter.gz https://github.com/tree-sitter/tree-sitter/releases/latest/download/tree-sitter-linux-x64.gz
gzip -d tree-sitter.gz
chmod +x tree-sitter
sudo mkdir -p /opt/tree-sitter
sudo mv tree-sitter /opt/tree-sitter/tree-sitter
sudo ln -sf /opt/tree-sitter/tree-sitter /usr/local/bin/tree-sitter

echo "Installing neovim nightly..."
curl -fLo nvim-linux64.tar.gz https://github.com/neovim/neovim/releases/download/nightly/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim-linux-x86_64
sudo tar -C /opt -xzf nvim-linux64.tar.gz
sudo ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim
rm nvim-linux64.tar.gz

echo "Installing eza..."
sudo mkdir -p /opt/eza
curl -fLo /tmp/eza.tar.gz https://github.com/eza-community/eza/releases/latest/download/eza_x86_64-unknown-linux-gnu.tar.gz
sudo tar -C /opt/eza -xzf /tmp/eza.tar.gz
sudo ln -sf /opt/eza/eza /usr/local/bin/eza
rm /tmp/eza.tar.gz

echo "Installing Starship prompt..."
curl -fsSL https://starship.rs/install.sh | sh -s -- --yes

echo "Appending dotfiles .bashrc..."
if ! grep -q "dotfiles .bashrc" ~/.bashrc; then
    echo "" >> ~/.bashrc
    echo "# dotfiles .bashrc" >> ~/.bashrc
    cat "$DOTFILES_DIR/.bashrc" >> ~/.bashrc
fi

echo "Installed dotfiles."
