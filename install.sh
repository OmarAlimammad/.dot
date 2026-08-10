#!/bin/bash

packages=(
  nvidia-prime nvidia-open nvidia-utils
  ghostty tmux
  zsh starship eza zoxide
  nvim npm unzip
  waybar awww mako
  bluez blueman
  brightnessctl
  pavucontrol
  rofi rofi-emoji cliphist
  hyprlock hypridle hyprshot hyprsunset
  brave-bin spotify-adblock
  vesktop-bin elecwhat-bin telegram-desktop
  stremio-linux-shell
  thunar yazi fzf
  libreoffice-fresh
  stow nwg-look
  gruvbox-gtk-theme-git
  gruvbox-icon-theme-git
  xcursor-simp1e-gruvbox-dark
  ttf-firacode-nerd inter-font
)

cd paru
makepkg -si
cd ..

paru -Syu --needed --noconfirm "${packages[@]}"

stow ghostty hypr mako nvim rofi tmux waybar yazi zsh

sudo mv FiraCodeNerdFont-BoldItalic.ttf /usr/share/fonts/
sudo mv FiraCodeNerdFont-Italic.ttf     /usr/share/fonts/

paru -Rns kitty dolphin
