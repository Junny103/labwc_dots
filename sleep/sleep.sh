#!/bin/bash
set -e

echo "----------------------------------------------------"
echo "1. Update system and install packages"
echo "----------------------------------------------------"
sudo apt update && sudo apt upgrade -y
sudo apt install -y --no-install-recommends jq

echo "----------------------------------------------------"
echo "2. Install uConsole-sleep (latest version)"
echo "----------------------------------------------------"
LATEST_URL=$(curl -s https://api.github.com/repos/qkdxorjs1002/uConsole-sleep/releases/latest \
    | jq -r '.assets[] | select(.name | test("deb$")) | .browser_download_url')

wget -P /tmp "$LATEST_URL"

DEB_FILE=$(basename "$LATEST_URL")
sudo apt install -y /tmp/$DEB_FILE
sudo cp -f ./config /etc/uconsole-sleep/config

echo "----------------------------------------------------"
echo "Installation complete!"
echo "----------------------------------------------------"
