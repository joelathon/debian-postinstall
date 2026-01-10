#!/bin/bash
set -e

echo "[+] Starting common configuration"

# -------------------------------
# Ensure user local bin exists
# -------------------------------
USER_HOME=$(eval echo ~$USER)
mkdir -p "$USER_HOME/.local/bin"

# -------------------------------
# Install prebuilt binaries (DWM, ST, dmenu, SLOCK)
# -------------------------------
echo "[+] Installing prebuilt binaries from builds folder"

for bin in dwm st dmenu slock; do
    cp "./builds/$bin/$bin" "$USER_HOME/.local/bin/$bin"
done

# Make all binaries executable
chmod +x "$USER_HOME/.local/bin/"*

echo "[+] Prebuilt binaries installed to $USER_HOME/.local/bin"

# -------------------------------
# Optional: other common configs
# -------------------------------
# Example: CPU microcode, GPU detection scripts, Wi-Fi firmware setup, etc.
# Add any shared config steps here

echo "[+] Common configuration complete"

