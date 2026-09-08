#!/usr/bin/env bash
export XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}"
export WAYLAND_DISPLAY="${WAYLAND_DISPLAY:-wayland-1}"

pkill waybar
pkill swaync

sleep 0.2

nohup waybar >/dev/null 2>&1 &
nohup swaync >/dev/null 2>&1 &

