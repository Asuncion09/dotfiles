# Hyprland Dotfiles - Entorno Desktop Moderno

Configuración completa de Hyprland con múltiples utilidades, temas de color intercambiables y gestión de energía para CPUs Ryzen.

## 📦 Contenido

- **Hyprland** - Gestor de ventanas dinámico (config en Lua modular)
- **Waybar** - Barra de estado con múltiples temas
- **Rofi** - Lanzador de aplicaciones
- **Ghostty** - Emulador de terminal
- **RyzenAdj** - Gestión de energía para CPUs Ryzen
- **Swaync/Mako** - Servidores de notificaciones
- **Temas** - Nord, Dracula, Catppuccin, Onedark

---

## 🚀 Instalación

### 1. Instalar dependencias del sistema

**Debian/Ubuntu:**
```bash
sudo apt install build-essential cmake libpci-dev
```

**Fedora:**
```bash
sudo dnf install cmake gcc gcc-c++ dkms openssl pciutils-devel
```

**Arch:**
```bash
sudo pacman -S base-devel pciutils cmake
```

**OpenSUSE:**
```bash
sudo zypper in cmake gcc14-c++ pciutils-devel
```

### 2. Instalar módulo ryzen_smu (kernel module)

```bash
git clone https://github.com/amkillam/ryzen_smu
cd ryzen_smu && sudo make dkms-install
cd ..
```

**Si usas Secure Boot:**
```bash
sudo mokutil --import /var/lib/dkms/mok.pub
# Establece una contraseña (solo se necesita una vez en MOK manager)
```

### 3. Compilar e instalar RyzenAdj

```bash
git clone https://github.com/FlyGoat/RyzenAdj
cd RyzenAdj
cmake -B build -DCMAKE_BUILD_TYPE=Release
make -C build -j"$(nproc)"
sudo cp -v build/ryzenadj /usr/local/bin/
```

### 4. Instalar scripts de perfil

```bash
sudo cp ryzenadj-*.sh ryzenadj-selector rs /usr/local/bin/
sudo chmod +x /usr/local/bin/ryzenadj-*.sh /usr/local/bin/ryzenadj-selector /usr/local/bin/rs
```

### 5. Configurar servicio systemd (opcional)

```bash
sudo cp ryzenadj@.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable ryzenadj@gaming  # o balanced, power-save
sudo systemctl start ryzenadj@gaming
```

---

## ⚡ Perfiles de RyzenAdj

| Perfil | STAPM | Fast Limit | Slow Limit | Temp | Uso |
|--------|-------|------------|------------|------|-----|
| **balanced** | 28W | 32W | 25W | 80°C | Rendimiento diario sin exceso de calor |
| **gaming** | 40W | 45W | 40W | 90°C | Máximo rendimiento en juegos |
| **power-save** | 15W | 18W | 12W | 70°C | Máxima eficiencia energética |

### Usar perfil manual

```bash
/usr/local/bin/ryzenadj-balanced.sh
/usr/local/bin/ryzenadj-gaming.sh
/usr/local/bin/ryzenadj-power-save.sh
```

### Con el script selector (interactivo)

```bash
# Menú interactivo
ryzenadj-selector

# Cambiar directo a un perfil
ryzenadj-selector balanced
ryzenadj-selector gaming
ryzenadj-selector power-save

# Ver perfil actual
ryzenadj-selector -s

# Ayuda
ryzenadj-selector -h
```

### O con el script rápido (legacy)

```bash
rs [balanced|gaming|power-save]
```

---

## 🎨 Temas disponibles

- **Waybar** - `colors/`: catppuccin, default, dracula, nord
- **Rofi** - `colors/`: nord, onedark
- **Swaync** - `colors/`: nord
- **JetBrains Mono** - Fuente incluida

---

## 📝 Estructura

```
├── hypr/                    # Configuración Hyprland (Lua)
├── waybar/                  # Barra de estado + temas
├── rofi/                    # Lanzador + menú
├── swaync/                  # Centro de notificaciones
├── mako/                    # Notificaciones alternativo
├── swayosd/                 # Indicadores OSD
├── JetBrainsMono/          # Fuente monoespaciada
├── ryzenadj-*.sh           # Perfiles de energía
├── rs                       # Script selector de perfiles
└── config.ghostty          # Configuración terminal
```
