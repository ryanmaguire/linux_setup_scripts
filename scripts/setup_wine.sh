# Enable 32-bit packages.
sudo dpkg --add-architecture i386

# Download repo key.
wget -nc https://dl.winehq.org/wine-builds/winehq.key
sudo mv winehq.key /usr/share/keyrings/winehq-archive.key

# Download WineHW Sources file.
wget -nc https://dl.winehq.org/wine-builds/debian/dists/bullseye/winehq-bullseye.sources
sudo mv winehq-bullseye.sources /etc/apt/sources.list.d/

# Install
sudo apt-get update && sudo apt install --install-recommends winehq-devel
