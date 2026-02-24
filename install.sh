#!/bin/bash
set -e

echo "----------------------------------------------------"
echo "1. Update system and install packages"
echo "----------------------------------------------------"
sudo apt update && sudo apt upgrade -y
sudo apt install -y --no-install-recommends \
    labwc wlr-randr greetd tuigreet alacritty \
    thunar thunar-archive-plugin xarchiver \
    mousepad wl-clipboard fcitx5 fcitx5-hangul fonts-noto-cjk \
    pipewire wireplumber pipewire-pulse cava \
    lxappearance librsvg2-common wlopm swayidle swaybg \
    waybar firefox-esr \

echo "----------------------------------------------------"
echo "2. Download themes and icons"
echo "----------------------------------------------------"
git clone https://github.com/Fausto-Korpsvart/Catppuccin-GTK-Theme.git

echo "----------------------------------------------------"
echo "3. Download and install JetBrainsMono Nerd Font"
echo "----------------------------------------------------"
wget -P /tmp https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.zip
sudo mkdir -p /usr/local/share/fonts/JetBrainsMono
sudo unzip /tmp/JetBrainsMono.zip -d /usr/local/share/fonts/JetBrainsMono
sudo fc-cache -fv

echo "----------------------------------------------------"
echo "4. Copy config files and directories"
echo "----------------------------------------------------"
mkdir -p "$HOME/.config"

cp -rT ./alacritty "$HOME/.config/alacritty"
cp -rT ./labwc "$HOME/.config/labwc"
cp -rT ./waybar "$HOME/.config/waybar"
cp -rT ./xfce4 "$HOME/.config/xfce4"
sudo cp -f ./greetd/config.toml /etc/greetd/config.toml

chmod +x "$HOME/.config/waybar/script/cava.sh"

echo "----------------------------------------------------"
echo "5. Set boot target to graphical and enable greetd service"
echo "----------------------------------------------------"
sudo systemctl set-default graphical.target

echo "----------------------------------------------------"
echo "Installation and system configuration complete!"
echo "----------------------------------------------------"
