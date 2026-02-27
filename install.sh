#!/usr/bin/env bash
set -e

sudo apt-get update
sudo apt-get install -y git curl wget unzip build-essential bash-completion python3 python3-venv python3-pip neovim openjdk-17-jdk clangd npm

echo "alias ls='exa -al --icons --git'" >> ~/.bashrc
echo "alias n='nvim'" >> ~/.bashrc
curl -fsSL https://starship.rs/install.sh | bash -s -- -y
echo 'eval "$(starship init bash)"' >> ~/.bashrc
mkdir -p ~/.local/bin
export PATH="$HOME/.local/bin:$PATH"

npm install -g typescript-language-server tree-sitter-cli

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
export PATH="$HOME/.cargo/bin:$PATH"
cargo install stylua marksman

mkdir -p ~/.local/share/java
curl -fsSL https://projectlombok.org/downloads/lombok.jar -o ~/.local/share/java/lombok.jar

echo "Dotfiles setup complete."
