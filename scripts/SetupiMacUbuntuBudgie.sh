#!/bin/bash

#	SETUP SCRIPT.
# OS:		Debian 10 Buster.
# Device:	Mid 2017 iMac 27" 5K Retina Display.

# Install useful things.
yes | sudo apt-get install wget curl rsync git plotutils gcc tcc pcc clang
yes | sudo apt-get install gnome-builder calibre neofetch gthumb vlc qbittorrent
yes | sudo apt-get install sagemath ipython3 gnudatalanguage texlive-full
yes | sudo apt-get update

# Install nordvpn.
wget https://repo.nordvpn.com/deb/nordvpn/debian/pool/main/nordvpn-release_1.0.0_all.deb
yes | sudo apt-get install ./nordvpn-release_1.0.0_all.deb
yes | sudo apt-get update
yes | sudo apt-get install nordvpn
yes | sudo apt-get update

# Install zoom.
wget https://zoom.us/client/latest/zoom_amd64.deb
yes | sudo apt-get install ./zoom_amd64.deb
yes | sudo apt-get update

# Signal, caprine, and VSCode are on the Ubuntu repositories.
yes | sudo snap install signal-desktop
yes | sudo snap install --classic code
yes | sudo snap install caprine

# Run this in case anything broke.
yes | sudo apt-get --fix-broken install
yes | sudo apt-get full-upgrade
yes | sudo apt-get --purge autoremove
yes | sudo apt-get autoclean
yes | sudo apt-get update

sudo reboot
