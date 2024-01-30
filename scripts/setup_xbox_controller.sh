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

# Driver for better xbox one controller support.
# The newer controllers need this. Older ones
# Work fine out of the box with the Linux Kernel.
# The newer ones are not properly mapped.
# (The R button is start, and stuff like that).
sudo apt-get install --yes dkms linux-headers-`uname -r`
cd ~/Downloads/
git clone https://github.com/atar-axis/xpadneo.git
cd xpadneo
sudo ./install.sh
cd ../
rm -rf xpadneo
