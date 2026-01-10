#!/bin/bash
set -e

echo "[+] Applying desktop performance configuration"

# Force performance governor
cpupower frequency-set -g performance || true

# -------------------------
# Copy desktop status bar
# -------------------------
echo "[+] Installing desktop status bar"
mkdir -p ~/.local/bin
cp ./scripts/dwm-status-desktop.sh ~/.local/bin/statusbar.sh
chmod +x ~/.local/bin/statusbar.sh

# -------------------------
# Copy desktop xinitrc
# -------------------------
echo "[+] Installing desktop xinitrc"
cp ./scripts/xinitrc-desktop ~/.xinitrc
chmod +x ~/.xinitrc

echo "[+] Desktop configuration complete"

