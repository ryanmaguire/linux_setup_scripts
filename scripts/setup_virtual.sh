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
sudo apt install --yes gnome-boxes
sudo apt install --yes binfmt-support qemu-user-static debootstrap
sudo apt install --yes qemu-utils qemu-system qemu-system-arm
sudo apt install --yes qemu-system-common qemu-system-data
sudo apt install --yes qemu-system-mips qemu-system-misc qemu-system-x86
sudo apt install --yes qemu-system-ppc qemu-system-sparc
