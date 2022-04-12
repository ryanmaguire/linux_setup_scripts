
# Driver for better xbox one controller support.
# The newer controllers need this. Older ones
# Work fine out of the box with the Linux Kernel.
# The newer ones are not properly mapped.
# (The R button is start, and stuff like that).
sudo apt-get install dkms linux-headers-`uname -r`
cd ~/Downloads/
git clone https://github.com/atar-axis/xpadneo.git
cd xpadneo
sudo ./install.sh
cd ../
rm -rf xpadneo
