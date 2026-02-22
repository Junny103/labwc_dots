#!/bin/bash
set -e

echo "1. System Update and Dependencies"
sudo apt update
sudo apt install -y \
    cmake git libluajit-5.1-dev libsqlite3-dev libopenal-dev \
    zlib1g-dev libbullet-dev libunshield-dev ffmpeg \

echo "2. Build MyGUI 3.4.3"
mkdir -p ~/src && cd ~/src

git clone https://github.com/MyGUI/mygui.git
cd mygui
git checkout MyGUI3.4.3

mkdir -p build && cd build
cmake .. \
  -DCMAKE_BUILD_TYPE=Release \
  -DMYGUI_RENDERSYSTEM=1 \
  -DMYGUI_BUILD_DEMOS=OFF \
  -DMYGUI_BUILD_TOOLS=OFF \
  -DMYGUI_BUILD_PLUGINS=OFF \
  -DMYGUI_DONT_USE_OBSOLETE=ON

make -j$(nproc)

echo "3. Build Open MW"
mkdir -p ~/Games && cd ~/Games

git clone https://github.com/OpenMW/openmw.git
cd openmw

mkdir -p build && cd build
cmake .. \
  -DMyGUI_INCLUDE_DIR=$HOME/src/mygui/MyGUIEngine/include \
  -DMyGUI_LIBRARY=$HOME/src/mygui/build/lib/libMyGUIEngine.so

make -j2

echo "-------------------------------------------------------"
echo "Build Completed Successfully!"
echo "To run OpenMW in your labwc environment, type 'openmw' in the terminal."
echo "-------------------------------------------------------"
