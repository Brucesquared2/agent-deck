#!/bin/sh
# install-nvidia-container-toolkit.sh
# Installs the NVIDIA Container Toolkit on Ubuntu/Debian.
# Required so Docker containers can access NVIDIA GPUs.
#
# Run as root or with sudo on each GPU node before starting the DCGM exporter.
#
# Tested on: Ubuntu 22.04, Ubuntu 24.04
# Requires: curl, gpg, apt
#
# Reference: https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html
#
# NOTE: This script requires bash for 'set -o pipefail'.

#!/bin/bash
set -euo pipefail

if [ "$(id -u)" -ne 0 ]; then
    echo "ERROR: This script must be run as root (or with sudo)." >&2
    exit 1
fi

echo "[nvidia-ctk] Detecting distribution..."
# Read /etc/os-release for distro info
. /etc/os-release
DISTRO="${ID:-unknown}"
VERSION_CODENAME="${VERSION_CODENAME:-}"

echo "[nvidia-ctk] Detected: $DISTRO ${VERSION_CODENAME}"

case "$DISTRO" in
    ubuntu|debian)
        ;;
    *)
        echo "WARNING: This script is tested on Ubuntu/Debian only." >&2
        echo "         Proceeding anyway — adjust package manager commands if needed." >&2
        ;;
esac

echo "[nvidia-ctk] Adding NVIDIA Container Toolkit repository..."

curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey \
    | gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg

curl -s -L "https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list" \
    | sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' \
    | tee /etc/apt/sources.list.d/nvidia-container-toolkit.list > /dev/null

echo "[nvidia-ctk] Updating apt and installing nvidia-container-toolkit..."
apt-get update -y
apt-get install -y nvidia-container-toolkit

echo "[nvidia-ctk] Configuring Docker runtime..."
nvidia-ctk runtime configure --runtime=docker

echo "[nvidia-ctk] Restarting Docker daemon..."
systemctl restart docker

echo "[nvidia-ctk] Verifying installation..."
docker run --rm --runtime=nvidia --gpus all \
    nvcr.io/nvidia/cuda:12.4.0-base-ubuntu22.04 \
    nvidia-smi \
    && echo "[nvidia-ctk] SUCCESS: nvidia-smi ran inside Docker container." \
    || echo "[nvidia-ctk] WARNING: nvidia-smi test failed. Check driver and toolkit installation."

echo ""
echo "[nvidia-ctk] Done. Next step:"
echo "  cd sanctuary-runtime/telemetry"
echo "  docker compose -f docker-compose.dcgm-node.yml up -d"
