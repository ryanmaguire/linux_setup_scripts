#!/bin/bash
################################################################################
#                                   LICENSE                                    #
################################################################################
#   This file is free software: you can redistribute it and/or modify          #
#   it under the terms of the GNU General Public License as published by       #
#   the Free Software Foundation, either version 3 of the License, or          #
#   (at your option) any later version.                                        #
#                                                                              #
#   This file is distributed in the hope that it will be useful,               #
#   but WITHOUT ANY WARRANTY; without even the implied warranty of             #
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the              #
#   GNU General Public License for more details.                               #
#                                                                              #
#   You should have received a copy of the GNU General Public License          #
#   along with this file.  If not, see <https://www.gnu.org/licenses/>.        #
################################################################################

# SETUP SCRIPT.
# OS:     Debian 11 Bullseye.
# Device: Custom Desktop Computer
#    CPU:    AMD Ryzen 3900 12-core
#    GPU:    Power Color rx 570
#    RAM:    Ripjaw DDR4-3600 16GBx2
#    MB:     Gigabyte Aorus x570 Elite WiFi

# Needed for Microsoft Exchange emails.
sudo apt-get update && sudo apt-get install --yes evolution-ews

# Install useful things.
yes | sudo apt-get install wget curl rsync plotutils gcc tcc pcc clang picard
yes | sudo apt-get install openvpn network-manager-openvpn gnome-boxes git
yes | sudo apt-get install libcairo2-dev gnome-builder calibre neofetch gthumb
yes | sudo apt-get install sagemath ipython3 gnudatalanguage texlive-full vlc
yes | sudo apt-get install obs-studio inkscape tuxguitar tuxguitar-alsa
yes | sudo apt-get install ardour handbrake binfmt-support qemu
yes | sudo apt-get install qemu-user-static debootstrap && sudo apt-get update
yes | pip install snappy snappy_15_knots regina

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

# Needed to use Saffire pro 40. The PulseAudio drivers work, but have
# occasional xruns. JACK, using the FFADO drivers, works perfect.
# The following comments are from KX studio.

# Install required dependencies if needed
yes | sudo apt-get install apt-transport-https gpgv

# Remove legacy repos
sudo dpkg --purge kxstudio-repos-gcc5

# Download package file
wget https://launchpad.net/~kxstudio-debian/+archive/kxstudio/+files/kxstudio-repos_10.0.3_all.deb

# Install it
yes | sudo dpkg -i kxstudio-repos_10.0.3_all.deb
rm -f kxstudio-repos_10.0.3_all.deb

# Now install jack and all the necessary FFADO stuff.
sudo apt-get update
yes | sudo apt-get install jackd2 jackd2-firewire ffado-dbus-server libffado2
yes | sudo apt-get install multimedia-firewire cadence carla catia ffado-tools

# You then need to blacklist snd_dice. Add the following file:
sudo touch /etc/modprobe.d/alsa-nope.conf
echo "blacklist snd_dice" | sudo tee -a /etc/modprobe.d/alsa-nope.conf
sudo usermod -a -G audio $(whoami)

# Run this in case anything broke.
sudo apt-get update && sudo apt-get -y --fix-broken install
sudo apt-get -y full-upgrade && sudo apt-get -y --purge autoremove
sudo apt-get autoclean && sudo reboot
