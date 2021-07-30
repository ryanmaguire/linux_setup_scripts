#!/bin/bash

# SETUP SCRIPT.
# OS:		Debian 10 Buster.
# Device:	Mid 2012 MacBook Pro 13"

# Add yourself to the sudoers file:
#   su

# Then alter /etc/sudoers adding the following line:
#   %ryan	ALL=(ALL:ALL) ALL

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

# Remove several things that come pre-installed. These are mostly apps for
# non-English users that I never use.
yes | sudo apt-get remove --purge mozc-data
yes | sudo apt-get remove --purge hdate-applet
yes | sudo apt-get remove --purge anthy
yes | sudo apt-get remove --purge anthy-common
yes | sudo apt-get remove --purge debian-reference
yes | sudo apt-get remove --purge debian-reference-common
yes | sudo apt-get remove --purge fcitx
yes | sudo apt-get remove --purge fcitx-anthy
yes | sudo apt-get remove --purge fcitx-config-common
yes | sudo apt-get remove --purge fcitx5
yes | sudo apt-get remove --purge fcitx-data
yes | sudo apt-get remove --purge fcitx5-data
yes | sudo apt-get remove --purge goldendict
yes | sudo apt-get remove --purge khmerconverter
yes | sudo apt-get remove --purge mlterm
yes | sudo apt-get remove --purge xiterm+thai
yes | sudo apt-get remove --purge xterm
yes | sudo apt-get remove --purge mlterm

# Update pciids. This is for the WiFi card.
yes | sudo update-pciids

# Need non-free and contrib for WiFi and graphics drivers. This assumes you
# used the main Debian installer, and not the non-free one that has these
# repositories already listed.
echo -e "\n# Needed for WiFi and graphics drivers." |\
  sudo tee -a /etc/apt/sources.list
echo "deb http://deb.debian.org/debian/ buster contrib non-free" |\
  sudo tee -a /etc/apt/sources.list
echo "deb-src http://deb.debian.org/debian/ buster contrib non-free" |\
  sudo tee -a /etc/apt/sources.list

# To add calendars for Microsoft Exchange, add evolution-ews. On Buster this
# is available on backports. Add to /etc/apt/sources.list:
echo -e "\n# Needed for evolution-ews." | sudo tee -a /etc/apt/sources.list
echo "deb http://ftp.debian.org/debian buster-backports main" |\
  sudo tee -a /etc/apt/sources.list
echo "deb-src http://ftp.debian.org/debian buster-backports main" |\
  sudo tee -a /etc/apt/sources.list

# Update the new sources.list.
yes | sudo apt-get update

# Install the WiFi drivers. You will need to restart for these to be active.
yes | sudo apt-get install linux-headers-$(uname -r)
yes | sudo apt-get install broadcom-sta-common
yes | sudo apt-get install broadcom-sta-source
yes | sudo apt-get install broadcom-sta-dkms

# Install the Microsoft Exchange extension for evolution.
yes | sudo apt-get install -t buster-backports evolution-ews

# Usefull apps.
yes | sudo apt-get install git
yes | sudo apt-get install gnome-builder
yes | sudo apt-get install calibre
yes | sudo apt-get install vlc
yes | sudo apt-get install gnudatalanguage
yes | sudo apt-get install sagemath
yes | sudo apt-get install ipython3
yes | sudo apt-get install texlive-full
yes | sudo apt-get install jami
yes | sudo apt-get install gthumb
yes | sudo apt-get install wget

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

# Set up git password in GNOME Keyring. You will need to create a personal
# access token with GitHub for this.
yes | sudo apt-get install libsecret-1-0
yes | sudo apt-get install libsecret-1-dev
sudo make --directory=/usr/share/doc/git/contrib/credential/libsecret
git config --global credential.helper \
  /usr/share/doc/git/contrib/credential/libsecret/git-credential-libsecret
git config --global user.email ryan_maguire@student.uml.edu

# Clone my repos.
cd ~/Documents
git clone https://github.com/ryanmaguire/Mathematics-and-Physics.git
git clone https://github.com/ryanmaguire/libtmpl.git
git clone https://github.com/ryanmaguire/LinuxSetupScripts.git
git clone https://github.com/NASA-Planetary-Science/rss_ringoccs.git
cd ~

# And some cleanup.
yes | sudo apt-get update
yes | sudo apt-get --fix-broken install
yes | sudo apt-get --purge autoremove
yes | sudo apt-get autoclean

# OLD
# Fix mac address problem. Go to /etc/NetworkManager/NetworkManager.conf
# Add the lines:
#   [device]
#   wifi.scan-rand-mac-address=no
# Save and run:
#   sudo systemctl restart NetworkManager
#   /etc/init.d/network-manager restart
# Go to /etc/network/
#   sudo nano interfaces
# Comment out the line:
#   source /etc/network/interfaces.d/*
# Install the NoobsLab flat-remix theme.
#   wget https://launchpad.net/~noobslab/+archive/ubuntu/themes/+files/flat-remix-gs-theme_3.12-1~xenial~NoobsLab.com_all.deb
#   yes | sudo apt-get install ./flat-remix-gs-theme_3.12-1~xenial~NoobsLab.com_all.deb
