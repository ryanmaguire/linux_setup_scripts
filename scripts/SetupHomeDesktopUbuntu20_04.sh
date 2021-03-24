#!/bin/bash

#   SETUP SCRIPT.
# OS:       Ubuntu (GNOME Version) 20.04
# Device:   Custom Desktop Computer
#   CPU:    AMD Ryzen 3900 12-core
#   GPU:    Power Color rx 570
#   RAM:    Ripjaw DDR4-3600 16GBx2
#   MB:     Gigabyte Aorus x570 Elite WiFi

# Log into firefox, online accounts, etc.

yes | sudo apt-get update
yes | sudo apt-get upgrade
yes | sudo apt-get dist-upgrade
yes | sudo apt-get full-upgrade
yes | sudo apt-get --purge autoremove

# Needed for downloading stuff.
yes | sudo apt-get install wget
yes | sudo apt-get install curl
yes | sudo apt-get install git

# Remove old kernel.
# sudo apt-get --purge remove linux-image-5.4.0-26-generic
# sudo apt-get update
# sudo update-grub

yes | sudo apt-get install wine
yes | sudo apt-get install wine32
yes | sudo apt-get install wine64

# LMMS and Ardour DAWs.
yes | sudo apt-get install lmms
yes | sudo apt-get install ardour

# Install nordvpn.
wget https://repo.nordvpn.com/deb/nordvpn/debian/pool/main/nordvpn-release_1.0.0_all.deb
yes | sudo apt-get install ./nordvpn-release_1.0.0_all.deb
yes | sudo apt-get update
yes | sudo apt-get install nordvpn
yes | sudo apt-get update

# Remove several things that come pre-installed.
yes | sudo apt-get remove --purge mozc-data
yes | sudo apt-get remove --purge hdate-applet
yes | sudo apt-get remove --purge anthy
yes | sudo apt-get remove --purge anthy-common
yes | sudo apt-get remove --purge debian-reference
yes | sudo apt-get remove --purge debian-reference-common
yes | sudo apt-get remove --purge fcitx
yes | sudo apt-get remove --purge fcitx-anthy
yes | sudo apt-get remove --purge fcitx-config-common
yes | sudo apt-get remove --purge fcitx5
yes | sudo apt-get remove --purge fcitx-data
yes | sudo apt-get remove --purge fcitx5-data
yes | sudo apt-get remove --purge goldendict
yes | sudo apt-get remove --purge khmerconverter
yes | sudo apt-get remove --purge mlterm
yes | sudo apt-get remove --purge xiterm+thai
yes | sudo apt-get remove --purge xterm

# Remove dependencies that are no longer needed.
yes | sudo apt-get autoremove

# Optional, remove games from work computer.
yes | sudo apt-get remove --purge aisleriot
yes | sudo apt-get remove --purge gnome-mahjongg
yes | sudo apt-get remove --purge mah-jongg
yes | sudo apt-get remove --purge five-or-more
yes | sudo apt-get remove --purge four-in-a-row
yes | sudo apt-get remove --purge hitori
yes | sudo apt-get remove --purge gnome-klotski
yes | sudo apt-get remove --purge iagno
yes | sudo apt-get remove --purge gnome-mines
yes | sudo apt-get remove --purge mlterm
yes | sudo apt-get remove --purge gnome-music
yes | sudo apt-get remove --purge gnome-nibbles
yes | sudo apt-get remove --purge quadrapassel
yes | sudo apt-get remove --purge gnome-robots
yes | sudo apt-get remove --purge gnome-sudoku
yes | sudo apt-get remove --purge swell-foop
yes | sudo apt-get remove --purge tali
yes | sudo apt-get remove --purge gnome-taquin
yes | sudo apt-get remove --purge gnome-tetravex
yes | sudo apt-get remove --purge lightsoff
yes | sudo apt-get --purge autoremove

yes | sudo apt-get --fix-broken install

# Needed to run the following from https://wiki.debian.org/AtiHowTo
yes | sudo apt-get update
yes | sudo apt-get install firmware-amd-graphics
yes | sudo apt-get install libgl1-mesa-dri
yes | sudo apt-get install libglx-mesa0
yes | sudo apt-get install mesa-vulkan-drivers
yes | sudo apt-get install xserver-xorg-video-all

# Needed for the wifi and bluetooth antenna that came with the motherboard.
yes | sudo apt-get install firmware-iwlwifi

# Finish up.
yes | sudo apt-get update
yes | sudo apt-get upgrade
yes | sudo apt-get --purge autoremove
yes | sudo apt-get autoclean
