#!/bin/bash

echo "[+] Installing AMD graphics stack"

apt install -y \
  xserver-xorg-video-amdgpu \
  mesa-utils \
  mesa-vulkan-drivers \
  vulkan-tools

