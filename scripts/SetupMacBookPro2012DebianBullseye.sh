#!/bin/bash

# SETUP SCRIPT.
# OS:		Debian 11 Bullseye.
# Device:	Mid 2012 MacBook Pro 13"

# Install useful things.
sudo apt-get update && sudo apt-get --yes full-upgrade
sudo apt-get install --yes wget curl rsync git plotutils gcc tcc pcc clang vlc
sudo apt-get install --yes neofetch gnudatalanguage gnome-builder tuxguitar
sudo apt-get install --yes tuxguitar-alsa evolution-ews sagemath

# The WiFi and ethernet part of the laptop broke. Using a ThinkPenguin USB
# WiFi adapter instead. This needs the following package.
sudo apt-get install --yes firmware-ath9k-htc

# Install signal. These are the comments from signal.

# NOTE: These instructions only work for 64 bit Debian-based
# Linux distributions such as Ubuntu, Mint etc.

# 1. Install our official public software signing key
wget -O- https://updates.signal.org/desktop/apt/keys.asc | sudo apt-key add -

# 2. Add our repository to your list of repositories
echo "deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main" |\
  sudo tee -a /etc/apt/sources.list.d/signal-xenial.list

# 3. Update your package database and install signal
sudo apt update && sudo apt install --yes signal-desktop

# Clone repos.
mkdir ~/Projects/
cd ~/Projects/
git clone https://github.com/ryanmaguire/Mathematics-and-Physics.git
git clone https://github.com/ryanmaguire/libtmpl.git
git clone https://github.com/ryanmaguire/LinuxSetupScripts.git
git clone https://github.com/NASA-Planetary-Science/rss_ringoccs.git
git config --global credential.helper store
cd ~

# Run this in case anything broke.
sudo apt-get update && sudo apt-get -y --fix-broken install
sudo apt-get -y full-upgrade && sudo apt-get -y --purge autoremove
sudo apt-get autoclean && sudo reboot
