#!/bin/bash

# SETUP SCRIPT.
# OS:     ElementaryOS 5: Hera.
# Device: Mid 2019 Acer Aspire Slim 5 15.6"

# Install useful stuff.
sudo apt-get install --yes build-essential wget curl git

# Install signal.
wget -O- https://updates.signal.org/desktop/apt/keys.asc | sudo apt-key add -
echo "deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main" | sudo tee -a /etc/apt/sources.list.d/signal-xenial.list
sudo apt update && sudo apt install --yes signal-desktop

# Install Caprine Facebook messenger for Molly.
wget https://github.com/sindresorhus/caprine/releases/download/v2.54.0/caprine_2.54.0_amd64.deb
sudo apt-get update && sudo apt-get install --yes ./caprine_2.54.0_amd64.deb
rm -f caprine_2.54.0_amd64.deb

# Install zoom.
wget https://zoom.us/client/latest/zoom_amd64.deb
sudo apt-get update && sudo apt-get install --yes ./zoom_amd64.deb
rm -f zoom_amd64.deb

# Install tweaks
sudo apt-get install --yes software-properties-common
sudo apt-add-repository --yes ppa:philip.scott/elementary-tweaks
sudo apt-get install --yes elementary-tweaks

# Run this in case anything broke.
yes | sudo apt-get --fix-broken install
yes | sudo apt-get --purge autoremove
sudo apt-get autoclean
