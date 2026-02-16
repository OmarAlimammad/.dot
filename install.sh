#!/bin/bash

# Configuration
DOT_DIR="$HOME/.dot"
PACKAGES=(
    nvim npm unzip zsh zoxide starship eza tmux bazaar 
    firefox thunar swww swaync hypremoji hyprshot waybar 
    rofi stow nwg-look ttf-jetbrains-mono-nerd rose-pine-gtk-theme
)
STOW_FOLDERS=(zsh hypr tmux kitty nvim waybar rofi)

# 1. Install Packages
echo "📦 Installing packages..."
yay -S --noconfirm "${PACKAGES[@]}"

# 2. Stow Dotfiles
echo "🔗 Stowing configurations..."
cd "$DOT_DIR" || exit
for folder in "${STOW_FOLDERS[@]}"; do
    stow -D "$folder" 2>/dev/null
    stow "$folder"
done

# 3. Change Shell
echo "🐚 Changing shell to zsh..."
chsh -s /usr/bin/zsh

echo "✅ Done."