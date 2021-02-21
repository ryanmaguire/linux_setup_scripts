#!/bin/bash

#	SETUP SCRIPT.
# OS:		Debian 10 Buster.
# Device:	Mid 2012 MacBook Pro 13"

# Add yourself to the sudoers file:
#   su

# Then alter /etc/sudoers adding the following line:
#   %ryan	ALL=(ALL:ALL) ALL

# Run updates and upgrades.
yes | sudo apt-get update
yes | sudo apt-get upgrade
yes | sudo apt-get update
yes | sudo apt-get dist-upgrade
yes | sudo apt-get full-upgrade
yes | sudo apt-get update

# Update pciids. I forget why I want this, but I think it
# has to do with the wi-fi card.
yes | sudo update-pciids

# Need non-free and contrib for WiFi and graphics drivers. This assumes you
# used the main Debian installer, and not the non-free one that has these
# repositories already listed.
echo -e "\n# Needed for WiFi and graphics drivers." |\
  sudo tee -a /etc/apt/sources.list
echo "deb http://deb.debian.org/debian/ buster contrib non-free" |\
  sudo tee -a /etc/apt/sources.list
echo "deb-src http://deb.debian.org/debian/ buster contrib non-free" |\
  sudo tee -a /etc/apt/sources.list

# To add calendars for Microsoft Exchange (UML and Dartmouth)
# add evolution-ews. On Buster this is available on backports.
# Add to /etc/apt/sources.list:
echo -e "\n# Needed for evolution-ews." | sudo tee -a /etc/apt/sources.list
echo "deb http://ftp.debian.org/debian buster-backports main" |\
  sudo tee -a /etc/apt/sources.list
echo "deb-src http://ftp.debian.org/debian buster-backports main" |\
  sudo tee -a /etc/apt/sources.list

# Update the new sources.list.
yes | sudo apt-get update

# Install the WiFi drivers. You will need to restart for these to be active.
yes | sudo apt-get update
yes | sudo apt-get install linux-headers-$(uname -r)
yes | sudo apt-get install broadcom-sta-common
yes | sudo apt-get install broadcom-sta-source
yes | sudo apt-get install broadcom-sta-dkms

# Needed for the Intel graphics driver.
yes | sudo apt-get install firmware-linux
yes | sudo apt-get install firmware-linux-nonfree

# Install the Microsoft Exchange extension for evolution.
yes | sudo apt-get install -t buster-backports evolution-ews

# Run the rest of the script in downloads.
cd ~/Downloads

# Install curl and wget for downloading files.
yes | sudo apt-get install wget
yes | sudo apt-get install curl

# Install git for cloing repositories.
yes | sudo apt-get install git
yes | sudo apt-get update

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

# Install the NoobsLab flat-remix theme.
wget https://launchpad.net/~noobslab/+archive/ubuntu/themes/+files/flat-remix-gs-theme_3.12-1~xenial~NoobsLab.com_all.deb
yes | sudo apt-get install ./flat-remix-gs-theme_3.12-1~xenial~NoobsLab.com_all.deb

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

# Install VLC.
yes | sudo apt-get install vlc

# Install jami
yes | sudo apt-get install jami

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

# Run this in case anything broke.
yes | sudo apt-get --fix-broken install
yes | sudo apt-get --purge autoremove
yes | sudo apt-get autoclean

# You may want to remove the .deb files in ~/Downloads.
rm -f ~/Downloads/*.deb
yes | sudo apt-get update
cd ~

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

# Install Sagemath for knot theory stuff.
yes | sudo apt-get install sagemath

# Install iPython3. iPython will use python 2.7 in Debian 10 Buster.
yes | sudo apt-get install ipython3

# And some more cleanup.
yes | sudo apt-get --purge autoremove
yes | sudo apt-get autoclean

# MANUAL THINGS.
# Set ctrl+up and ctrl+down to change workspace.
# Go to mouse/touchpad settings and enable tap-to-click.
# Sign into Firefox sync.
# Sign into nordvpn.
# Install pCloud and sync.
# Sign in to signal and sync.
# Add email/Online Accounts. Microsoft and Google are normal.
# UML and Dartmouth accounts can be set up via IMAP/SMTP.
# Yahoo needs a special two-factor password. Go to:
#   https://login.yahoo.com/account/security/app-passwords
#   In GNOME Online Accounts, select:
#   imap server: imap.mail.yahoo.com
#   username: Email without @yahoo.com
#   encryption: SSL
#   smtp server: smtp.mail.yahoo.com
#   username: Email without @yahoo.com
#   encryption: SSL
# For iCLoud emai;
#   imap server: imap.mail.me.com
#   port: 993
#   encryption: SSL
#   username: email without @icloud.com
#   password: Create an app-specific password.
#   smtp server: smtp.mail.me.com
#   encryption: SSL
#   port: 587
#   username: email with the @icloud.com included.
#   password: Same app-specific password.
# Set up emails in Thunderbird.
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
#   sudo apt-get remove linux-image-VERSION
#   yes | sudo apt-get --purge autoremove
# Finally, update GRUB.
#   sudo update-grub

# OLD
# Fix mac address problem. Go to /etc/NetworkManager/NetworkManager.conf
# Add the lines:
#   [device]
#   wifi.scan-rand-mac-address=no
# Save and run:
#   sudo systemctl restart NetworkManager
#   /etc/init.d/network-manager restart
# Go to /etc/network/
#   sudo nano interfaces
# Comment out the line:
#   source /etc/network/interfaces.d/*
