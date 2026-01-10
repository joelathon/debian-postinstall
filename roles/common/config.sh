#!/bin/bash
set -e

echo "[+] Starting common configuration"

# 1️⃣ Install prebuilt binaries (DWM, ST, dmenu, SLOCK)
echo "[+] Installing prebuilt binaries from builds folder"
mkdir -p /usr/local/bin

for bin in dwm st dmenu slock; do
    cp ./builds/$bin/$bin /usr/local/bin/$bin
    chmod +x /usr/local/bin/$bin
done

echo "[+] Prebuilt binaries installed"

# 2️⃣ (Optional) Any other common configs
# Example: CPU microcode, GPU detection scripts, Wi-Fi firmware setup, etc.
# Add any shared config steps here

echo "[+] Common configuration complete"

