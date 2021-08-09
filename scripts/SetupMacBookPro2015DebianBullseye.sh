#!/bin/bash

#	SETUP SCRIPT.
# OS:		Debian 11 Bullseye.
# Device:	Mid 2015 MacBook Pro Retina 15"

# Add yourself to the sudoers file:
#   su

# Then alter /etc/sudoers adding the following line:
#   %ryan	ALL=(ALL:ALL) ALL

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

# Remove several things that come pre-installed. These are mostly apps for
# non-English users that I never use.
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
yes | sudo apt-get remove --purge mlterm

# Update pciids. Recommended on the Debian wiki for MacBook Pro WiFi.
yes | sudo update-pciids

# Need non-free and contrib for WiFi and graphics drivers. This assumes you
# used the main Debian installer, and not the non-free one that has these
# repositories already listed.
echo -e "\n# Needed for WiFi drivers." | sudo tee -a /etc/apt/sources.list
echo "deb http://deb.debian.org/debian/" \
     "bullseye contrib non-free" | sudo tee -a /etc/apt/sources.list
echo "deb-src http://deb.debian.org/debian/" \
     "bullseye contrib non-free" | sudo tee -a /etc/apt/sources.list

echo -e "\ndeb http://security.debian.org/debian-security"\
	"bullseye-security contrib non-free" | sudo tee -a /etc/apt/sources.list
echo -e "deb-src http://security.debian.org/debian-security"\
	"bullseye-security contrib non-free" | sudo tee -a /etc/apt/sources.list

# Update the new sources.list.
yes | sudo apt-get update
yes | sudo apt-get install wireless-tools
yes | sudo apt-get install linux-headers-$(uname -r)
yes | sudo apt-get install broadcom-sta-common
yes | sudo apt-get install broadcom-sta-source
yes | sudo apt-get install broadcom-sta-dkms
yes | sudo apt-get install firmware-linux
yes | sudo apt-get install firmware-linux-nonfree

# Usefull apps.
yes | sudo apt-get install git
yes | sudo apt-get install gnome-builder
yes | sudo apt-get install calibre
yes | sudo apt-get install vlc
yes | sudo apt-get install gnudatalanguage
yes | sudo apt-get install sagemath
yes | sudo apt-get install ipython3
yes | sudo apt-get install wget
yes | sudo apt-get install texlive-full
yes | sudo apt-get install jami
yes | sudo apt-get install gthumb
yes | sudo apt-get update

# Install signal. These are the comments from signal.

# NOTE: These instructions only work for 64 bit Debian-based
# Linux distributions such as Ubuntu, Mint etc.

# 1. Install our official public software signing key
wget -O- https://updates.signal.org/desktop/apt/keys.asc | sudo apt-key add -

# 2. Add our repository to your list of repositories
echo "deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main" |\
  sudo tee -a /etc/apt/sources.list.d/signal-xenial.list

# 3. Update your package database and install signal
yes | sudo apt update
yes | sudo apt install signal-desktop

# Set up git password in GNOME Keyring. You will need to create a personal
# access token with GitHub for this.
yes | sudo apt-get install libsecret-1-0
yes | sudo apt-get install libsecret-1-dev
sudo make --directory=/usr/share/doc/git/contrib/credential/libsecret
git config --global credential.helper \
	/usr/share/doc/git/contrib/credential/libsecret/git-credential-libsecret
git config --global user.email ryan_maguire@student.uml.edu

cd ~/Documents
git clone https://github.com/ryanmaguire/Mathematics-and-Physics.git
git clone https://github.com/ryanmaguire/libtmpl.git
git clone https://github.com/ryanmaguire/LinuxSetupScripts.git
git clone https://github.com/NASA-Planetary-Science/rss_ringoccs.git

# And some more cleanup.
yes | sudo apt-get --fix-broken install
yes | sudo apt-get --purge autoremove
yes | sudo apt-get autoclean
yes | sudo apt-get update

# Probably not needed anymore.
#	edit /etc/default/grub and add:
#		GRUB_CMDLINE_LINUX_DEFAULT=”quiet libata.force=noncq”

# Still needed:
#    sudo -s
#    crontab -e
# Add the line:
#    @reboot echo disable > /sys/firmware/acpi/interrupts/gpe06

