#!/usr/bin/env bash
# screenshot.sh — rofi script modi for screenshots (grim + slurp, Wayland)
# Place in your PATH or reference with full path in config.rasi

SCREENSHOT_DIR="$HOME/Pictures/Screenshots"
mkdir -p "$SCREENSHOT_DIR"
TIMESTAMP=$(date '+%Y-%m-%d_%H-%M-%S')

notify() {
    if command -v notify-send &>/dev/null; then
        notify-send "Screenshot" "$1"
    fi
}

# ── List mode ────────────────────────────────────────────────────────
if [ -z "$1" ]; then
    echo "  Region  →  select area"
    echo "  Fullscreen  →  entire screen"
    echo "  Region → clipboard"
    echo "  Fullscreen → clipboard"
    echo "  Active window"
    exit 0
fi

# ── Action mode ──────────────────────────────────────────────────────
# Small delay so rofi can close before slurp grabs input
sleep 0.3

case "$1" in
    *"Region  →  select area"*)
        file="$SCREENSHOT_DIR/region_$TIMESTAMP.png"
        grim -g "$(slurp)" "$file" && notify "Saved to $file"
        ;;
    *"Fullscreen  →  entire screen"*)
        file="$SCREENSHOT_DIR/full_$TIMESTAMP.png"
        grim "$file" && notify "Saved to $file"
        ;;
    *"Region → clipboard"*)
        grim -g "$(slurp)" - | wl-copy && notify "Region copied to clipboard"
        ;;
    *"Fullscreen → clipboard"*)
        grim - | wl-copy && notify "Fullscreen copied to clipboard"
        ;;
    *"Active window"*)
        if command -v swaymsg &>/dev/null; then
            geometry=$(swaymsg -t get_tree | jq -r '.. | select(.focused?) | .rect | "\(.x),\(.y) \(.width)x\(.height)"')
        elif command -v hyprctl &>/dev/null; then
            geometry=$(hyprctl activewindow -j | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"')
        else
            notify "Could not detect active window (need sway or hyprland)"
            exit 1
        fi
        file="$SCREENSHOT_DIR/window_$TIMESTAMP.png"
        grim -g "$geometry" "$file" && notify "Saved to $file"
        ;;
esac
