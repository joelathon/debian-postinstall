#!/bin/bash

echo "[+] Installing hybrid NVIDIA (Optimus)"

apt install -y \
  nvidia-driver \
  nvidia-prime \
  mesa-utils

# Default to Intel, NVIDIA on-demand
prime-select intel || true

