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
sudo mv tree-sitter /usr/local/bin/tree-sitter-cli

echo "Installing Neovim Nightly..."
curl -fLo nvim-linux64.tar.gz https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz
sudo tar -C /opt -xzf nvim-linux64.tar.gz
sudo ln -sf /opt/nvim-linux64/bin/nvim /usr/local/bin/nvim
rm nvim-linux64.tar.gz

echo "Installing eza..."
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://raw.githubusercontent.com/eza-community/eza/main/api.gpg | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://apt.fury.io/eza/ /" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo apt-get update -y
sudo apt-get install -y eza

echo "Installing Starship prompt..."
curl -sS https://starship.rs/install.sh | sh -s -- -y

echo "Linking dotfiles configuration..."
DOTFILES_RC="$HOME/dotfiles/.bashrc"

if ! grep -q "source $DOTFILES_RC" ~/.bashrc; then
    echo -e "\n# Source custom dotfiles configuration" >> ~/.bashrc
    echo "if [ -f \"$DOTFILES_RC\" ]; then" >> ~/.bashrc
    echo "    source \"$DOTFILES_RC\"" >> ~/.bashrc
    echo "fi" >> ~/.bashrc
    echo "Linked custom .bashrc to the system .bashrc."
fi

echo "Installation complete! Neovim nightly, ripgrep, fd, tree-sitter-cli, eza, and Starship are ready."
echo "Run 'source ~/.bashrc' or open a new terminal to see the changes."
