#!/bin/bash
set -e

echo "1. Setup architectures"
sudo dpkg --add-architecture armhf
sudo apt update

echo "2. Install build tools"
sudo apt install -y \
cmake libc6:armhf gcc-arm-linux-gnueabihf \

echo "3. Build and install box86"
git clone https://github.com/ptitSeb/box86 || true
cd box86
mkdir -p build && cd build

cmake .. \
 -D RPI4ARM64=1 \
 -D CMAKE_BUILD_TYPE=RelWithDebInfo

make -j$(nproc)
sudo make install

echo "4. Restart binfmt"
sudo systemctl restart systemd-binfmt

echo "5. Install Wine"
sudo apt install wine32 -y

echo "----------------------------------------------------"
echo "Installation complete!"
echo "----------------------------------------------------"
