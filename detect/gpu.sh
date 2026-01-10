#!/bin/bash
# Outputs:
#  hybrid-intel-nvidia
#  hybrid-amd-nvidia
#  nvidia
#  intel
#  amd
#  unknown

GPU=$(lspci -nnk | grep -Ei "VGA|3D|Display")

HAS_NVIDIA=$(echo "$GPU" | grep -qi nvidia && echo yes)
HAS_INTEL=$(echo "$GPU" | grep -qi intel && echo yes)
HAS_AMD=$(echo "$GPU" | grep -qi "amd|ati" && echo yes)

if [ "$HAS_INTEL" = "yes" ] && [ "$HAS_NVIDIA" = "yes" ]; then
  echo "hybrid-intel-nvidia"

elif [ "$HAS_AMD" = "yes" ] && [ "$HAS_NVIDIA" = "yes" ]; then
  echo "hybrid-amd-nvidia"

elif [ "$HAS_NVIDIA" = "yes" ]; then
  echo "nvidia"

elif [ "$HAS_INTEL" = "yes" ]; then
  echo "intel"

elif [ "$HAS_AMD" = "yes" ]; then
  echo "amd"

else
  echo "unknown"
fi

