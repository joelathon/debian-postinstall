#!/bin/bash
set -e

echo "[+] Installing AMD CPU microcode"
apt install -y amd64-microcode

