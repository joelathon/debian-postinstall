#!/bin/bash
# Outputs: intel | realtek | broadcom | none

WIFI_INFO="$(
  lspci -nnk 2>/dev/null | grep -i network
  lsusb 2>/dev/null
)"

if echo "$WIFI_INFO" | grep -qi intel; then
  echo "intel"
elif echo "$WIFI_INFO" | grep -qi realtek; then
  echo "realtek"
elif echo "$WIFI_INFO" | grep -qi broadcom; then
  echo "broadcom"
else
  echo "none"
fi

