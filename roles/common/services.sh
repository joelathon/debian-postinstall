#!/bin/bash
set -e

echo "[+] Setting up common services"

# NetworkManager
if systemctl is-enabled NetworkManager >/dev/null 2>&1; then
  echo "[=] NetworkManager already enabled"
else
  systemctl enable NetworkManager
fi

if systemctl is-active NetworkManager >/dev/null 2>&1; then
  echo "[=] NetworkManager already running"
else
  systemctl start NetworkManager
fi

# Bluetooth
if systemctl is-enabled bluetooth >/dev/null 2>&1; then
  echo "[=] Bluetooth already enabled"
else
  systemctl enable bluetooth
fi

if systemctl is-active bluetooth >/dev/null 2>&1; then
  echo "[=] Bluetooth already running"
else
  systemctl start bluetooth
fi

echo "[+] Common services ready"

