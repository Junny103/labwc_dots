#!/bin/bash
set -e

echo "----------------------------------------------------"
echo "1. Update system and install packages"
echo "----------------------------------------------------"
sudo apt update && sudo apt upgrade -y
sudo apt install -y \
    cmake libfreetype-dev qt6-base-dev libswscale-dev \
    libopenal-dev libavcodec-dev libavformat-dev libyaml-cpp-dev \
    libcollada-dom-dev libjpeg-dev
    
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

cd ../../

echo "----------------------------------------------------"
echo "3. Build and install OpenMW's OpenSceneGraph fork (OpenMW/osg)"
echo "----------------------------------------------------"
git clone https://github.com/OpenMW/osg.git || true
cd osg

mkdir -p build && cd build
cmake .. \
  -DCMAKE_BUILD_TYPE=Release \
  -DBUILD_OSG_PLUGINS_BY_DEFAULT=0 \
  -DBUILD_OSG_PLUGIN_OSG=1 \
  -DBUILD_OSG_PLUGIN_DAE=1 \
  -DBUILD_OSG_PLUGIN_DDS=1 \
  -DBUILD_OSG_PLUGIN_TGA=1 \
  -DBUILD_OSG_PLUGIN_BMP=1 \
  -DBUILD_OSG_PLUGIN_JPEG=1 \
  -DBUILD_OSG_PLUGIN_PNG=1 \
  -DBUILD_OSG_PLUGIN_FREETYPE=1 \
  -DBUILD_OSG_DEPRECATED_SERIALIZERS=0
  
make -j$(nproc)
sudo make install
sudo ldconfig

echo "----------------------------------------------------"
echo "4. Install PiKISS (optional)"
echo "----------------------------------------------------"

read -p "Do you want to install PiKISS? (y/n): " install_pikiss

if [[ "$install_pikiss" == "y" || "$install_pikiss" == "Y" ]]; then
    mkdir -p $HOME/utils
    cd $HOME/utils

    git clone https://github.com/jmcerrejon/PiKISS.git || true
    cd PiKISS
    chmod +x piKiss.sh
    ./piKiss.sh
else
    echo "----------------------------------------------------"
    echo "Skipping PiKISS installation."
    echo "----------------------------------------------------"
fi

echo "----------------------------------------------------"
echo "Installation and build complete!"
echo "----------------------------------------------------"
