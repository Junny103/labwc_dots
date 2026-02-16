#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# 1. install deps
sudo apt update && sudo apt upgrade -y
sudo apt install -y --no-install-recommends \
    cmake libfreetype-dev libluajit-5.1-dev \
    libsqlite3-dev libopenal-dev zlib1g-dev \
    libbullet-dev libunshield-dev ffmpeg \
    libgl1-mesa-dev liblz4-dev
    
# 2. MyGUI build (~/src)
mkdir -p ~/src && cd ~/src
if [ ! -d "mygui" ]; then
    git clone https://github.com/MyGUI/mygui.git
fi
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

make -j"$(nproc)"

# 3. OpenMW build (~/games)
mkdir -p ~/games && cd ~/games
if [ ! -d "openmw" ]; then
    git clone https://gitlab.com/OpenMW/openmw.git
fi
cd openmw
mkdir -p build && cd build

cmake .. \
  -DMyGUI_INCLUDE_DIR=$HOME/src/mygui/MyGUIEngine/include \
  -DMyGUI_LIBRARY=$HOME/src/mygui/build/lib/libMyGUIEngine.so

make -j"$(nproc)"

echo "Done: ~/games/openmw/build"
