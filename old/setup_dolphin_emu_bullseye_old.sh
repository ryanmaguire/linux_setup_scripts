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
sudo apt-get install --yes --no-install-recommends ca-certificates qtbase5-dev qtbase5-private-dev git cmake make
sudo apt-get install --yes --no-install-recommends gcc g++ pkg-config libavcodec-dev libavformat-dev libavutil-dev
sudo apt-get install --yes --no-install-recommends libswscale-dev libxi-dev libxrandr-dev libudev-dev libevdev-dev
sudo apt-get install --yes --no-install-recommends libsfml-dev libminiupnpc-dev libmbedtls-dev libcurl4-openssl-dev
sudo apt-get install --yes --no-install-recommends libhidapi-dev libsystemd-dev libbluetooth-dev libasound2-dev
sudo apt-get install --yes --no-install-recommends libpulse-dev libpugixml-dev libbz2-dev libzstd-dev liblzo2-dev
sudo apt-get install --yes --no-install-recommends libpng-dev libusb-1.0-0-dev gettext
cd ~/Downloads
git clone https://github.com/dolphin-emu/dolphin.git dolphin-emu
cd ./dolphin-emu
git submodule update --init
mkdir Build && cd Build
cmake ..
make -j$(nproc)
sudo make install
