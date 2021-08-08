#!/bin/bash

# SETUP SCRIPT.
# OS:     Ubuntu (GNOME Version) 20.04
# Device: Custom Desktop Computer
#   CPU:    AMD Ryzen 3900 12-core
#   GPU:    Power Color rx 570
#   RAM:    Ripjaw DDR4-3600 16GBx2
#   MB:     Gigabyte Aorus x570 Elite WiFi

# Remove several things that come pre-installed.
yes | sudo apt-get remove --purge mozc-data hdate-applet anthy anthy-common
yes | sudo apt-get remove --purge debian-reference debian-reference-common
yes | sudo apt-get remove --purge debian-reference-common
yes | sudo apt-get remove --purge fcitx fcitx-anthy fcitx-config-common fcitx5
yes | sudo apt-get remove --purge fcitx-data fcitx5-data goldendict
yes | sudo apt-get remove --purge khmerconverter mlterm xiterm+thai xterm

# Optional, remove games from work computer.
yes | sudo apt-get remove --purge gnome-mahjongg mah-jongg five-or-more
yes | sudo apt-get remove --purge four-in-a-row hitori gnome-klotski iagno
yes | sudo apt-get remove --purge gnome-mines mlterm gnome-music gnome-nibbles
yes | sudo apt-get remove --purge quadrapassel gnome-robots gnome-sudoku
yes | sudo apt-get remove --purge swell-foop tali gnome-taquin gnome-tetravex
yes | sudo apt-get remove --purge lightsoff aisleriot
yes | sudo apt-get --purge autoremove
yes | sudo apt-get autoclean
yes | sudo apt-get update

# Useful stuff.
yes | sudo apt-get install wget curl git wine wine32 wine64 lmms ardour
yes | sudo apt-get install evolution-ews

# Needed to use Saffire pro 40. The PulseAudio drivers work, but have
# occasional xruns. The Jack Audio server, when using the FFADO drivers, works
# perfect. A few steps are needed to get it running.

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
yes | sudo apt-get update
yes | sudo apt-get full-upgrade
yes | sudo apt-get install jackd2 jackd2-firewire ffado-dbus-server
yes | sudo apt-get install ffado-mixer-qt4 multimedia-firewire
yes | sudo apt-get install cadence carla catia ffado-tools libffado2

# You then need to blacklist snd_dice. Add the following file:
sudo touch /etc/modprobe.d/alsa-nope.conf
echo "blacklist snd_dice" | sudo tee -a /etc/modprobe.d/alsa-nope.conf
sudo usermod -a -G audio $(whoami)

# Finish up.
yes | sudo apt-get update
yes | sudo apt-get upgrade
yes | sudo apt-get --purge autoremove
yes | sudo apt-get autoclean
sudo reboot
