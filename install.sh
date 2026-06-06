#!/bin/bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Helper functions
print_header() {
    echo -e "${BLUE}========================================${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}========================================${NC}"
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

print_info() {
    echo -e "${YELLOW}ℹ $1${NC}"
}

# Check if running from dotfiles directory
if [ ! -f "install.sh" ] || [ ! -f "README.md" ]; then
    print_error "Please run this script from the dotfiles directory"
    exit 1
fi

# Get the dotfiles directory path
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
print_info "Dotfiles directory: $DOTFILES_DIR"

print_header "Starting Dotfiles Installation"

# Check prerequisites
print_header "Checking Prerequisites"

if command -v zsh &> /dev/null; then
    print_success "Zsh is installed"
else
    print_error "Zsh is not installed. Please install it first."
    exit 1
fi

if command -v git &> /dev/null; then
    print_success "Git is installed"
else
    print_error "Git is not installed. Please install it first."
    exit 1
fi

if command -v curl &> /dev/null; then
    print_success "Curl is installed"
else
    print_error "Curl is not installed. Please install it first."
    exit 1
fi

# Install Oh My Zsh
print_header "Installing Oh My Zsh"

if [ -d "$HOME/.oh-my-zsh" ]; then
    print_info "Oh My Zsh is already installed"
else
    print_info "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    print_success "Oh My Zsh installed"
fi

# Install Zsh plugins
print_header "Installing Zsh Plugins"

ZSH_PLUGINS_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins"

# Zsh Autosuggestions
if [ -d "$ZSH_PLUGINS_DIR/zsh-autosuggestions" ]; then
    print_info "zsh-autosuggestions already installed"
else
    print_info "Installing zsh-autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_PLUGINS_DIR/zsh-autosuggestions"
    print_success "zsh-autosuggestions installed"
fi

# Zsh Syntax Highlighting
if [ -d "$ZSH_PLUGINS_DIR/zsh-syntax-highlighting" ]; then
    print_info "zsh-syntax-highlighting already installed"
else
    print_info "Installing zsh-syntax-highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_PLUGINS_DIR/zsh-syntax-highlighting"
    print_success "zsh-syntax-highlighting installed"
fi

# Create symbolic links
print_header "Setting Up Configuration Links"

create_link() {
    local src="$1"
    local dest="$2"
    local name="$3"

    if [ ! -e "$src" ]; then
        print_error "$name source not found: $src"
        return 1
    fi

    mkdir -p "$(dirname "$dest")"

    if [ -e "$dest" ]; then
        if [ -L "$dest" ]; then
            print_info "$name link already exists, removing old link..."
            rm "$dest"
        else
            print_error "$dest already exists and is not a symlink. Please backup or remove it manually."
            return 1
        fi
    fi

    ln -sf "$src" "$dest"
    print_success "$name configured"
}

# Neovim
create_link "$DOTFILES_DIR/nvim" "$HOME/.config/nvim" "Neovim"

# Kitty
create_link "$DOTFILES_DIR/kitty.conf" "$HOME/.config/kitty/kitty.conf" "Kitty"

# Ghostty
create_link "$DOTFILES_DIR/config.ghostty" "$HOME/.config/ghostty/config" "Ghostty"

# Picom
create_link "$DOTFILES_DIR/picom.conf" "$HOME/.config/picom/picom.conf" "Picom"

# Starship
create_link "$DOTFILES_DIR/starship.toml" "$HOME/.config/starship.toml" "Starship"

# Window Managers (ask user which ones to install)
print_header "Window Managers Setup"

echo -e "${YELLOW}Which window managers would you like to install?${NC}"
echo "1) Awesome WM"
echo "2) BSPWM"
echo "3) Openbox"
echo "4) All"
echo "5) Skip"
read -p "Enter your choice (1-5): " wm_choice

case $wm_choice in
    1|4)
        create_link "$DOTFILES_DIR/awesome" "$HOME/.config/awesome" "Awesome WM"
        ;;
esac

case $wm_choice in
    2|4)
        create_link "$DOTFILES_DIR/bspwm" "$HOME/.config/bspwm" "BSPWM"
        ;;
esac

case $wm_choice in
    3|4)
        create_link "$DOTFILES_DIR/openbox" "$HOME/.config/openbox" "Openbox"
        ;;
esac

case $wm_choice in
    5)
        print_info "Skipping window managers"
        ;;
esac

# Optional: Install fonts
print_header "Fonts Installation"

echo -e "${YELLOW}Would you like to install custom fonts?${NC}"
read -p "Install fonts? (y/n): " -n 1 -r
echo

if [[ $REPLY =~ ^[Yy]$ ]]; then
    print_info "Copying fonts to ~/.local/share/fonts/"
    mkdir -p "$HOME/.local/share/fonts"
    
    if [ -d "$DOTFILES_DIR/fonts" ]; then
        cp -r "$DOTFILES_DIR/fonts/"* "$HOME/.local/share/fonts/" 2>/dev/null || print_error "Some fonts could not be copied"
        
        # Rebuild font cache
        if command -v fc-cache &> /dev/null; then
            fc-cache -fv "$HOME/.local/share/fonts/"
            print_success "Font cache rebuilt"
        else
            print_info "fc-cache not found. Run 'fc-cache -fv' manually after installation"
        fi
    fi
else
    print_info "Skipping fonts installation"
fi

# Final instructions
print_header "Installation Complete!"

echo -e "${GREEN}Dotfiles installation finished!${NC}"
echo
echo -e "${YELLOW}Next steps:${NC}"
echo "1. Update your ~/.zshrc to enable plugins:"
echo "   plugins=(git zsh-autosuggestions zsh-syntax-highlighting)"
echo
echo "2. Change your shell to zsh (if not already):"
echo "   chsh -s /bin/zsh"
echo
echo "3. Restart your terminal or run: exec zsh"
echo
echo "4. Customize configurations as needed in:"
echo "   - $HOME/.config/nvim/"
echo "   - $HOME/.config/awesome/ (or your WM of choice)"
echo "   - $HOME/.config/kitty/kitty.conf"
echo "   - $HOME/.config/starship.toml"
echo
print_info "For more information, see README.md"
