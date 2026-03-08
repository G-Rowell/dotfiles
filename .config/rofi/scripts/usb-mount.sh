#!/usr/bin/env bash
# usb-mount.sh — rofi script modi for mounting/unmounting USB drives
# Place in your PATH or reference with full path in config.rasi

MOUNT_DIR="/run/media/$USER"

notify() {
    if command -v notify-send &>/dev/null; then
        notify-send "USB Manager" "$1"
    fi
}

# ── List mode (no argument) ──────────────────────────────────────────
if [ -z "$1" ]; then
    # Unmounted, mountable block devices (USB sticks, external drives)
    lsblk -rpo "NAME,SIZE,TYPE,MOUNTPOINT,TRAN" 2>/dev/null \
        | awk '$3=="part" && $4=="" && $5=="usb" {printf "  Mount %s (%s)\n", $1, $2}'

    # Currently mounted USB partitions
    lsblk -rpo "NAME,SIZE,TYPE,MOUNTPOINT,TRAN" 2>/dev/null \
        | awk '$3=="part" && $4!="" && $5=="usb" {printf "  Unmount %s (%s) [%s]\n", $1, $2, $4}'

    # If nothing was printed, show a placeholder
    if ! lsblk -rpo "NAME,TYPE,TRAN" 2>/dev/null | awk '$2=="part" && $3=="usb"' | grep -q .; then
        echo "  No USB devices detected"
    fi
    exit 0
fi

# ── Action mode (user selected an entry) ─────────────────────────────
choice="$1"

if echo "$choice" | grep -q "^  Mount"; then
    dev=$(echo "$choice" | awk '{print $3}')
    # Use udisksctl for unprivileged mount
    if command -v udisksctl &>/dev/null; then
        result=$(udisksctl mount -b "$dev" 2>&1)
        notify "$result"
    else
        # Fallback: manual mount
        label=$(lsblk -no LABEL "$dev" | tr -d '[:space:]')
        [ -z "$label" ] && label=$(basename "$dev")
        mountpoint="$MOUNT_DIR/$label"
        mkdir -p "$mountpoint"
        sudo mount "$dev" "$mountpoint" && notify "Mounted $dev at $mountpoint" || notify "Failed to mount $dev"
    fi

elif echo "$choice" | grep -q "^  Unmount"; then
    dev=$(echo "$choice" | awk '{print $3}')
    if command -v udisksctl &>/dev/null; then
        result=$(udisksctl unmount -b "$dev" 2>&1)
        # Optionally power off the drive
        udisksctl power-off -b "$dev" 2>/dev/null
        notify "$result"
    else
        sudo umount "$dev" && notify "Unmounted $dev" || notify "Failed to unmount $dev"
    fi
fi
