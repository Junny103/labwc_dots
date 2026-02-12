#!/bin/bash

# 1. Update system and install packages
sudo apt update && sudo apt upgrade -y
sudo apt install -y --no-install-recommends \
    labwc wlr-randr greetd tuigreet alacritty \
    thunar thunar-archive-plugin xarchiver \
    mousepad wl-clipboard fcitx5 fcitx5-hangul fonts-noto-cjk \
    pipewire wireplumber pipewire-pulse \
    waybar swaybg firefox-esr \

# 2. Download and install JetBrainsMono Nerd Font
echo "Downloading and installing JetBrainsMono Nerd Font..."
wget -P /tmp https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.zip
sudo mkdir -p /usr/local/share/fonts/JetBrainsMono
sudo unzip /tmp/JetBrainsMono.zip -d /usr/local/share/fonts/JetBrainsMono
sudo fc-cache -fv

# 3. Set boot target to graphical and enable greetd service
sudo systemctl set-default graphical.target

echo "----------------------------------------------------"
echo "Installation and system configuration complete!"
echo "----------------------------------------------------"
