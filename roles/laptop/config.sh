#!/bin/bash
set -e

echo "[+] Applying laptop-specific configuration"

# -------------------------------
# Touchpad & TrackPoint configuration
# -------------------------------
sudo mkdir -p /etc/X11/xorg.conf.d/
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

sudo systemctl daemon-reload
sudo systemctl enable slock-lid-close.service

# -------------------------------
# Laptop status bar and xinitrc
# -------------------------------
echo "[+] Installing laptop status bar and xinitrc"

mkdir -p ~/.local/bin
cp ./scripts/dwm-status-laptop.sh ~/.local/bin/statusbar.sh
chmod +x ~/.local/bin/statusbar.sh

cp ./scripts/xinitrc-laptop ~/.xinitrc
chmod +x ~/.xinitrc

# -------------------------------
# TLP battery thresholds
# -------------------------------
echo "[+] Installing TLP configuration"

sudo mkdir -p /etc/tlp
cat > /etc/tlp.conf << 'EOF'
START_CHARGE_THRESH_BAT0=75
STOP_CHARGE_THRESH_BAT0=80
START_CHARGE_THRESH_BAT1=75
STOP_CHARGE_THRESH_BAT1=80
EOF

sudo systemctl enable tlp
sudo systemctl start tlp

echo "[+] Laptop configuration applied"

