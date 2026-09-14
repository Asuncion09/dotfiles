#!/usr/bin/env python3
import colorsys
import glob
import json
import os
import re
import subprocess
from pathlib import Path

HOME = Path.home()
THEME_JSON = HOME / ".config/quickshell/state/dynamic_theme.json"
GTK_CSS = HOME / ".config/gtk-4.0/gtk.css"
ICON_THEME_DIR = HOME / ".local/share/icons/matugen-adwaita"
PLACES_DIR = ICON_THEME_DIR / "scalable/places"
ADWAITA_PLACES = Path("/usr/share/icons/Adwaita/scalable/places")

def adjust_lightness(hex_color, factor):
    hex_color = hex_color.lstrip('#')
    r, g, b = tuple(int(hex_color[i:i+2], 16) / 255.0 for i in (0, 2, 4))
    h, l, s = colorsys.rgb_to_hls(r, g, b)
    l = max(0.0, min(1.0, l * factor))
    r, g, b = colorsys.hls_to_rgb(h, l, s)
    return f"#{int(r * 255):02x}{int(g * 255):02x}{int(b * 255):02x}"

def get_primary_color():
    # 1. Try GTK CSS rendered by matugen
    if GTK_CSS.exists():
        try:
            with open(GTK_CSS, "r", encoding="utf-8") as f:
                for line in f:
                    m = re.search(r"@define-color\s+accent_color\s+(#[0-9a-fA-F]{6})", line)
                    if m:
                        return m.group(1)
        except Exception:
            pass

    # 2. Try Quickshell dynamic_theme.json
    if THEME_JSON.exists():
        try:
            with open(THEME_JSON, "r", encoding="utf-8") as f:
                data = json.load(f)
            colors = data.get("colors", {})
            primary_obj = colors.get("primary", {})
            c = primary_obj.get("dark", {}).get("color") or primary_obj.get("default", {}).get("color")
            if c:
                return c
        except Exception:
            pass

    return "#dbc3a4"

def main():
    primary = get_primary_color()

    # Generate harmonious folder palette shades
    mid_base = primary
    darker_back = adjust_lightness(primary, 0.72)
    light_front = adjust_lightness(primary, 1.08)
    subtle_shine = adjust_lightness(primary, 1.10)
    bright_shine = adjust_lightness(primary, 1.18)

    replacements = {
        "#438de6": darker_back,
        "#62a0ea": mid_base,
        "#afd4ff": bright_shine,
        "#c0d5ea": subtle_shine,
        "#a4caee": light_front
    }

    PLACES_DIR.mkdir(parents=True, exist_ok=True)

    # Ensure index.theme exists
    index_theme = ICON_THEME_DIR / "index.theme"
    if not index_theme.exists():
        with open(index_theme, "w", encoding="utf-8") as f:
            f.write("""[Icon Theme]
Name=Matugen Adwaita
Comment=Dynamic Material You tinted folders by Matugen
Inherits=Adwaita,hicolor
Directories=scalable/places

[scalable/places]
Size=128
Context=Places
Type=Scalable
MinSize=16
MaxSize=512
""")

    # Recolor all place icons that use Adwaita folder blue
    if ADWAITA_PLACES.exists():
        for svg_path in ADWAITA_PLACES.glob("*.svg"):
            try:
                with open(svg_path, "r", encoding="utf-8") as f:
                    content = f.read()

                if "#62a0ea" in content.lower() or "#438de6" in content.lower():
                    for old_hex, new_hex in replacements.items():
                        content = re.sub(old_hex, new_hex, content, flags=re.IGNORECASE)

                    dest = PLACES_DIR / svg_path.name
                    with open(dest, "w", encoding="utf-8") as f:
                        f.write(content)
            except Exception as e:
                print(f"Skipping {svg_path.name}: {e}")

    # Update icon cache
    subprocess.run(["gtk-update-icon-cache", "-f", "-t", str(ICON_THEME_DIR)], capture_output=True)

    # Ensure system uses matugen-adwaita icon theme
    subprocess.run(["gsettings", "set", "org.gnome.desktop.interface", "icon-theme", "matugen-adwaita"], capture_output=True)

    # Update gtk-3.0 and gtk-4.0 settings.ini
    for ini_path in [HOME / ".config/gtk-3.0/settings.ini", HOME / ".config/gtk-4.0/settings.ini"]:
        if ini_path.exists():
            try:
                with open(ini_path, "r", encoding="utf-8") as f:
                    lines = f.readlines()
                new_lines = []
                for line in lines:
                    if line.startswith("gtk-icon-theme-name="):
                        new_lines.append("gtk-icon-theme-name=matugen-adwaita\n")
                    else:
                        new_lines.append(line)
                with open(ini_path, "w", encoding="utf-8") as f:
                    f.writelines(new_lines)
            except Exception:
                pass

    # Restart nautilus daemon so it renders new folder icons immediately
    subprocess.run(["nautilus", "-q"], capture_output=True)
    print(f"Successfully generated matugen-adwaita folder icons with accent: {primary}")

if __name__ == "__main__":
    main()
