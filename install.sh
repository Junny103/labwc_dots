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
    lxappearance librsvg2-common waybar swaybg firefox-esr \
    jq

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

echo "4. Copy config files and directories"
mkdir -p "$HOME/.config"

cp -rT ./alacritty "$HOME/.config/alacritty"
cp -rT ./labwc "$HOME/.config/labwc"
cp -rT ./waybar "$HOME/.config/waybar"
cp -rT ./xfce4 "$HOME/.config/xfce4"

chmod +x "$HOME/.config/waybar/script/cava.sh"
sudo cp -f ./config.toml /etc/greetd/config.toml

echo "----------------------------------------------------"
echo "5. Set boot target to graphical and enable greetd service"
echo "----------------------------------------------------"
sudo systemctl set-default graphical.target

echo "----------------------------------------------------"
echo "6. Install uConsole-sleep (latest version)"
echo "----------------------------------------------------"
LATEST_URL=$(curl -s https://api.github.com/repos/qkdxorjs1002/uConsole-sleep/releases/latest \
    | jq -r '.assets[] | select(.name | test("deb$")) | .browser_download_url')

wget -P /tmp "$LATEST_URL"

DEB_FILE=$(basename "$LATEST_URL")
sudo apt install -y /tmp/$DEB_FILE

echo "----------------------------------------------------"
echo "Installation and system configuration complete!"
echo "----------------------------------------------------"

echo "System will reboot automatically in 5 seconds."
echo "Press 'n' to cancel the reboot."

read -t 5 -p "Cancel reboot (n): " answer

if [[ "$answer" =~ ^[Nn]$ ]]; then
    echo "Reboot canceled. You can reboot manually later."
else
    echo "Rebooting now..."
    sudo reboot
fi
