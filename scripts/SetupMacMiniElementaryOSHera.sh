#!/bin/bash

#	SETUP SCRIPT.
# OS:		ElementaryOS 5: Hera.
# Device:	Mid 2011 Mac Mini.

# Update everything.
cd ~/Downloads
yes | sudo apt-get update
yes | sudo apt-get full-upgrade
yes | sudo apt-get update
yes | sudo apt-get upgrade
yes | sudo apt-get dist-upgrade
yes | sudo apt-get full-upgrade
yes | sudo apt-get update
yes | sudo apt-get autoremove

# Install all of the necessary stuff (gcc, make, etc.)
yes | sudo apt-get install build-essential

# Install curl and wget for downloading files.
yes | sudo apt-get install wget
yes | sudo apt-get install curl

# Install git for cloning repositories.
yes | sudo apt-get install git
yes | sudo apt-get update

# We need dkms to run the install script for the Apple Magic Pad drivers.
yes | sudo apt-get install dkms
yes | sudo apt-get update

# Grab the driver repository from GitHub.
git clone https://github.com/rohitpid/Linux-Magic-Trackpad-2-Driver.git

# Change directory into the repository we just cloned.
cd Linux-Magic-Trackpad-2-Driver/scripts

# Give execute permission to the install script and run it.
chmod u+x install.sh
sudo ./install.sh

# Change directory back to downloads.
cd ~/Downloads

# Install signal. These are the comments from signal.

# NOTE: These instructions only work for 64 bit Debian-based
# Linux distributions such as Ubuntu, Mint etc.

# 1. Install our official public software signing key
wget -O- https://updates.signal.org/desktop/apt/keys.asc |\
  sudo apt-key add -

# 2. Add our repository to your list of repositories
echo "deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main" |\
  sudo tee -a /etc/apt/sources.list.d/signal-xenial.list

# 3. Update your package database and install signal
yes | sudo apt update && sudo apt install signal-desktop

# Install Caprine Facebook messenger for Molly.
wget https://github.com/sindresorhus/caprine/releases/download/v2.52.0/caprine_2.52.0_amd64.deb
yes | sudo apt-get install ./caprine_2.52.0_amd64.deb
yes | sudo apt-get update

# Install nordvpn.
wget https://rep.nordvpn.com/deb/nordvpn/debian/pool/main/nordvpn-release_1.0.0_all.deb
yes | sudo apt-get install ./nordvpn-release_1.0.0_all.deb
yes | sudo apt-get update
yes | sudo apt-get install nordvpn
yes | sudo apt-get update

# Install zoom.
yes | sudo apt-get update
wget https://zoom.us/client/latest/zoom_amd64.deb
yes | sudo apt-get install ./zoom_amd64.deb
yes | sudo apt-get update

# Install tweaks
yes | sudo apt-get update
yes | sudo apt-get install --yes software-properties-common
yes | sudo apt-add-repository --yes ppa:philip.scott/elementary-tweaks
yes | sudo apt-get install --yes elementary-tweaks

# Run this in case anything broke.
yes | sudo apt-get --fix-broken install
yes | sudo apt-get autoremove
yes | sudo apt-get autoclean

# Old steps I no longer use.

# Get wifi. This is probably unnecessary as it is most likely not installed.
# sudo apt-get remove --purge bcmwl-kernel-source

# If it was installed, reboot.
# sudo reboot

# Get the correct driver for thw wifi.
# sudo apt-get install firmware-b43-installer

# Enable correct permissions.
# sudo modprobe -r b43
# sudo modprobe b43

# Install Firefox. Epiphany works well and has Firefox Sync, so not essential.
# sudo apt-get install firefox

# Check kernel. Should be 4.19 at least.
# uname -a

# Update kernel if necessary
# cd /tmp/

# wget -c http://kernel.ubuntu.com/~kernel-ppa/mainline/v4.19/linux-headers-4.19.0-041900_4.19.0-041900.201810221809_all.deb
# wget -c http://kernel.ubuntu.com/~kernel-ppa/mainline/v4.19/linux-headers-4.19.0-041900-generic_4.19.0-041900.201810221809_amd64.deb
# wget -c http://kernel.ubuntu.com/~kernel-ppa/mainline/v4.19/linux-image-unsigned-4.19.0-041900-generic_4.19.0-041900.201810221809_amd64.deb
# wget -c http://kernel.ubuntu.com/~kernel-ppa/mainline/v4.19/linux-modules-4.19.0-041900-generic_4.19.0-041900.201810221809_amd64.deb

# sudo dpkg -i *.deb
# cd ~

# Install various tools used for gestures.
# yes | sudo apt-get install python3
# yes | sudo apt-get install python3-setuptools
# yes | sudo apt-get install xdotool
# yes | sudo apt-get install python3-gi
# yes | sudo apt-get install python-gobject

# For gesture installs.
# sudo gpasswd -a $USER input
# su - $USER
# sudo apt-get update
# sudo apt install libinput-tools
# cd ~/Downloads/
# git clone https://github.com/bulletmark/libinput-gestures.git
# cd libinput-gestures/
# sudo make install
# cd ~
# libinput-gestures-setup autostart
# libinput-gestures-setup start

# cd ~/Downloads/
# git clone https://gitlab.com/cunidev/gestures
# cd gestures/
# sudo python3 setup.py install

# How to install spotify
# curl -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add -
# echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
# sudo apt-get update && sudo apt-get install spotify-client

# Dark mode.
# sudo apt-get install --yes git
# git clone https://github.com/surajmandalcell/elementary-x.git ~/.themes/elementary-x
# mkdir ~/.icons
# cd ~/.icons
# git clone https://github.com/keeferrourke/la-capitaine-icon-theme.git
# cd ~
# gsettings set org.gnome.desktop.interface gtk-theme 'elementary-x'
# gsettings set org.gnome.desktop.interface icon-theme 'la-capitaine-icon-theme'
# gsettings set org.pantheon.desktop.gala.appearance button-layout 'close,minimize,maximize'
