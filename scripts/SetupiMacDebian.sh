# Change display to 2560x1440 since the 5k resolution is really zoomed out.
# Go to Tweaks and change to dark mode (in Appearance).

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

# Start the script in home.
cd ~

# Run updates and upgrades.
yes | sudo apt-get update
yes | sudo apt-get upgrade
yes | sudo apt-get update
yes | sudo apt-get dist-upgrade
yes | sudo apt-get full-upgrade
yes | sudo apt-get update

# Create and edit the .nanorc file.
touch .nanorc
echo "set tabsize 4" >> .nanorc
echo "set constantshow" >> .nanorc
source .nanorc

# To add calendars for Microsoft Exchange (UML and Dartmouth)
# add evolution-ews. On Buster this is available on backports.
# Add to /etc/apt/sources.list:
echo -e "\n# Needed for evolution-ews." | sudo tee -a /etc/apt/sources.list
echo "deb http://deb.debian.org/debian buster-backports main" | \
	sudo tee -a /etc/apt/sources.list
echo "deb-src http://deb.debian.org/debian buster-backports main" | \
    sudo tee -a /etc/apt/sources.list

sudo apt-get update
yes | sudo apt-get install -t buster-backports evolution-ews


# Run the rest of the script in downloads.
cd ~/Downloads

# Run updates and upgrades.
yes | sudo apt-get update
yes | sudo apt-get upgrade
yes | sudo apt-get dist-upgrade
yes | sudo apt-get full-upgrade
yes | sudo apt-get update

# Install curl and wget for downloading files.
yes | sudo apt-get install wget
yes | sudo apt-get install curl

# Install git for cloing repositories.
yes | sudo apt-get install git
yes | sudo apt-get update

# Update pciids. I forget why I want this, but I think it has to do with the wi-fi card.
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

# Install Caprine Facebook messenger for Molly.
wget https://github.com/sindresorhus/caprine/releases/download/v2.52.0/caprine_2.52.0_amd64.deb
yes | sudo apt-get install ./caprine_2.52.0_amd64.deb
yes | sudo apt-get update

# Install nordvpn.
wget https://rep.nordvpn.com/deb/nordvpn/debian/pool/main/nordvpn-release_1.0.0_all.deb
yes | sudo apt-get install ./nordvpn-release_1.0.0_all.deb
yes | sudo apt-get update
yes | sudo apt-get install nordvpn
yes | sudo apt-get update

# Install the NoobsLab flat-remix theme.
wget https://launchpad.net/~noobslab/+archive/ubuntu/themes/+files/flat-remix-gs-theme_3.12-1~xenial~NoobsLab.com_all.deb
yes | sudo apt-get install ./flat-remix-gs-theme_3.12-1~xenial~NoobsLab.com_all.deb
yes | sudo apt-get update

# Install qbittorrent.
yes | sudo apt-get install qbittorrent
yes | sudo apt-get update

# Install zoom.
wget https://zoom.us/client/latest/zoom_amd64.deb
yes | sudo apt-get install ./zoom_amd64.deb
yes | sudo apt-get update

# Install Calibre (book library).
sudo -v && wget -nv -O- https://download.calibre-ebook.com/linux-installer.sh | sudo sh /dev/stdin
yes | sudo apt-get update

# Install LaTeX.
yes | sudo apt-get install texlive-full
yes | sudo apt-get update

# Run this in case anything broke.
yes | sudo apt-get --fix-broken install
yes | sudo apt-get autoremove
yes | sudo apt-get autoclean

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
yes | sudo apt-get autoremove

# You may want to remove the .deb files in ~/Downloads.
# rm -f *.deb

# MANUAL THINGS.
# Set up your git stuff. GNOME Keyring may work here.
# Set command+up and command+down to change workspace.
# Go to mouse/touchpad settings and enable tap-to-click.
# Sign into Firefox sync.
# Sign into nordvpn.
# Set up emails in Evolution and Thunderbird.
# Activate theme in Tweaks app.
# Change desktop background to something cool.
# Move frequently used apps to dock.
# Go to GNOME and set up icon bar and user preferences:
#    Dash-to-Dock
#    Trasnparent OSD
#    Enable user themes.

# Optional.
# Install VLC. Works great. Rhythmbox and GNOME videos are sufficient, however.

# Install Jami. Pretty buggy, couldn't get to work.
# Signal now has voice and video calls, so this is unnecessary.

# Install the wifi driver. This driver is dated. Do not use.
# yes | sudo apt-get install firmware-b43-installer

# These drivers work very well.
# yes | sudo apt-get update
# yes | sudo apt-get install broadcom-sta-common
# yes | sudo apt-get install broadcom-sta-source
# yes | sudo apt-get install broadcom-sta-dkms
# Most likely I'll just use ethernet, so this is unnecessary.

# Remove old kernel files we no longer need.
# uname -r
# dpkg --list 'linux-image*' | grep ^ii

# Remove the older files.
# sudo apt-get remove linux-image-VERSION
# yes | sudo apt-get autoremove

# Finally, update GRUB.
# sudo update-grub

# After removing the old kernel files, you may need to reinstall the touch pad drivers.
# These should still be in Downloads.

# Change the default resolution with xrandr.
#   cvt 2560 1440

# This gave:
# 2560x1440 59.96 Hz (CVT 3.69M9) hsync: 89.52 kHz; pclk: 312.25 MHz
#   Modeline "2560x1440_60.00"  312.25  2560 2752 3024 3488  1440 1443 1448 1493 -hsync +vsync

# Grab the output and pass it to xrandr.
#   xrandr --newmode "2560x1440_60.00" 312.25 2560 2752 3024 3488  1440 1443 1448 1493 -hsync +vsync
#   xrandr --addmode XWAYLAND0 "2560x1440"
#   xrandr --output XWAYLAND0 --mode "2560x1440"

# Install pCloud and sync.
# Sign in to signal and sync.

# Add email/online accounts. Microsoft Exchange and google were normal.
# Yahoo needs a special two-factor password. Go to:
#    https://login.yahoo.com/account/security/app-passwords
