#!/bin/bash

echo "[+] Installing Intel graphics stack"

apt install -y \
  xserver-xorg-video-intel \
  mesa-utils \
  intel-media-va-driver \
  vainfo

