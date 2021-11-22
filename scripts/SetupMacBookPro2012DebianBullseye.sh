#!/bin/bash

# SETUP SCRIPT.
# OS:		Debian 11 Bullseye.
# Device:	Mid 2012 MacBook Pro 13"

# Remove several things that come pre-installed.
yes | sudo apt-get remove --purge mozc-data hdate-applet anthy anthy-common
yes | sudo apt-get remove --purge debian-reference debian-reference-common
yes | sudo apt-get remove --purge debian-reference-common
yes | sudo apt-get remove --purge fcitx fcitx-anthy fcitx-config-common fcitx5
yes | sudo apt-get remove --purge fcitx-data fcitx5-data goldendict
yes | sudo apt-get remove --purge khmerconverter mlterm xiterm+thai xterm

# Install useful things.
sudo apt-get update && sudo apt-get --yes full-upgrade
sudo apt-get install --yes wget curl rsync git plotutils gcc tcc pcc clang vlc
sudo apt-get install --yes neofetch sagemath ipython3 gnudatalanguage gthumb
sudo apt-get install --yes texlive-full calibre libcairo2-dev gnome-builder
sudo apt-get install --yes inkscape tuxguitar tuxguitar-alsa evolution-ews

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
