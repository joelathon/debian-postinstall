#!/bin/bash
set -e

if [ "$EUID" -ne 0 ]; then
  echo "Run as root"
  exit 1
fi

ROLE="$1"

if [ -z "$ROLE" ]; then
  echo "No role specified, attempting auto-detect..."
  if grep -q battery /sys/class/power_supply/*/type 2>/dev/null; then
    ROLE="laptop"
  else
    ROLE="desktop"
  fi
fi

echo "[+] Role selected: $ROLE"

bash roles/common/packages.sh
bash roles/common/services.sh

if [ -d "roles/$ROLE" ]; then
  bash roles/$ROLE/packages.sh
  bash roles/$ROLE/services.sh
  bash roles/$ROLE/config.sh
fi

echo "[+] Base system complete"

