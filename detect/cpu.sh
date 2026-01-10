#!/bin/bash
# Outputs: intel | amd | unknown

if grep -qi intel /proc/cpuinfo; then
  echo "intel"
elif grep -qi amd /proc/cpuinfo; then
  echo "amd"
else
  echo "unknown"
fi

