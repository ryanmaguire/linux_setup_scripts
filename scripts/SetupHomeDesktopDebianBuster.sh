#!/bin/bash

# SETUP SCRIPT.
# OS:     Debian 10 Buster.
# Device: Custom Desktop Computer
#    CPU:    AMD Ryzen 3900 12-core
#    GPU:    Power Color rx 570
#    RAM:    Ripjaw DDR4-3600 16GBx2
#    MB:     Gigabyte Aorus x570 Elite WiFi

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

# Needed for Microsoft Exchange emails.
echo -e "\n# Needed for evolution-ews." | sudo tee -a /etc/apt/sources.list
echo "deb http://ftp.debian.org/debian buster-backports main" | sudo tee -a /etc/apt/sources.list
echo "deb-src http://ftp.debian.org/debian buster-backports main" | sudo tee -a /etc/apt/sources.list
sudo apt-get update && yes | sudo apt-get install -t buster-backports evolution-ews

# Install useful things.
yes | sudo apt-get install wget curl rsync git plotutils gcc tcc pcc clang
yes | sudo apt-get install openvpn network-manager-openvpn gnome-boxes
yes | sudo apt-get install libcairo2-dev libsecret-1-0 libsecret-1-dev
yes | sudo apt-get install gnome-builder calibre neofetch gthumb vlc qbittorrent
yes | sudo apt-get install sagemath ipython3 gnudatalanguage texlive-full
yes | sudo apt-get update

# Knot theory stuff.
yes | pip install snappy snappy_15_knots

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

# Set up git password in GNOME Keyring.
sudo make --directory=/usr/share/doc/git/contrib/credential/libsecret
git config --global credential.helper /usr/share/doc/git/contrib/credential/libsecret/git-credential-libsecret
git config --global user.email ryan_maguire@student.uml.edu

# Clone repos.
cd ~/Documents
git clone https://github.com/ryanmaguire/Mathematics-and-Physics.git
git clone https://github.com/ryanmaguire/libtmpl.git
git clone https://github.com/ryanmaguire/LinuxSetupScripts.git
git clone https://github.com/NASA-Planetary-Science/rss_ringoccs.git

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

# Run this in case anything broke.
yes | sudo apt-get --fix-broken install
yes | sudo apt-get full-upgrade
yes | sudo apt-get --purge autoremove
yes | sudo apt-get autoclean

sudo reboot
