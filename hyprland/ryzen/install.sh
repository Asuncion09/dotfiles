#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")"

# Validar sudoers antes de instalarlo (un error ahí puede dejarte sin sudo)
sudo visudo -cf etc/sudoers.d/ryzenadj

sudo install -m 755 usr/local/bin/*         /usr/local/bin/
sudo install -m 644 etc/systemd/system/*    /etc/systemd/system/
sudo install -m 644 etc/udev/rules.d/*      /etc/udev/rules.d/
sudo install -m 440 etc/sudoers.d/ryzenadj  /etc/sudoers.d/ryzenadj

sudo systemctl daemon-reload
sudo udevadm control --reload
sudo systemctl enable ryzenadj-boot.service
sudo systemctl enable --now ryzenadj-watchdog.timer

echo "✅ Instalado. Usa: rs"
