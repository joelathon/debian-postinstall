#!/bin/bash
set -e

echo "[+] Applying desktop-specific configuration"

# -------------------------------
# Determine the real user home
# -------------------------------
TARGET_USER=${SUDO_USER:-$USER}
USER_HOME=$(eval echo ~$TARGET_USER)
echo "[+] Configuring for user: $TARGET_USER ($USER_HOME)"

# -------------------------------
# Copy desktop status bar script
# -------------------------------
mkdir -p "$USER_HOME/.local/bin"
cp ./scripts/dwm-status-desktop.sh "$USER_HOME/.local/bin/statusbar.sh"
chmod +x "$USER_HOME/.local/bin/statusbar.sh"
chown "$TARGET_USER:$TARGET_USER" "$USER_HOME/.local/bin/statusbar.sh"

# -------------------------------
# Copy desktop xinitrc
# -------------------------------
cp ./scripts/xinitrc-desktop "$USER_HOME/.xinitrc"
chown "$TARGET_USER:$TARGET_USER" "$USER_HOME/.xinitrc"
chmod 644 "$USER_HOME/.xinitrc"

# -------------------------------
# Force CPU to performance (desktop only)
# -------------------------------
cpupower frequency-set -g performance || true

echo "[+] Desktop configuration applied"

