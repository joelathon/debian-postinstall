#!/bin/bash
set -e

echo "[+] Installing AMD + NVIDIA hybrid graphics"

apt install -y \
  nvidia-driver \
  mesa-utils \
  mesa-vulkan-drivers \
  libglx-mesa0 \
  nvidia-prime

# Default to AMD (power efficient), NVIDIA on-demand
prime-select on-demand || true

