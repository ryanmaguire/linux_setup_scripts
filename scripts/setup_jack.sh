# Needed to use Saffire pro 40. The PulseAudio drivers work, but have
# occasional xruns. JACK, using the FFADO drivers, works perfect.

# Update software sources
sudo apt-get update

# Install required dependencies if needed
sudo apt-get install apt-transport-https gpgv wget

# Download package file
wget https://launchpad.net/~kxstudio-debian/+archive/kxstudio/+files/kxstudio-repos_11.1.0_all.deb

# Install it
sudo dpkg -i kxstudio-repos_11.1.0_all.deb

# Now install jack and all the necessary FFADO stuff.
sudo apt-get update
yes | sudo apt-get install jackd2 jackd2-firewire ffado-dbus-server libffado2
yes | sudo apt-get install multimedia-firewire cadence carla catia ffado-tools

# You then need to blacklist snd_dice. Add the following file:
sudo touch /etc/modprobe.d/alsa-nope.conf
echo "blacklist snd_dice" | sudo tee -a /etc/modprobe.d/alsa-nope.conf
sudo usermod -a -G audio $(whoami)

# Music apps (DAWs, Windows plugins on Linux).
yes | sudo apt-get install lmms ardour

# Skip. Doesn't work anymore on Debian Bullseye.
# carla-bridge-win64 carla-bridge-wine32 carla-bridge-wine64

# Clean up.
rm -f kxstudio-repos_11.1.0_all.deb
sudo apt update
