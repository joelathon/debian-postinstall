#!/bin/bash
set -e

echo "[+] Installing desktop-specific packages"

apt install -y \
  pavucontrol \
  arandr \
  lm-sensors \
  linux-cpupower

