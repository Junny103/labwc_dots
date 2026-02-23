#!/bin/bash
set -e

echo "----------------------------------------------------"
echo "1. Update system and install packages"
echo "----------------------------------------------------"
sudo apt update && sudo apt upgrade -y
sudo apt install -y \
    cmake libfreetype-dev libqt6opengl6-dev \
    libopenal-dev libavcodec-dev libyaml-cpp-dev \

echo "----------------------------------------------------"
echo "2. Build and install MyGUI"
echo "----------------------------------------------------"
git clone https://github.com/MyGUI/mygui.git || true
cd mygui
git checkout MyGUI3.4.3

mkdir build && cd build
cmake .. \
  -DCMAKE_BUILD_TYPE=Release \
  -DMYGUI_RENDERSYSTEM=1 \
  -DMYGUI_BUILD_DEMOS=OFF \
  -DMYGUI_BUILD_TOOLS=OFF \
  -DMYGUI_BUILD_PLUGINS=OFF \
  -DMYGUI_DONT_USE_OBSOLETE=ON

make -j$(nproc)
sudo make install
sudo ldconfig

echo "----------------------------------------------------"
echo "3. Install PiKISS (optional)"
echo "----------------------------------------------------"

read -p "Do you want to install PiKISS? (y/n): " install_pikiss

if [[ "$install_pikiss" == "y" || "$install_pikiss" == "Y" ]]; then
    mkdir -p ~/utils
    cd ~/utils

    git clone https://github.com/jmcerrejon/PiKISS.git || true
    cd PiKISS
    chmod +x piKiss.sh
    ./piKiss.sh
else
    echo "Skipping PiKISS installation."
fi

echo "----------------------------------------------------"
echo "Installation and build complete!"
echo "----------------------------------------------------"
