#!/bin/bash

# SETUP SCRIPT.
# OS:		Debian 10 Buster.
# Device:	Mid 2012 MacBook Pro 13"

# Remove several things that come pre-installed.
yes | sudo apt-get remove --purge mozc-data hdate-applet anthy anthy-common
yes | sudo apt-get remove --purge debian-reference debian-reference-common
yes | sudo apt-get remove --purge debian-reference-common
yes | sudo apt-get remove --purge fcitx fcitx-anthy fcitx-config-common fcitx5
yes | sudo apt-get remove --purge fcitx-data fcitx5-data goldendict
yes | sudo apt-get remove --purge khmerconverter mlterm xiterm+thai xterm

# Needed for Microsoft Exchange emails.
echo -e "\n# Needed for evolution-ews." | sudo tee -a /etc/apt/sources.list
echo "deb http://ftp.debian.org/debian buster-backports main" | sudo tee -a /etc/apt/sources.list
echo "deb-src http://ftp.debian.org/debian buster-backports main" | sudo tee -a /etc/apt/sources.list
sudo apt-get update && yes | sudo apt-get install -t buster-backports evolution-ews

# Install useful things.
yes | sudo apt-get install wget curl rsync git plotutils gcc tcc pcc clang
yes | sudo apt-get install openvpn network-manager-openvpn gnome-boxes snapd
yes | sudo apt-get install libcairo2-dev gnome-builder calibre neofetch gthumb
yes | sudo apt-get install sagemath ipython3 gnudatalanguage texlive-full vlc
yes | sudo apt-get update

# VSCode is on snap.
yes | sudo snap install code --classic

# Need non-free and contrib for WiFi and graphics drivers. This assumes you
# used the main Debian installer, and not the non-free one that has these
# repositories already listed.
echo -e "\n# Needed for WiFi and graphics drivers." | sudo tee -a /etc/apt/sources.list
echo "deb http://deb.debian.org/debian/ buster contrib non-free" | sudo tee -a /etc/apt/sources.list
echo "deb-src http://deb.debian.org/debian/ buster contrib non-free" | sudo tee -a /etc/apt/sources.list

# Update pciids. This is for the WiFi card.
sudo apt-get update
yes | sudo update-pciids

# Install the WiFi drivers. You will need to restart for these to be active.
yes | sudo apt-get install linux-headers-$(uname -r) broadcom-sta-dkms
yes | sudo apt-get install broadcom-sta-common broadcom-sta-source

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
cd ~/Documents
git clone https://github.com/ryanmaguire/Mathematics-and-Physics.git
git clone https://github.com/ryanmaguire/libtmpl.git
git clone https://github.com/ryanmaguire/LinuxSetupScripts.git
git clone https://github.com/NASA-Planetary-Science/rss_ringoccs.git
git config --global credential.helper store

# And some cleanup.
sudo apt-get update
yes | sudo apt-get --fix-broken install
yes | sudo apt-get --purge autoremove
sudo apt-get autoclean
sudo reboot
