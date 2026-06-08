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

# Delete pin file before updating
if [ -f /etc/apt/preferences.d/gnome-core ]; then
  sudo rm /etc/apt/preferences.d/gnome-core
fi
sudo apt update
apt-get download gnome-core
gnome_core="$(find . -name "gnome-core_*_amd64.deb")"
mkdir ./debtmp
dpkg-deb -R "$gnome_core" ./debtmp
sed -i "s|, pipewire-audio||g" ./debtmp/DEBIAN/control
cd ./debtmp/
find . -type f -not -path "./DEBIAN/*" -exec md5sum {} + | sort -k 2 | sed 's/\.\/\(.*\)/\1/' > DEBIAN/md5sums
cd ..
dpkg-deb -b --root-owner-group ./debtmp "$gnome_core"
sudo dpkg -i "$gnome_core"
sudo rm "$gnome_core"
sudo rm -rf ./debtmp
sudo apt install pulseaudio
echo "
Package: gnome-core
Pin: version *
Pin-Priority: -1
" | sudo tee /etc/apt/preferences.d/gnome-core

# Myriad of problems using a firewire device with PipeWire. Can't seem to
# change latency, can't use FFADO drivers, numbering for the input and output
# sockets on a Saffire Pro 40 are wrong, and most annoying can't create a sink
# to Jack2. Going back to pulseaudio fixes this.
sudo apt-get install --yes pulseaudio pulseaudio-module-jack pulseaudio-module-bluetooth
systemctl --user unmask pulseaudio
systemctl --user --now disable pipewire-media-session.service
systemctl --user --now disable pipewire pipewire-pulse
systemctl --user --now enable pulseaudio.service pulseaudio.socket
sudo apt-get --purge remove pipewire-audio-client-libraries
sudo apt-get --purge remove pipewire-pulse wireplumber
