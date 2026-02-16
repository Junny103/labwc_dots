#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

sudo apt update && sudo apt upgrade -y
sudo apt install -y --no-install-recommends cmake libfreetype-dev

mkdir -p ~/src && cd ~/src
git clone https://github.com/MyGUI/mygui.git
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

make -j"$(nproc)"

echo "Done: ~/src/mygui/build"
