#!/bin/bash

# SETUP SCRIPT.
# OS:     Ubuntu (GNOME Version) 20.04
# Device: Custom Desktop Computer
#   CPU:    AMD Ryzen 3900 12-core
#   GPU:    Power Color rx 570
#   RAM:    Ripjaw DDR4-3600 16GBx2
#   MB:     Gigabyte Aorus x570 Elite WiFi

# Give sudo permission to user.
# Go to /etc/sudoers. You'll need root permissions so:
#    su
#    nano /etc/sudoers
# Add the line:
#    %ryan    ALL=(ALL:ALL) ALL
# Save the changes and then run:
#    apt-get update
#    exit
# You're no longer running as root, but should have sudo permission.
# Check this with sudo apt-get update

# MANUAL
# yes | sudo apt-get update
# yes | sudo apt-get upgrade
# yes | sudo apt-get dist-upgrade
# yes | sudo apt-get full-upgrade
# yes | sudo apt-get update
# yes | sudo apt-get --purge autoremove
# yes | sudo apt-get autoclean
# yes | sudo update-grub
# sudo reboot

# Then remove the old Linux kernel.
# uname -r
# dpkg --list "*linux-image*" | grep ii
# yes | sudo apt-get --purge remove linux-image-VERSION
# yes | sudo apt-get update
# yes | sudo apt-get full-upgrade
# yes | sudo apt-get --purge autoremove
# yes | sudo apt-get autoclean
# sudo update-grub

# Then reboot and run this file.

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
yes | sudo apt-get autoclean

# Useful stuff.
yes | sudo apt-get install wget
yes | sudo apt-get install curl
yes | sudo apt-get install git
yes | sudo apt-get install wine
yes | sudo apt-get install wine32
yes | sudo apt-get install wine64
yes | sudo apt-get install lmms
yes | sudo apt-get install ardour
yes | sudo apt-get install evolution-ews
yes | sudo apt-get --fix-broken install

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
yes | sudo apt-get install jackd2
yes | sudo apt-get install jackd2-firewire
yes | sudo apt-get install ffado-dbus-server
yes | sudo apt-get install ffado-mixer-qt4
yes | sudo apt-get install multimedia-firewire
yes | sudo apt-get install cadence
yes | sudo apt-get install carla
yes | sudo apt-get install catia
yes | sudo apt-get install ffado-tools
yes | sudo apt-get install libffado2

# You then need to blacklist snd_dice. Add the following file:
sudo touch /etc/modprobe.d/alsa-nope.conf
echo "blacklist snd_dice" | sudo tee -a /etc/modprobe.d/alsa-nope.conf
sudo usermod -a -G audio $(whoami)

# You'll need to reboot for all of this to go into effect.

# Finish up.
yes | sudo apt-get update
yes | sudo apt-get upgrade
yes | sudo apt-get --purge autoremove
yes | sudo apt-get autoclean

# Old, for amdgpu and wifi card.
#    yes | sudo apt-get install firmware-amd-graphics
#    yes | sudo apt-get install libgl1-mesa-dri
#    yes | sudo apt-get install libglx-mesa0
#    yes | sudo apt-get install mesa-vulkan-drivers
#    yes | sudo apt-get install xserver-xorg-video-all

# Needed for the wifi and bluetooth antenna that came with the motherboard.
#    yes | sudo apt-get install firmware-iwlwifi

