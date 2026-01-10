#!/bin/bash
set -e

echo "[+] Installing NVIDIA drivers"

apt install -y \
  nvidia-driver \
  nvidia-settings \
  nvidia-smi

# Optional but common
echo "options nvidia-drm modeset=1" > /etc/modprobe.d/nvidia.conf

