#!/bin/bash

packages=(
  nvidia-prime nvidia-open nvidia-utils
  ghostty tmux
  zsh starship eza zoxide
  nvim npm unzip
  waybar awww mako
  bluez blueman
  pavucontrol
  rofi rofi-emoji cliphist
  hyprlock hypridle hyprshot hyprsunset
  brave-bin spotify-adblock vesktop-bin
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

stow ghostty hypr mako nvim rofi tmux waybar yazi zsh

sudo mv FiraCodeNerdFont-BoldItalic.ttf /usr/share/fonts/
sudo mv FiraCodeNerdFont-Italic.ttf     /usr/share/fonts/

paru -Rns kitty dolphin
