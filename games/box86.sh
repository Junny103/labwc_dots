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
mkdir -p ~/wine
cd ~/wine
wget https://github.com/Kron4ek/Wine-Builds/releases/download/11.2/wine-11.2-x86.tar.xz
tar -xvf wine-11.2-x86.tar.xz --strip-components=1

echo 'export PATH="$HOME/wine/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

echo "----------------------------------------------------"
echo "Installation complete!"
echo "----------------------------------------------------"
