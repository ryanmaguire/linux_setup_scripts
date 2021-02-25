#!/bin/bash

#	SETUP SCRIPT.
# OS:		Debian 10 Buster.
# Device:	Custom Desktop Computer
#	CPU:	AMD Ryzen 3900 12-core
#	GPU:	Power Color rx 570
#	RAM:	Ripjaw DDR4-3600 16GBx2
#	MB:	Gigabyte Aorus x570 Elite WiFi

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
yes | sudo apt-get update
yes | sudo apt-get dist-upgrade
yes | sudo apt-get full-upgrade
yes | sudo apt-get update

# To add calendars for Microsoft Exchange (UML and Dartmouth)
# add evolution-ews. On Buster this is available on backports.
# Add to /etc/apt/sources.list:
echo -e "\n# Needed for evolution-ews." | sudo tee -a /etc/apt/sources.list
echo "deb http://ftp.debian.org/debian buster-backports main" |\
  sudo tee -a /etc/apt/sources.list
echo "deb-src http://ftp.debian.org/debian buster-backports main" |\
  sudo tee -a /etc/apt/sources.list
yes | sudo apt-get update
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

# Used for ssh with Dartmouth's server.
yes | sudo apt-get install filezilla

# Used for Dartmouth's VPN
yes | sudo apt-get install openvpn
yes | sudo apt-get install network-manager-openvpn

# Install git for cloning repositories.
yes | sudo apt-get install git
yes | sudo apt-get update

# Update pciids. I forget why I want this, but I think it
# has to do with the wi-fi card.
yes | sudo update-pciids

# We need dkms to run the install script for the Apple Magic Pad drivers.
yes | sudo apt-get install dkms

# Grab the driver repository from GitHub.
git clone https://github.com/rohitpid/Linux-Magic-Trackpad-2-Driver.git

# Change directory into the repository we just cloned.
cd Linux-Magic-Trackpad-2-Driver/scripts

# Give execute permission to the install script and run it.
chmod u+x install.sh
sudo ./install.sh

# Change directory back to downloads.
cd ~/Downloads

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
yes | sudo apt update && sudo apt install signal-desktop

# Install nordvpn.
wget https://repo.nordvpn.com/deb/nordvpn/debian/pool/main/nordvpn-release_1.0.0_all.deb
yes | sudo apt-get install ./nordvpn-release_1.0.0_all.deb
yes | sudo apt-get update
yes | sudo apt-get install nordvpn
yes | sudo apt-get update

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
yes | sudo apt-get autoremove

# You may want to remove the .deb files in ~/Downloads.
rm -f ~/Downloads/*.deb
yes | sudo apt-get update
cd ~

# The following errors occured:
# W: Possible missing firmware /lib/firmware/amdgpu/vega20_asd.bin for module amdgpu
# W: Possible missing firmware /lib/firmware/amdgpu/vega20_sos.bin for module amdgpu
# W: Possible missing firmware /lib/firmware/amdgpu/vega20_rlc.bin for module amdgpu
# W: Possible missing firmware /lib/firmware/amdgpu/vega20_mec2.bin for module amdgpu
# W: Possible missing firmware /lib/firmware/amdgpu/vega20_mec.bin for module amdgpu
# W: Possible missing firmware /lib/firmware/amdgpu/vega20_me.bin for module amdgpu
# W: Possible missing firmware /lib/firmware/amdgpu/vega20_pfp.bin for module amdgpu
# W: Possible missing firmware /lib/firmware/amdgpu/vega20_ce.bin for module amdgpu
# W: Possible missing firmware /lib/firmware/amdgpu/vega20_sdma1.bin for module amdgpu
# W: Possible missing firmware /lib/firmware/amdgpu/vega20_sdma.bin for module amdgpu
# W: Possible missing firmware /lib/firmware/amdgpu/vega20_uvd.bin for module amdgpu
# W: Possible missing firmware /lib/firmware/amdgpu/vega20_vce.bin for module amdgpu
# W: Possible missing firmware /lib/firmware/amdgpu/vega20_smc.bin for module amdgpu

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

# Run this in case anything broke.
yes | sudo apt-get --fix-broken install
yes | sudo apt-get upgrade
yes | sudo apt-get full-upgrade
yes | sudo apt-get autoremove
yes | sudo apt-get autoclean

# MANUAL THINGS.
# Set ctrl+up and ctrl+down to change workspace.
# Go to mouse/touchpad settings and enable tap-to-click.
# Sign into Firefox sync.
# Sign into nordvpn.
# Install pCloud and sync.
# Sign in to signal and sync.
# Set up git password in keyring.
# Add email/Online Accounts. Microsoft and Google are normal.
# Yahoo needs a special two-factor password. Go to:
#    https://login.yahoo.com/account/security/app-passwords
# Set up emails in Evolution and Thunderbird.
# Activate theme in Tweaks app.
# Change desktop background to something cool.
# Move frequently used apps to dock.
# Go to GNOME and set up icon bar and user preferences:
#    Dash-to-Dock
#    Trasnparent OSD
#    Enable user themes.

# Remove old kernel files we no longer need.
# uname -r
# dpkg --list 'linux-image*' | grep ^ii

# Remove the older files.
# sudo apt-get remove linux-image-VERSION
# yes | sudo apt-get autoremove

# Finally, update GRUB.
# sudo update-grub

# After removing the old kernel files, you may need to reinstall
# the touch pad drivers. These should still be in Downloads.
