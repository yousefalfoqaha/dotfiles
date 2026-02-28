#!/bin/bash

set -e

echo "Updating package lists..."
sudo apt-get update -y

echo "Installing system dependencies..."
sudo apt-get install -y unzip ripgrep fd-find gpg

if [ ! -f /usr/local/bin/fd ]; then
    echo "Symlinking fdfind to fd..."
    sudo ln -s $(which fdfind) /usr/local/bin/fd
fi

echo "Installing tree-sitter-cli..."
curl -fLo tree-sitter.gz https://github.com/tree-sitter/tree-sitter/releases/latest/download/tree-sitter-linux-x64.gz
gzip -d tree-sitter.gz
chmod +x tree-sitter
sudo mv tree-sitter /usr/local/bin/

echo "Installing Neovim Nightly (tar.gz)..."
curl -fLo nvim-linux64.tar.gz https://github.com/neovim/neovim/releases/download/nightly/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim-linux64
sudo tar -C /opt -xzf nvim-linux64.tar.gz
sudo ln -sf /opt/nvim-linux64/bin/nvim /usr/local/bin/nvim

rm nvim-linux64.tar.gz

echo "Dotfiles installation complete."
