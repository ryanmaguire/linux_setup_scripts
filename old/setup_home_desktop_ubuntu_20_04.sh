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
# OS:     Ubuntu (GNOME Version) 20.04
# Device: Custom Desktop Computer
#   CPU:    AMD Ryzen 3900 12-core
#   GPU:    Power Color rx 570
#   RAM:    Ripjaw DDR4-3600 16GBx2
#   MB:     Gigabyte Aorus x570 Elite WiFi

# I selected the minimum install, no third-party stuff, for Ubuntu 20.04. In
# particular, this is the standard GNOME version.

# POD Farm and Steven Slate Drums can be installed via Wine. Same with other
# plugins. Make sure to download the windows version.

# Remove a few things that may be preinstalled.
yes | sudo apt-get remove --purge mozc-data hdate-applet anthy anthy-common
yes | sudo apt-get remove --purge debian-reference debian-reference-common
yes | sudo apt-get remove --purge debian-reference-common
yes | sudo apt-get remove --purge fcitx fcitx-anthy fcitx-config-common fcitx5
yes | sudo apt-get remove --purge fcitx-data fcitx5-data goldendict
yes | sudo apt-get remove --purge khmerconverter mlterm xiterm+thai xterm
yes | sudo apt-get remove --purge gnome-mahjongg mah-jongg five-or-more
yes | sudo apt-get remove --purge four-in-a-row hitori gnome-klotski iagno
yes | sudo apt-get remove --purge gnome-mines mlterm gnome-music gnome-nibbles
yes | sudo apt-get remove --purge quadrapassel gnome-robots gnome-sudoku
yes | sudo apt-get remove --purge swell-foop tali gnome-taquin gnome-tetravex
yes | sudo apt-get remove --purge lightsoff aisleriot
yes | sudo apt-get --purge autoremove
sudo apt-get autoclean
sudo apt-get update

# Useful stuff.
yes | sudo apt-get install wget curl git wine wine32 wine64 lmms ardour
yes | sudo apt-get install evolution-ews carla-bridge-win32 carla-bridge-win64

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
sudo apt-get update
yes | sudo apt-get --fix-broken install
yes | sudo apt-get full-upgrade
yes | sudo apt-get --purge autoremove
sudo apt-get autoclean
sudo reboot
