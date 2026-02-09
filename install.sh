#!/bin/bash

# 1. Update system and install packages
sudo apt update && sudo apt upgrade -y
sudo apt install -y --no-install-recommends \
    labwc wlr-randr greetd tuigreet waybar swaybg alacritty \
    firefox-esr fcitx5 fcitx5-hangul fonts-noto-cjk \
    thunar mousepad wl-clipboard cliphist wofi \
    pipewire wireplumber pipewire-pulse

# 2. Download and install JetBrainsMono Nerd Font
echo "Downloading and installing JetBrainsMono Nerd Font..."
wget -P /tmp https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.zip
sudo mkdir -p /usr/local/share/fonts/JetBrainsMono
sudo unzip /tmp/JetBrainsMono.zip -d /usr/local/share/fonts/JetBrainsMono
sudo fc-cache -fv

# 3. Configure greetd with tuigreet
echo "Configuring greetd with tuigreet..."
sudo tee /etc/greetd/config.toml > /dev/null <<EOF
[terminal]
vt = 1

[default_session]
command = "tuigreet --asterisks --remember --cmd labwc"
user = "greeter"
EOF

# 4. Set boot target to graphical and enable greetd service
sudo systemctl set-default graphical.target
sudo systemctl enable greetd

echo "----------------------------------------------------"
echo "Installation and system configuration complete!"
echo "----------------------------------------------------"
