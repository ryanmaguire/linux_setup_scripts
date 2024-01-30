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

#	SETUP SCRIPT.
# OS:		Debian 11 Bullseye.
# Device:	Mid 2015 MacBook Pro Retina 15"

# Remove several things that come pre-installed.
yes | sudo apt-get remove --purge mozc-data hdate-applet anthy anthy-common
yes | sudo apt-get remove --purge debian-reference debian-reference-common
yes | sudo apt-get remove --purge debian-reference-common
yes | sudo apt-get remove --purge fcitx fcitx-anthy fcitx-config-common fcitx5
yes | sudo apt-get remove --purge fcitx-data fcitx5-data goldendict
yes | sudo apt-get remove --purge khmerconverter mlterm xiterm+thai xterm
yes | sudo apt-get --purge autoremove && sudo apt-get autoclean

# Need non-free and contrib for WiFi and graphics drivers. This assumes you
# used the main Debian installer, and not the non-free one that has these
# repositories already listed.
echo -e "\n# Needed for WiFi drivers." | sudo tee -a /etc/apt/sources.list
echo "deb http://deb.debian.org/debian/ bullseye contrib non-free" | sudo tee -a /etc/apt/sources.list
echo "deb-src http://deb.debian.org/debian/ bullseye contrib non-free" | sudo tee -a /etc/apt/sources.list
echo "deb http://security.debian.org/debian-security bullseye-security contrib non-free" | sudo tee -a /etc/apt/sources.list
echo "deb-src http://security.debian.org/debian-security bullseye-security contrib non-free" | sudo tee -a /etc/apt/sources.list

# Update pciids. This is for the WiFi card.
sudo apt-get update && yes | sudo update-pciids

# Install the WiFi drivers. You will need to restart for these to be active.
yes | sudo apt-get install linux-headers-$(uname -r) broadcom-sta-dkms
yes | sudo apt-get install broadcom-sta-common broadcom-sta-source

# Install useful things.
sudo apt-get update && sudo apt-get --yes full-upgrade
sudo apt-get install --yes wget curl rsync git plotutils gcc tcc pcc clang vlc
sudo apt-get install --yes neofetch sagemath ipython3 gnudatalanguage gthumb
sudo apt-get install --yes texlive-full calibre libcairo2-dev gnome-builder
sudo apt-get install --yes inkscape tuxguitar tuxguitar-alsa evolution-ews

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

# Probably not needed anymore.
#	edit /etc/default/grub and add:
#		GRUB_CMDLINE_LINUX_DEFAULT=”quiet libata.force=noncq”

# Still needed:
#    sudo -s
#    crontab -e
# Add the line:
#    @reboot echo disable > /sys/firmware/acpi/interrupts/gpe06
