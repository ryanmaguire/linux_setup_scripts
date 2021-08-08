#!/bin/bash

#	SETUP SCRIPT.
# OS:		Debian 10 Buster.
# Device:	Mid 2017 iMac 27" 5K Retina Display.

# Install useful things.
sudo apt-get update && yes | sudo apt-get full-upgrade
yes | sudo apt-get install wget rsync git plotutils gcc tcc pcc clang
yes | sudo apt-get install neofetch vlc qbittorrent libreoffice
yes | sudo apt-get install sagemath ipython3 gnudatalanguage texlive-full
sudo apt-get update

# VSCode is on snap.
yes | sudo snap install --classic code

# Install signal.
wget -O- https://updates.signal.org/desktop/apt/keys.asc | sudo apt-key add -
echo "deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main" | sudo tee -a /etc/apt/sources.list.d/signal-xenial.list
sudo apt update && sudo apt install --yes signal-desktop

# Install nordvpn.
wget https://repo.nordvpn.com/deb/nordvpn/debian/pool/main/nordvpn-release_1.0.0_all.deb
sudo apt-get install --yes ./nordvpn-release_1.0.0_all.deb
sudo apt-get update && sudo apt-get install --yes nordvpn
rm -f nordvpn-release_1.0.0_all.deb

# Install zoom.
wget https://zoom.us/client/latest/zoom_amd64.deb
sudo apt-get update && sudo apt-get install --yes ./zoom_amd64.deb
rm -f zoom_amd64.deb

# Install Caprine Facebook messenger for Molly.
wget https://github.com/sindresorhus/caprine/releases/download/v2.54.0/caprine_2.54.0_amd64.deb
sudo apt-get update && sudo apt-get install --yes ./caprine_2.54.0_amd64.deb
rm -f caprine_2.54.0_amd64.deb

# Run this in case anything broke.
yes | sudo apt-get --fix-broken install
yes | sudo apt-get full-upgrade
yes | sudo apt-get --purge autoremove
yes | sudo apt-get autoclean
sudo apt-get update

# Clone repos.
cd ~/Documents
git clone https://github.com/ryanmaguire/Mathematics-and-Physics.git
git clone https://github.com/ryanmaguire/libtmpl.git
git clone https://github.com/ryanmaguire/LinuxSetupScripts.git
git clone https://github.com/NASA-Planetary-Science/rss_ringoccs.git

sudo reboot
