#!/bin/bash
set -e

echo "[+] Enabling desktop services"

# No power-saving daemons on desktop
systemctl disable auto-cpufreq 2>/dev/null || true
systemctl disable tlp 2>/dev/null || true

