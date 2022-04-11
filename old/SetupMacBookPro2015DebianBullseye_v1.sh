#!/bin/bash

#	SETUP SCRIPT.
# OS:		Debian 11 Bullseye.
# Device:	Mid 2015 MacBook Pro Retina 15"

# Remove several things that come pre-installed.
yes | sudo apt-get remove --purge mozc-data hdate-applet anthy anthy-common
yes | sudo apt-get remove --purge debian-reference debian-reference-common
yes | sudo apt-get remove --purge debian-reference-common
yes | sudo apt-get remove --purge fcitx fcitx-anthy fcitx-config-common fcitx5
yes | sudo apt-get remove --purge fcitx-data fcitx5-data goldendict
yes | sudo apt-get remove --purge khmerconverter mlterm xiterm+thai xterm
yes | sudo apt-get --purge autoremove && sudo apt-get autoclean

# Need non-free and contrib for WiFi and graphics drivers. This assumes you
# used the main Debian installer, and not the non-free one that has these
# repositories already listed.
echo -e "\n# Needed for WiFi drivers." | sudo tee -a /etc/apt/sources.list
echo "deb http://deb.debian.org/debian/ bullseye contrib non-free" | sudo tee -a /etc/apt/sources.list
echo "deb-src http://deb.debian.org/debian/ bullseye contrib non-free" | sudo tee -a /etc/apt/sources.list
echo "deb http://security.debian.org/debian-security bullseye-security contrib non-free" | sudo tee -a /etc/apt/sources.list
echo "deb-src http://security.debian.org/debian-security bullseye-security contrib non-free" | sudo tee -a /etc/apt/sources.list

# Update pciids. This is for the WiFi card.
sudo apt-get update && yes | sudo update-pciids

# Install the WiFi drivers. You will need to restart for these to be active.
yes | sudo apt-get install linux-headers-$(uname -r) broadcom-sta-dkms
yes | sudo apt-get install broadcom-sta-common broadcom-sta-source

# Probably not needed anymore.
#	edit /etc/default/grub and add:
#		GRUB_CMDLINE_LINUX_DEFAULT=”quiet libata.force=noncq”

# Still needed:
#    sudo -s
#    crontab -e
# Add the line:
#    @reboot echo disable > /sys/firmware/acpi/interrupts/gpe06
