#!/bin/sh
# install-termux-bridge.sh — Configure Termux as an SSH bridge to the Sanctuary Runtime.
#
# This script sets up:
#   1. sshd in Termux (if not already running)
#   2. An SSH config alias so `ssh sanctuary` calls teleport-agent on the remote host
#   3. A shell alias `teleport` that invokes the vram_teleport.py script remotely
#
# Usage (run inside Termux on Android):
#   bash install-termux-bridge.sh [remote-host] [remote-user]
#
# Arguments:
#   remote-host  — IP or hostname of your Sanctuary host (default: TODO-SANCTUARY-HOST)
#   remote-user  — SSH username on the remote host (default: TODO-REMOTE-USER)
#
# POSIX sh.

set -eu

REMOTE_HOST="${1:-TODO-SANCTUARY-HOST}"   # TODO: replace with your actual host IP or hostname
REMOTE_USER="${2:-TODO-REMOTE-USER}"      # TODO: replace with your SSH username

SSH_CONFIG="$HOME/.ssh/config"
BASHRC="$HOME/.bashrc"

echo "[termux-bridge] Installing dependencies..."
# pkg is Termux's package manager
if command -v pkg > /dev/null 2>&1; then
    pkg install -y openssh curl python
else
    echo "WARNING: pkg not found. Ensure openssh, curl, and python are installed manually." >&2
fi

echo "[termux-bridge] Ensuring SSH directory exists..."
mkdir -p "$HOME/.ssh"
chmod 700 "$HOME/.ssh"

echo "[termux-bridge] Generating SSH key (if none exists)..."
if [ ! -f "$HOME/.ssh/id_ed25519" ]; then
    ssh-keygen -t ed25519 -N "" -f "$HOME/.ssh/id_ed25519" -C "termux-sanctuary-bridge"
    echo ""
    echo "[termux-bridge] Public key (add this to $REMOTE_USER@$REMOTE_HOST ~/.ssh/authorized_keys):"
    cat "$HOME/.ssh/id_ed25519.pub"
    echo ""
fi

echo "[termux-bridge] Configuring SSH alias in $SSH_CONFIG ..."

# Avoid duplicate entries
if ! grep -q "Host sanctuary" "$SSH_CONFIG" 2>/dev/null; then
    cat >> "$SSH_CONFIG" <<EOF

# Sanctuary Runtime bridge (added by install-termux-bridge.sh)
Host sanctuary
    HostName $REMOTE_HOST
    User $REMOTE_USER
    IdentityFile ~/.ssh/id_ed25519
    ServerAliveInterval 60
    ServerAliveCountMax 3
EOF
    echo "[termux-bridge] SSH alias 'sanctuary' added to $SSH_CONFIG"
else
    echo "[termux-bridge] SSH alias 'sanctuary' already exists in $SSH_CONFIG — skipping."
fi

echo "[termux-bridge] Adding shell aliases to $BASHRC ..."

# Avoid duplicate entries
if ! grep -q "sanctuary-bridge" "$BASHRC" 2>/dev/null; then
    cat >> "$BASHRC" <<'BASHEOF'

# Sanctuary Runtime bridge aliases (added by install-termux-bridge.sh)

# Run teleport-agent remotely via SSH
teleport() {
    # TODO: adjust the path to vram_teleport.py on the remote host
    ssh sanctuary "python3 ~/sanctuary-runtime/agent-runtime/scripts/vram_teleport.py $*"
}

# Run reviewer VRAM check remotely
vram-check() {
    ssh sanctuary "bash ~/sanctuary-runtime/telemetry/reviewer-vram-check.sh $*"
}

# Quick attach to an existing agent-deck tmux session on the remote host
sanctuary-deck() {
    ssh -t sanctuary "agent-deck $*"
}
BASHEOF
    echo "[termux-bridge] Aliases added: teleport, vram-check, sanctuary-deck"
else
    echo "[termux-bridge] Aliases already present in $BASHRC — skipping."
fi

echo ""
echo "[termux-bridge] Setup complete."
echo ""
echo "Next steps:"
echo "  1. Copy your public key to the remote host:"
echo "     cat ~/.ssh/id_ed25519.pub"
echo "     # then on remote: echo '<key>' >> ~/.ssh/authorized_keys"
echo ""
echo "  2. Test the connection:"
echo "     ssh sanctuary"
echo ""
echo "  3. Reload your shell:"
echo "     source ~/.bashrc"
echo ""
echo "  4. Run teleport check:"
echo "     vram-check"
