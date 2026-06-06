# DOTFILES

My personal Linux dotfiles configuration v1.0

A complete setup for a modern Linux development environment with:
- **Window Managers**: Awesome, BSPWM, Openbox
- **Terminal & Shell**: Kitty, Ghostty, Zsh with Oh My Zsh
- **Editor**: Neovim with LSP, DAP, Treesitter
- **UI Enhancements**: Polybar, Starship, Picom compositor
- **Customization**: Multiple themes for Awesome WM, custom fonts

---

## 📋 Prerequisites

- Linux (tested on Arch-based distributions)
- `git` and `curl` installed
- `zsh` installed
- For Neovim setup: `nvim 0.9+`

## 🚀 Quick Installation

Run the automated installation script:

```bash
./install.sh
```

This script will:
1. Install Oh My Zsh with plugins
2. Set up Zsh autosuggestions and syntax highlighting
3. Guide you through optional component installations

Or follow the [Manual Installation](#manual-installation) section below.

## 📂 Directory Structure

```
dotfiles/
├── nvim/              # Neovim configuration (LSP, DAP, Treesitter)
├── awesome/           # Awesome WM configs with multiple themes
├── bspwm/             # BSPWM window manager setup
├── openbox/           # Openbox WM with custom scripts
├── fonts/             # Custom fonts (Iosevka, Azuki, etc.)
├── config.ghostty     # Ghostty terminal config
├── kitty.conf         # Kitty terminal config
├── picom.conf         # Compositor configuration
├── starship.toml      # Starship prompt configuration
└── README.md          # This file
```

## 🔧 Manual Installation

### Install Oh My Zsh

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### Install Zsh Plugins

```bash
# Autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Syntax Highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

Update your `~/.zshrc`:
```bash
plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
)
```

### Install Configuration Files

Create symbolic links in your home directory:

```bash
# Neovim
ln -sf ~/dotfiles/nvim ~/.config/nvim

# Terminal emulators
ln -sf ~/dotfiles/kitty.conf ~/.config/kitty/kitty.conf
ln -sf ~/dotfiles/config.ghostty ~/.config/ghostty/config

# Starship prompt
ln -sf ~/dotfiles/starship.toml ~/.config/starship.toml

# Window Managers (choose one or more)
ln -sf ~/dotfiles/awesome ~/.config/awesome
ln -sf ~/dotfiles/bspwm ~/.config/bspwm
ln -sf ~/dotfiles/openbox ~/.config/openbox
```

## 🎨 Awesome WM Themes

Available themes in `awesome/themes/`:
- Blackburn
- Copland
- Dremora
- Holo
- Multicolor
- Powerarrow
- Powerarrow Dark
- Rainbow
- Steamburn
- Vertex

Change theme by editing `awesome/rc.lua`

## 🔌 Neovim Plugins

Managed with Packer. Key plugins:
- **LSP**: Native LSP configuration
- **DAP**: Debugger support
- **Treesitter**: Better syntax highlighting
- **Telescope**: Fuzzy finder
- **Lualine**: Status line
- **Bufferline**: Buffer management
- **Nvim-tree**: File explorer

## 📝 Notes

- Tested on Arch Linux (may work on other distributions)
- Customize paths and settings according to your setup
- Some window managers may require additional dependencies

## 📄 License

Feel free to use and modify these dotfiles for your own setup.

