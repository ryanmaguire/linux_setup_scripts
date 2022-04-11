#!/bin/bash

#	SETUP SCRIPT.
# OS:		Ubuntu Budgie 20.04 (Minimum Install)
# Device:	Mid 2017 iMac 27" 5K Retina Display.

# Install useful things.
sudo apt-get update && sudo apt-get --yes full-upgrade
sudo apt-get install --yes wget curl rsync git plotutils gcc tcc pcc clang vlc
sudo apt-get install --yes neofetch libreoffice evolution-ews sagemath ipython3
sudo apt-get install --yes gnudatalanguage texlive-full calibre gnome-builder
sudo apt-get install --yes libcairo2-dev inkscape gthumb tuxguitar tuxguitar-alsa

# Install signal.
wget -O- https://updates.signal.org/desktop/apt/keys.asc | sudo apt-key add -
echo "deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main" | sudo tee -a /etc/apt/sources.list.d/signal-xenial.list
sudo apt update && sudo apt install --yes signal-desktop

# Install zoom.
wget https://zoom.us/client/latest/zoom_amd64.deb
sudo apt-get update && sudo apt-get install --yes ./zoom_amd64.deb
rm -f zoom_amd64.deb

# Install Caprine Facebook messenger for Molly.
wget https://github.com/sindresorhus/caprine/releases/download/v2.54.0/caprine_2.54.0_amd64.deb
sudo apt-get update && sudo apt-get install --yes ./caprine_2.54.0_amd64.deb
rm -f caprine_2.54.0_amd64.deb

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
sudo apt-get --yes --fix-broken install && sudo apt-get --yes full-upgrade
sudo apt-get --yes --purge autoremove && sudo apt-get autoclean
sudo apt-get update && sudo reboot
