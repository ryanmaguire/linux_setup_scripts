# Need non-free and contrib for WiFi and graphics drivers. This assumes you
# used the main Debian installer, and not the non-free one that has these
# repositories already listed.
echo -e "\n# Needed for WiFi and graphics drivers." | sudo tee -a /etc/apt/sources.list
echo "deb http://deb.debian.org/debian/ bullseye contrib non-free" | sudo tee -a /etc/apt/sources.list
echo "deb-src http://deb.debian.org/debian/ bullseye contrib non-free" | sudo tee -a /etc/apt/sources.list
sudo apt-get update
