#!/usr/bin/env bash
# power.sh — rofi script modi for power options

notify() {
    command -v notify-send &>/dev/null && notify-send "Power" "$1"
}

# ── List mode ────────────────────────────────────────────────────────
if [ -z "$1" ]; then
    # echo "  Lock"
    # echo "  Logout"
    echo "  Suspend"
    echo "  Reboot"
    echo "  Shutdown"
    exit 0
fi

# ── Action mode ──────────────────────────────────────────────────────
case "$1" in
    # *Lock*)
    #     noop
    #
    # ;;
    # *Logout*)
    #     hyprctl dispatch exit
    #
    # ;;
    *Suspend*)
        systemctl suspend
        ;;
    *Reboot*)
        systemctl reboot
        ;;
    *Shutdown*)
        systemctl poweroff
        ;;
esac
