#!/usr/bin/env bash
set -e

echo "enabling system services (requires sudo)..."
sudo systemctl enable --now bluetooth NetworkManager

echo "enabling user services..."
systemctl --user enable --now mpd mpd-mpris

echo "services configured. reboot the machine."
