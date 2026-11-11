#!/bin/bash

packages=(
  nvidia-prime nvidia-open nvidia-utils
  ghostty tmux
  zsh starship eza zoxide
  nvim npm unzip ripgrep
  waybar awww mako
  bluez blueman
  brightnessctl
  pavucontrol
  rofi rofi-emoji cliphist
  hyprlock hypridle hyprshot hyprsunset
  brave-bin spotify-adblock
  vesktop-bin
  yazi fzf
  libreoffice-fresh
  stow nwg-look
  gruvbox-gtk-theme-git
  gruvbox-plus-icon-theme
  xcursor-simp1e-gruvbox-dark
  ttf-firacode-nerd inter-font
)

cd paru
makepkg -si
cd ..

paru -Syu --needed --noconfirm "${packages[@]}"

stow ghostty hypr mako nvim rofi tmux waybar yazi zsh

sudo cp FiraCodeNerdFont-BoldItalic.ttf /usr/share/fonts/
sudo cp FiraCodeNerdFont-Italic.ttf     /usr/share/fonts/

paru -Rns kitty dolphin

curl -fsSL https://claude.ai/install.sh | bash
curl -s "https://raw.githubusercontent.com/shvedes/discord-gruvbox/refs/heads/main/install.sh" | bash
