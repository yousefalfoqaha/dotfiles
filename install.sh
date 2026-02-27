#!/usr/bin/env bash
set -e

# -------------------------
# Update & install base packages
# -------------------------
echo "[INFO] Updating package lists..."
sudo apt-get update -y

echo "[INFO] Installing essential packages..."
sudo apt-get install -y \
    git \
    curl \
    wget \
    unzip \
    build-essential \
    software-properties-common \
    locales \
    bash-completion \
    python3 \
    python3-venv \
    python3-pip \
    neovim

# -------------------------
# Install exa (modern ls replacement)
# -------------------------
echo "[INFO] Installing exa..."
sudo apt-get install -y exa || {
    # fallback: latest GitHub release
    EXA_VERSION="0.10.1"
    wget "https://github.com/ogham/exa/releases/download/v${EXA_VERSION}/exa-linux-x86_64-v${EXA_VERSION}.zip" -O /tmp/exa.zip
    unzip /tmp/exa.zip -d /tmp/exa
    sudo mv /tmp/exa/bin/exa /usr/local/bin/exa
    rm -rf /tmp/exa /tmp/exa.zip
}

# -------------------------
# Install starship (prompt)
# -------------------------
echo "[INFO] Installing starship..."
curl -fsSL https://starship.rs/install.sh | bash -s -- -y

# -------------------------
# Setup Bash: starship & ls alias
# -------------------------
BASHRC="$HOME/.bashrc"

# starship init
if ! grep -q "starship init bash" "$BASHRC"; then
    echo 'eval "$(starship init bash)"' >> "$BASHRC"
fi

# ls alias
if ! grep -q "alias ls='exa'" "$BASHRC"; then
    echo "alias ls='exa -al --icons --git'" >> "$BASHRC"
fi

# n alias for nvim
if ! grep -q "alias n='nvim'" "$BASHRC"; then
    echo "alias n='nvim'" >> "$BASHRC"
fi

echo "[INFO] Installation complete! Reload your shell or run: source ~/.bashrc"
