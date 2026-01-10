#!/bin/bash
set -e

if [ "$EUID" -ne 0 ]; then
  echo "Run as root"
  exit 1
fi

ROLE="$1"

# 1. Determine role (auto or explicit)
if [ -z "$ROLE" ]; then
  if grep -q battery /sys/class/power_supply/*/type 2>/dev/null; then
    ROLE="laptop"
  else
    ROLE="desktop"
  fi
fi

echo "[+] Role: $ROLE"

# 2. Common packages (includes apt update)
bash roles/common/packages.sh
bash roles/common/services.sh
bash roles/common/config.sh

# 3. CPU detection + microcode (COMMON)
CPU=$(bash detect/cpu.sh)
echo "[+] CPU detected: $CPU"

if [ -f "drivers/cpu-$CPU.sh" ]; then
  bash "drivers/cpu-$CPU.sh"
else
  echo "[!] No microcode script for CPU: $CPU"
fi

echo "$CPU" > /etc/machine-cpu

# Wifi Detection
WIFI=$(bash detect/wifi.sh)
echo "[+] Wi-Fi detected: $WIFI"

if [ "$WIFI" != "none" ]; then
  bash "drivers/wifi-$WIFI.sh"
fi

echo "$WIFI" > /etc/machine-wifi

# 4. GPU detection + drivers
GPU=$(bash detect/gpu.sh)
echo "[+] GPU detected: $GPU"

if [ -f "drivers/$GPU.sh" ]; then
  bash "drivers/$GPU.sh"
else
  echo "[!] No GPU driver script for: $GPU"
fi

echo "$GPU" > /etc/machine-gpu

# Desktop GPU Policy
if [ "$ROLE" = "desktop" ] && echo "$GPU" | grep -q nvidia; then
  echo "[+] Desktop with NVIDIA detected — forcing NVIDIA"
  prime-select nvidia || true
fi

# 5. Role-specific
if [ -d "roles/$ROLE" ]; then
  bash roles/$ROLE/packages.sh
  bash roles/$ROLE/services.sh
  bash roles/$ROLE/config.sh
fi

echo "$ROLE" > /etc/machine-role

echo "[+] Install complete — reboot recommended"

