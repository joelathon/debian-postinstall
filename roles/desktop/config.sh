#!/bin/bash
set -e

echo "[+] Applying desktop performance configuration"

# Force performance governor (optional but explicit)
cpupower frequency-set -g performance || true

