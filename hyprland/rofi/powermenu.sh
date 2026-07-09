#!/usr/bin/env bash

# Iconos limpios de Nerd Fonts (sin la opción de bloqueo)
logout="󰍃"
reboot=""
shutdown="󰐥"

# Pasar las 3 opciones en horizontal a Rofi
chosen=$(echo -e "$logout\n$reboot\n$shutdown" | rofi -dmenu -i -layer-shell -theme ~/.config/rofi/powermenu.rasi)

case "$chosen" in
    "$logout")
        loginctl terminate-user "$USER"
        ;;
    "$reboot")
        systemctl reboot
        ;;
    "$shutdown")
        systemctl poweroff
        ;;
esac
