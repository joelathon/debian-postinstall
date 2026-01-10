#!/bin/bash
set -e

echo "[+] Enabling laptop services"

# Enable CPU frequency management
systemctl enable --now auto-cpufreq

# Enable basic power management
systemctl enable --now tlp

# Defensive: disable desktop-only CPU scaling if it exists
systemctl disable --now cpupower 2>/dev/null || true

