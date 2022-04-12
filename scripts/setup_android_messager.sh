cd ~/Downloads
wget https://github.com/chrisknepper/android-messages-desktop/releases/download/v3.1.0/android-messages-desktop_3.1.0_amd64.deb
sudo apt-get install libappindicator3-1
sudo dpkg -i ./android-messages-desktop_3.1.0_amd64.deb
sudo apt-get updage && sudo apt-get install android-messages-desktop
rm -f android-messages-desktop_3.1.0_amd64.deb

