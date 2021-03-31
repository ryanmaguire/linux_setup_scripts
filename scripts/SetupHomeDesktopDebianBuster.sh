#!/bin/bash

#	SETUP SCRIPT.
# OS:       Debian 10 Buster.
# Device:   Custom Desktop Computer
#	CPU:    AMD Ryzen 3900 12-core
#	GPU:    Power Color rx 570
#	RAM:    Ripjaw DDR4-3600 16GBx2
#	MB:	    Gigabyte Aorus x570 Elite WiFi

# Must add NON-FREE firmware for graphics card and WiFi antenna.

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

# Run updates and upgrades.
yes | sudo apt-get update
yes | sudo apt-get upgrade
yes | sudo apt-get dist-upgrade
yes | sudo apt-get full-upgrade
yes | sudo apt-get update
yes | sudo apt-get --purge autoremove
yes | sudo apt-get autoclean

if [ $1 == "--reboot" ]; then
    yes | sudo update-grub
    sudo reboot
fi

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

# To add calendars for Microsoft Exchange (UML and Dartmouth)
# add evolution-ews. On Buster this is available on backports.
# Add to /etc/apt/sources.list:
echo -e "\n# Needed for evolution-ews." | sudo tee -a /etc/apt/sources.list
echo "deb http://ftp.debian.org/debian buster-backports main" |\
  sudo tee -a /etc/apt/sources.list
echo "deb-src http://ftp.debian.org/debian buster-backports main" |\
  sudo tee -a /etc/apt/sources.list
yes | sudo apt-get update

# Install the Microsoft Exchange extension for evolution.
yes | sudo apt-get install -t buster-backports evolution-ews

# Run the rest of the script in downloads.
cd ~/Downloads

# Install curl and wget for downloading files.
yes | sudo apt-get install wget
yes | sudo apt-get install curl

# Useful for syncing with external drives.
yes | sudo apt-get install rsync

# Used for plotting, GNU's plot-utils.
yes | sudo apt-get install plotutils

# Used for Dartmouth's VPN
yes | sudo apt-get install openvpn
yes | sudo apt-get install network-manager-openvpn

# Install git for cloning repositories.
yes | sudo apt-get install git
yes | sudo apt-get update

# Update pciids. I forget why I want this, but I think it
# has to do with the wi-fi card.
yes | sudo update-pciids

# Install GNOME Builder (or VS Code).
yes | sudo apt-get install gnome-builder

# Install signal. These are the comments from signal.

# NOTE: These instructions only work for 64 bit Debian-based
# Linux distributions such as Ubuntu, Mint etc.

# 1. Install our official public software signing key
wget -O- https://updates.signal.org/desktop/apt/keys.asc |\
  sudo apt-key add -

# 2. Add our repository to your list of repositories
echo "deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main" |\
  sudo tee -a /etc/apt/sources.list.d/signal-xenial.list

# 3. Update your package database and install signal
yes | sudo apt update
yes | sudo apt install signal-desktop

# Install nordvpn.
wget https://repo.nordvpn.com/deb/nordvpn/debian/pool/main/nordvpn-release_1.0.0_all.deb
yes | sudo apt-get install ./nordvpn-release_1.0.0_all.deb
yes | sudo apt-get update
yes | sudo apt-get install nordvpn
yes | sudo apt-get update

# For VSCode. GNOME Buiilder is good for most purposes, but VSCode has a
# LaTeX extension that is very useful.
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /usr/share/keyrings/microsoft-archive-keyring.gpg
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft-archive-keyring.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
yes | sudo apt-get install apt-transport-https
yes | sudo apt-get update
yes | sudo apt-get install code

# Install qbittorrent.
yes | sudo apt-get update
yes | sudo apt-get install qbittorrent

# Install zoom.
yes | sudo apt-get update
wget https://zoom.us/client/latest/zoom_amd64.deb
yes | sudo apt-get install ./zoom_amd64.deb
yes | sudo apt-get update

# Install Calibre (book library).
sudo -v && wget -nv -O- https://download.calibre-ebook.com/linux-installer.sh | sudo sh /dev/stdin

# Install LaTeX.
yes | sudo apt-get install texlive-full

# You may want to remove the .deb files in ~/Downloads.
rm -f ~/Downloads/*.deb
yes | sudo apt-get update
cd ~

# Needed to run the following from https://wiki.debian.org/AtiHowTo
echo -e "\n# Needed for amdgpu." | sudo tee -a /etc/apt/sources.list
echo "deb http://deb.debian.org/debian buster contrib non-free" |\
  sudo tee -a /etc/apt/sources.list
echo "deb-src http://deb.debian.org/debian buster contrib non-free" |\
  sudo tee -a /etc/apt/sources.list
yes | sudo apt-get update
yes | sudo apt-get install firmware-amd-graphics
yes | sudo apt-get install libgl1-mesa-dri
yes | sudo apt-get install libglx-mesa0
yes | sudo apt-get install mesa-vulkan-drivers
yes | sudo apt-get install xserver-xorg-video-all

# Needed for the wifi and bluetooth antenna that came with the motherboard.
yes | sudo apt-get install firmware-iwlwifi

# Needed to use UPnP with home server.
yes | sudo apt-get install vlc
yes | sudo apt-get update

# Used for knot theory stuff with SnapPy.
yes | sudo apt-get install sagemath
yes | sudo apt-get install ipython3
yes | sudo apt-get update

pip install snappy
pip install snappy_15_knots
yes | sudo apt-get update

# Set up git password in GNOME Keyring. You will need to create a personal
# access token with GitHub for this.
yes | sudo apt-get install libsecret-1-0
yes | sudo apt-get install libsecret-1-dev
sudo make --directory=/usr/share/doc/git/contrib/credential/libsecret
git config --global credential.helper /usr/share/doc/git/contrib/credential/libsecret/git-credential-libsecret

# Then use this:
git config --global user.email ryan_maguire@student.uml.edu

# Make a Projects directory and clone all my repos.
mkdir ~/Projects
cd ~/Projects
git clone https://github.com/ryanmaguire/Mathematics-and-Physics.git
git clone https://github.com/ryanmaguire/libtmpl.git
git clone https://github.com/ryanmaguire/LinuxSetupScripts.git
git clone https://github.com/NASA-Planetary-Science/rss_ringoccs.git

# Install GNU Data Language (GDL), a free/open-source IDL replacement.
yes | sudo apt-get install gnudatalanguage

# Install iPython3. iPython will use python 2.7 in Debian 10 Buster.
yes | sudo apt-get install ipython3

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
yes | sudo apt-get upgrade
yes | sudo apt-get install jackd2
yes | sudo apt-get install jackd2-firewire
yes | sudo apt-get install ffado-dbus-server
yes | sudo apt-get install ffado-mixer-qt4
yes | sudo apt-get install multimedia-firewire
yes | sudo apt-get install cadence
yes | sudo apt-get install ffado-tools
yes | sudo apt-get install libffado2

# You then need to blacklist snd_dice. Add the following file:
sudo touch /etc/modprobe.d/alsa-nope.conf
echo "blacklist snd_dice" | sudo tee -a /etc/modprobe.d/alsa-nope.conf

# You'll need to reboot for all of this to go into effect.

# Used for virtual machines.
yes | sudo apt-get install gnome-boxes

yes | sudo apt-get install neofetch
yes | sudo apt-get install libcairo2-dev
yes | sudo apt-get install gthumb

# Run this in case anything broke.
yes | sudo apt-get --fix-broken install
yes | sudo apt-get full-upgrade
yes | sudo apt-get --purge autoremove
yes | sudo apt-get autoclean

sudo reboot
