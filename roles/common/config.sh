#!/bin/bash
set -e

echo "[+] Starting common configuration"

# -------------------------------
# Determine the real user home
# -------------------------------
TARGET_USER=${SUDO_USER:-$USER}
USER_HOME=$(eval echo ~$TARGET_USER)
echo "[+] Installing for user: $TARGET_USER ($USER_HOME)"

# -------------------------------
# Ensure ~/.local/bin exists
# -------------------------------
mkdir -p "$USER_HOME/.local/bin"

# -------------------------------
# Install prebuilt binaries (DWM, ST, dmenu, SLOCK)
# -------------------------------
echo "[+] Installing prebuilt binaries from builds folder"

for bin in dwm st dmenu slock; do
    cp "./builds/$bin/$bin" "$USER_HOME/.local/bin/$bin"
done

# Make everything executable
chmod +x "$USER_HOME/.local/bin/"*

# Ensure correct ownership (important if run via sudo)
chown -R "$TARGET_USER:$TARGET_USER" "$USER_HOME/.local/bin"

echo "[+] Prebuilt binaries installed to $USER_HOME/.local/bin"

# -------------------------------
# Optional: other common configs
# -------------------------------
# CPU microcode, GPU detection scripts, Wi-Fi firmware setup, etc.

echo "[+] Common configuration complete"

