# profile-snippets.ps1
# PowerShell profile snippets for Sanctuary Runtime bridge helpers.
#
# Add these snippets to your PowerShell profile ($PROFILE) on Windows
# to get WSL-bridged opencode, omo, and teleport-agent commands.
#
# Usage:
#   1. Open PowerShell
#   2. Run: notepad $PROFILE  (or code $PROFILE)
#   3. Paste or dot-source this file:
#        . "C:\path\to\sanctuary-runtime\bridge\powershell\profile-snippets.ps1"
#   4. Reload your profile: . $PROFILE
#
# Prerequisites:
#   - WSL 2 installed and a Linux distribution configured
#   - opencode, omo, and/or teleport-agent installed inside WSL
#
# TODO: adjust WSL_DISTRO to match your installed distribution name.

$WSL_DISTRO = "Ubuntu"  # TODO: change to your WSL distro name (wsl -l -v to list)

# ── opencode ─────────────────────────────────────────────────────────────────
# Runs opencode inside WSL, forwarding all arguments and the current directory.
function opencode {
    param([Parameter(ValueFromRemainingArguments=$true)][string[]]$args)
    $wslPath = wsl -d $WSL_DISTRO -- wslpath -u (Get-Location).Path
    wsl -d $WSL_DISTRO -- bash -lc "cd '$wslPath' && opencode $($args -join ' ')"
}

# ── omo ───────────────────────────────────────────────────────────────────────
# Runs omo (OpenCode meta-orchestrator, if installed) inside WSL.
function omo {
    param([Parameter(ValueFromRemainingArguments=$true)][string[]]$args)
    $wslPath = wsl -d $WSL_DISTRO -- wslpath -u (Get-Location).Path
    wsl -d $WSL_DISTRO -- bash -lc "cd '$wslPath' && omo $($args -join ' ')"
}

# ── teleport-agent ────────────────────────────────────────────────────────────
# Calls the sanctuary-runtime teleport script inside WSL.
# Adjust the path to vram_teleport.py to match your WSL home layout.
function teleport-agent {
    param(
        [string]$PromUrl = "http://localhost:9090",
        [switch]$DryRun
    )
    $wslPath = wsl -d $WSL_DISTRO -- wslpath -u (Get-Location).Path
    $drFlag = if ($DryRun) { "--dry-run" } else { "" }
    wsl -d $WSL_DISTRO -- bash -lc `
        "cd '$wslPath' && python3 ~/sanctuary-runtime/agent-runtime/scripts/vram_teleport.py --prometheus-url '$PromUrl' $drFlag"
}

# ── agent-deck ────────────────────────────────────────────────────────────────
# Shortcut to run agent-deck TUI inside WSL (attaches to existing tmux if possible).
function agent-deck {
    param([Parameter(ValueFromRemainingArguments=$true)][string[]]$args)
    wsl -d $WSL_DISTRO -- bash -lc "agent-deck $($args -join ' ')"
}

Write-Host "[sanctuary-bridge] PowerShell WSL bridge loaded. Commands: opencode, omo, teleport-agent, agent-deck"
