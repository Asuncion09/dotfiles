# Matugen Configuration & Templates

Configuración de tematización dinámica basada en **Material You** utilizando [Matugen](https://github.com/InioX/matugen).

## 📁 Estructura

- `config.toml`: Configuración principal de Matugen con armonización pastel (`blend = true`) y hooks de recarga en caliente.
- `templates/`:
  - `ghostty`: Tema dinámico para el emulador de terminal Ghostty (ANSI 0-15 en tonos suaves).
  - `gtk.css`: Estilos para GTK 3 y GTK 4 / Libadwaita (botones, selecciones, switches, colores de acento).
  - `starship.toml`: Prompt dinámico de Starship armonizado con el fondo de pantalla.
- `scripts/`:
  - `generate_folders.py`: Script que extrae el color de acento primario y genera las carpetas de Adwaita recoloreadas en `~/.local/share/icons/matugen-adwaita/`.

## 🚀 Instalación en un nuevo sistema

Enlazar a `~/.config/matugen`:
```bash
ln -s ~/Documents/dotfiles/hyprland/matugen ~/.config/matugen
```
