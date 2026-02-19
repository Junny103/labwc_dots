# 1. multiarch
sudo dpkg --add-architecture armhf && sudo apt update
sudo apt install libc6:armhf gcc-arm-linux-gnueabihf -y

# 2. box86
git clone https://github.com/ptitSeb/box86
cd box86
mkdir build && cd build

cmake .. -DRPI4ARM64=1 -DCMAKE_BUILD_TYPE=RelWithDebInfo
make -j$(nproc)

sudo make install
sudo systemctl restart systemd-binfmt
