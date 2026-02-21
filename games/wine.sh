#!/bin/bash
set -e

echo "1. Setup architectures"
sudo dpkg --add-architecture armhf
sudo dpkg --add-architecture i386
sudo apt update

echo "2. Install build tools"
sudo apt install -y \
cmake gcc-arm-linux-gnueabihf \

echo "3. Build and install box64"
git clone https://github.com/ptitSeb/box64 || true
cd box64
mkdir -p build && cd build

cmake .. \
 -D ARM_DYNAREC=ON \
 -D RPI4ARM64=1 \
 -D CMAKE_BUILD_TYPE=RelWithDebInfo \
 -D BOX32=ON \
 -D BOX32_BINFMT=ON

make -j$(nproc)
sudo make install

cd ../..

echo "4. Build and install box86"
git clone https://github.com/ptitSeb/box86 || true
cd box86
mkdir -p build && cd build

cmake .. \
 -D RPI4ARM64=1 \
 -D CMAKE_BUILD_TYPE=RelWithDebInfo

make -j$(nproc)
sudo make install

cd ../..

echo "4. Restart binfmt"
sudo systemctl restart systemd-binfmt

echo "5. Install Wine"
mkdir -p ~/wine
cd ~/wine
wget https://github.com/Kron4ek/Wine-Builds/releases/download/11.2/wine-11.2-amd64.tar.xz
tar -xvf wine-11.2-amd64.tar.xz --strip-components=1

echo 'export PATH="$HOME/wine/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

echo "----------------------------------------------------"
echo "Installation complete!"
echo "----------------------------------------------------"
