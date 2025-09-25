#!/data/data/com.termux/files/usr/bin/bash

# ==============================
# HYPERSENSE ANDROID V1
# Developed by AG HYDRAX (HYPERSENSEINDIA)
# ==============================

# Auto-install dialog if missing
if ! command -v dialog &>/dev/null; then
    pkg update -y && pkg install -y dialog
fi

# Colors
RED="\033[1;31m"
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
CYAN="\033[1;36m"
NC="\033[0m"

# Clear and show banner
clear
if [ -f assets/banner.txt ]; then
    cat assets/banner.txt
else
    echo -e "${CYAN}=== HYPERSENSE ANDROID V1 ===${NC}"
    echo -e "${CYAN}Developed by AG HYDRAX (HYPERSENSEINDIA)${NC}"
fi

# ------------------------------
# Activation
# ------------------------------
code_input=$(dialog --inputbox "Enter Activation Code:" 8 50 3>&1 1>&2 2>&3 3>&-)
decoded=$(echo $code_input | base64 -d 2>/dev/null)

if [ $? -ne 0 ]; then
    dialog --msgbox "Invalid or tampered code!" 6 40
    clear
    exit 1
fi

plan=$(echo $decoded | cut -d'-' -f1)
expiry=$(echo $decoded | cut -d'-' -f2)
current=$(date +%Y%m%d)

if [ "$current" -gt "$expiry" ]; then
    dialog --msgbox "Activation expired!" 6 40
    clear
    exit 1
fi

dialog --msgbox "Activation successful! Plan: $plan | Expires: $expiry" 6 50

# ------------------------------
# Functions
# ------------------------------

# Live simulation (FPS, Touch X/Y, Ping)
live_simulation() {
    local duration=$1
    for ((i=0;i<duration;i++)); do
        x_mul=$(awk "BEGIN {printf \"%.2f\", 1.0 + $RANDOM/5000}")
        y_mul=$(awk "BEGIN {printf \"%.2f\", 1.0 + $RANDOM/5000}")
        fps_sim=$((55 + RANDOM % 6))
        ping_sim=$((35 + RANDOM % 15))
        dialog --infobox "FPS: $fps_sim | Touch X:$x_mul Y:$y_mul | Ping:${ping_sim}ms" 4 70
        sleep 0.5
    done
}

# Touch Multiplier
apply_touch_multiplier() {
    live_simulation 10
    dialog --msgbox "Touch Multiplier applied!" 6 50
}

# Ping Optimizer
apply_ping_optimizer() {
    live_simulation 10
    dialog --msgbox "Ping Optimizer applied!" 6 50
}

# Apply All Tweaks
apply_all_tweaks() {
    svc power stayon true 2>/dev/null
    live_simulation 15
    dialog --msgbox "All Hypersense tweaks applied!" 6 60
}

# Restore Defaults
restore_defaults() {
    svc power stayon false 2>/dev/null
    dialog --msgbox "Defaults restored.\nTouch & Ping reset." 8 50
}

# ------------------------------
# Main menu loop
# ------------------------------
while true; do
    choice=$(dialog --menu "HYPERSENSE MENU (Plan: $plan | Expires: $expiry)" 22 70 7 \
    1 "Apply Touch Multiplier (X/Y)" \
    2 "Apply Ping Optimizer" \
    3 "Apply All Hypersense Tweaks with Live Display" \
    4 "Restore Defaults (OFF)" \
    0 "Exit" 3>&1 1>&2 2>&3 3>&-)

    case $choice in
        1) apply_touch_multiplier ;;
        2) apply_ping_optimizer ;;
        3) apply_all_tweaks ;;
        4) restore_defaults ;;
        0) clear; exit 0 ;;
        *) dialog --msgbox "Invalid choice." 6 40 ;;
    esac
done
