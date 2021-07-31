#!/bin/bash

# SETUP SCRIPT.
# OS:     ElementaryOS 5: Hera.
# Device: Mid 2019 Acer Aspire Slim 5 15.6"

# MANUAL
# yes | sudo apt-get update
# yes | sudo apt-get upgrade
# yes | sudo apt-get dist-upgrade
# yes | sudo apt-get full-upgrade
# yes | sudo apt-get update
# yes | sudo apt-get --purge autoremove
# yes | sudo apt-get autoclean
# yes | sudo update-grub
# sudo reboot

# Then remove the old Linux kernel.
# uname -r
# dpkg --list "*linux-image*" | grep ii
# yes | sudo apt-get --purge remove linux-image-VERSION
# yes | sudo apt-get update
# yes | sudo apt-get full-upgrade
# yes | sudo apt-get --purge autoremove
# yes | sudo apt-get autoclean
# sudo update-grub

# Then reboot and run this file.

# Install useful stuff.
yes | sudo apt-get install build-essential
yes | sudo apt-get install wget
yes | sudo apt-get install curl
yes | sudo apt-get install git
yes | sudo apt-get update

# Install signal. These are the comments from signal.

# NOTE: These instructions only work for 64 bit Debian-based
# Linux distributions such as Ubuntu, Mint etc.

# 1. Install our official public software signing key
wget -O- https://updates.signal.org/desktop/apt/keys.asc | sudo apt-key add -

# 2. Add our repository to your list of repositories
echo "deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main" |\
  sudo tee -a /etc/apt/sources.list.d/signal-xenial.list

# 3. Update your package database and install signal
yes | sudo apt update
yes | sudo apt install signal-desktop

# Install Caprine Facebook messenger for Molly.
wget https://github.com/sindresorhus/caprine/releases/download/v2.54.0/caprine_2.54.0_amd64.deb
yes | sudo apt-get update
yes | sudo apt-get install ./caprine_2.54.0_amd64.deb
yes | sudo apt-get update

# Install nordvpn.
wget https://repo.nordvpn.com/deb/nordvpn/debian/pool/main/nordvpn-release_1.0.0_all.deb
yes | sudo apt-get update
yes | sudo apt-get install ./nordvpn-release_1.0.0_all.deb
yes | sudo apt-get update
yes | sudo apt-get install nordvpn

# Install zoom.
wget https://zoom.us/client/latest/zoom_amd64.debZ
yes | sudo apt-get update
yes | sudo apt-get install ./zoom_amd64.deb
yes | sudo apt-get update

# Install tweaks
yes | sudo apt-get update
yes | sudo apt-get install --yes software-properties-common
yes | sudo apt-add-repository --yes ppa:philip.scott/elementary-tweaks
yes | sudo apt-get install --yes elementary-tweaks

# Run this in case anything broke.
yes | sudo apt-get --fix-broken install
yes | sudo apt-get --purge autoremove
yes | sudo apt-get autoclean
