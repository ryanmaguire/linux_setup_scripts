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
# OS:     ElementaryOS 5: Hera.
# Device: Mid 2019 Acer Aspire Slim 5 15.6"

# Install useful stuff.
sudo apt-get install --yes build-essential wget curl git libreoffice

# Install signal.
wget -O- https://updates.signal.org/desktop/apt/keys.asc | sudo apt-key add -
echo "deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main" | sudo tee -a /etc/apt/sources.list.d/signal-xenial.list
sudo apt update && sudo apt install --yes signal-desktop

# Install Caprine Facebook messenger for Molly.
wget https://github.com/sindresorhus/caprine/releases/download/v2.54.0/caprine_2.54.0_amd64.deb
sudo apt-get update && sudo apt-get install --yes ./caprine_2.54.0_amd64.deb
rm -f caprine_2.54.0_amd64.deb

# Install zoom.
wget https://zoom.us/client/latest/zoom_amd64.deb
sudo apt-get update && sudo apt-get install --yes ./zoom_amd64.deb
rm -f zoom_amd64.deb

# Install tweaks
sudo apt-get install --yes software-properties-common
sudo apt-add-repository --yes ppa:philip.scott/elementary-tweaks
sudo apt-get install --yes elementary-tweaks

# Run this in case anything broke.
sudo apt-get update && sudo apt-get -y --fix-broken install
sudo apt-get -y full-upgrade && sudo apt-get -y --purge autoremove
sudo apt-get autoclean && sudo reboot
