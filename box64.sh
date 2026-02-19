git clone https://github.com/ptitSeb/box64
cd box64
mkdir build && cd build

cmake .. -D ARM_DYNAREC=ON -D RPI4ARM64=1 -D CMAKE_BUILD_TYPE=RelWithDebInfo -D BOX32=ON -D BOX32_BINFMT=ON
make -j$(nproc)

sudo make install
sudo systemctl restart systemd-binfmt
