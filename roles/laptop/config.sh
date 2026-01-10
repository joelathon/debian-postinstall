#!/bin/bash
set -e

echo "[+] Applying laptop-specific configuration"

# -------------------------------
# Touchpad & TrackPoint configuration
# -------------------------------
mkdir -p /etc/X11/xorg.conf.d/
cat > /etc/X11/xorg.conf.d/40-libinput.conf << 'EOF'
Section "InputClass"
    Identifier "libinput touchpad"
    MatchProduct "Synaptics TM3276-022"
    MatchIsTouchpad "on"
    Driver "libinput"

    Option "NaturalScrolling" "true"
    Option "Tapping" "true"
    Option "ClickMethod" "clickfinger"
EndSection

Section "InputClass"
    Identifier "libinput trackpoint"
    MatchProduct "TPPS/2 IBM TrackPoint"
    Driver "libinput"

    Option "NaturalScrolling" "false"
    Option "ScrollMethod" "button"
    Option "ScrollButton" "2"
EndSection
EOF

# -------------------------------
# Lock screen with slock on lid close
# -------------------------------
echo "[+] Setting up slock on lid close"

cat > /etc/systemd/system/slock-lid-close.service << 'EOF'
[Unit]
Description=Lock screen with slock on lid close
Before=sleep.target
StopWhenUnneeded=yes

[Service]
Type=oneshot
ExecStart=/usr/bin/slock

[Install]
WantedBy=sleep.target
EOF

systemctl daemon-reload
systemctl enable slock-lid-close.service

echo "[+] Laptop configuration applied"

