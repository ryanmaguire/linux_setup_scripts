#!/bin/bash

#	SETUP SCRIPT.
# OS:		Debian 11 Bullseye.
# Device:	Mid 2015 MacBook Pro Retina 15"

# Add yourself to the sudoers file:
#   su

# Then alter /etc/sudoers adding the following line:
#   %ryan	ALL=(ALL:ALL) ALL

# Run updates and upgrades.
yes | sudo apt-get update
yes | sudo apt-get upgrade
yes | sudo apt-get dist-upgrade
yes | sudo apt-get full-upgrade
yes | sudo apt-get update

if [ $1 == "--reboot" ]; then
    yes | sudo update-grub
    sudo reboot
fi

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
yes | sudo apt-get install wget
yes | sudo apt-get install curl
yes | sudo apt-get install git
yes | sudo apt-get install gnome-builder
yes | sudo apt-get install calibre
yes | sudo apt-get install texlive-full
yes | sudo apt-get install vlc
yes | sudo apt-get install gnudatalanguage
yes | sudo apt-get install sagemath
yes | sudo apt-get install ipython3
yes | sudo apt-get update

# Install signal.
cd ~/Downloads
wget -O- https://updates.signal.org/desktop/apt/keys.asc | sudo apt-key add -
echo "deb [arch=amd64] https://updates.signal.org/desktop/apt"\
     "xenial main" | sudo tee -a /etc/apt/sources.list.d/signal-xenial.list
yes | sudo apt update
yes | sudo apt install signal-desktop

# Install nordvpn.
wget https://repo.nordvpn.com/deb/nordvpn/debian/pool/main/nordvpn-release_1.0.0_all.deb
yes | sudo apt-get install ./nordvpn-release_1.0.0_all.deb
yes | sudo apt-get update
yes | sudo apt-get install nordvpn
yes | sudo apt-get update

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
git config --global credential.helper \
	/usr/share/doc/git/contrib/credential/libsecret/git-credential-libsecret
git config --global user.email ryan_maguire@student.uml.edu

# Make a Projects directory and clone all my repos.
mkdir ~/Projects
cd ~/Projects
git clone https://github.com/ryanmaguire/Mathematics-and-Physics.git
git clone https://github.com/ryanmaguire/libtmpl.git
git clone https://github.com/ryanmaguire/LinuxSetupScripts.git
git clone https://github.com/NASA-Planetary-Science/rss_ringoccs.git

# And some more cleanup.
yes | sudo apt-get --purge autoremove
yes | sudo apt-get autoclean
yes | sudo apt-get update

# edit /etc/default/grub and add:
#    GRUB_CMDLINE_LINUX_DEFAULT=”quiet libata.force=noncq”


# Then do:
#    sudo -s
#    crontab -e
# Add the line:
#    @reboot echo disable > /sys/firmware/acpi/interrupts/gpe06
