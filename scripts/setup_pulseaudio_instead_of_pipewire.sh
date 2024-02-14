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

# Myriad of problems using a firewire device with PipeWire. Can't seem to
# change latency, can't use FFADO drivers, numbering for the input and output
# sockets on a Saffire Pro 40 are wrong, and most annoying can't create a sink
# to Jack2. Going back to pulseaudio fixes this.
sudo apt-get install --yes pulseaudio pulse-module-jack pulseaudio-module-bluetooth
systemctl --user unmask pulseaudio
systemctl --user --now disable pipewire-media-session.service
systemctl --user --now disable pipewire pipewire-pulse
systemctl --user --now enable pulseaudio.service pulseaudio.socket
sudo apt-get --purge remove pipewire-audio-client-libraries
