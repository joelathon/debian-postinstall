#!/bin/bash
set -e

echo "[+] Installing minimal laptop-specific packages"

# CPU scaling & power management
apt install -y auto-cpufreq tlp

# ACPI tools
apt install -y acpi acpi-call-dkms

# Hardware monitoring
apt install -y lm-sensors

# Display & user convenience
apt install -y pavucontrol xbacklight arandr

