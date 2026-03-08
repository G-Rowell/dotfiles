#!/usr/bin/env bash
# usb-mount.sh — rofi script modi for mounting/unmounting USB drives
# Place in your PATH or reference with full path in config.rasi
#
# Uses lsblk -Pp (key="value" pairs) to avoid column-alignment bugs
# that occur with raw (-r) output when MOUNTPOINT is empty.
# Checks both RM (removable) and HOTPLUG columns for broad compatibility.

MOUNT_DIR="/run/media/$USER"

notify() {
    if command -v notify-send &>/dev/null; then
        notify-send "USB Manager" "$1"
    fi
}

# Helper: returns 0 if the device looks like a removable/USB device.
# Accepts a line of lsblk -Pp output.
is_removable() {
    local line="$1"
    local rm hotplug
    rm=$(echo "$line"      | grep -oP 'RM="\K[^"]+')
    hotplug=$(echo "$line" | grep -oP 'HOTPLUG="\K[^"]+')
    [[ "$rm" == "1" || "$hotplug" == "1" ]]
}

# ── List mode (no argument) ──────────────────────────────────────────
if [ -z "$1" ]; then
    found=0

    while IFS= read -r line; do
        [ -z "$line" ] && continue
        type=$(echo "$line"       | grep -oP 'TYPE="\K[^"]+')
        mountpoint=$(echo "$line" | grep -oP 'MOUNTPOINT="\K[^"]+')
        name=$(echo "$line"       | grep -oP 'NAME="\K[^"]+')
        size=$(echo "$line"       | grep -oP 'SIZE="\K[^"]+')

        # Only care about partitions (or whole disks with no child partitions)
        [[ "$type" != "part" && "$type" != "disk" ]] && continue
        # If it's a disk, skip it when it has child partitions (we list those instead)
        if [[ "$type" == "disk" ]]; then
            has_parts=$(lsblk -nro TYPE "$name" 2>/dev/null | grep -c "part")
            [[ "$has_parts" -gt 0 ]] && continue
        fi

        is_removable "$line" || continue
        found=1

        if [ -z "$mountpoint" ]; then
            echo "  Mount $name ($size)"
        else
            echo "  Unmount $name ($size) [$mountpoint]"
        fi
    done < <(lsblk -Ppo "NAME,SIZE,TYPE,MOUNTPOINT,RM,HOTPLUG" 2>/dev/null)

    if [ "$found" -eq 0 ]; then
        echo "  No USB devices detected"
    fi
    exit 0
fi

# ── Action mode (user selected an entry) ─────────────────────────────
choice="$1"

if echo "$choice" | grep -q "Mount"; then
    dev=$(echo "$choice" | grep -oP '/dev/\S+')
    if command -v udisksctl &>/dev/null; then
        result=$(udisksctl mount -b "$dev" 2>&1)
        notify "$result"
    else
        label=$(lsblk -no LABEL "$dev" | tr -d '[:space:]')
        [ -z "$label" ] && label=$(basename "$dev")
        mountpoint="$MOUNT_DIR/$label"
        mkdir -p "$mountpoint"
        sudo mount "$dev" "$mountpoint" && notify "Mounted $dev at $mountpoint" || notify "Failed to mount $dev"
    fi

elif echo "$choice" | grep -q "Unmount"; then
    dev=$(echo "$choice" | grep -oP '/dev/\S+')
    if command -v udisksctl &>/dev/null; then
        result=$(udisksctl unmount -b "$dev" 2>&1)
        udisksctl power-off -b "$dev" 2>/dev/null
        notify "$result"
    else
        sudo umount "$dev" && notify "Unmounted $dev" || notify "Failed to unmount $dev"
    fi
fi
