#!/bin/bash
set -e

echo "[+] Installing common packages"

apt update

apt install -y \
  curl \
  wget \
  git \
  build-essential \
  pkg-config \
  rsync \
  unzip \
  zip \
  tar \
  \
  xorg \
  xinit \
  xclip \
  x11-xserver-utils \
  autorandr \
  \
  network-manager \
  bluetooth \
  bluez \
  blueman \
  \
  pipewire \
  pipewire-audio \
  wireplumber \
  pavucontrol \
  \
  firefox-esr \
  vim \
  nautilus \
  zathura \
  gimp \
  flameshot \
  kdeconnect \
  \
  fonts-dejavu \
  fonts-liberation \
  fonts-font-awesome

echo "[+] Common packages installed"

