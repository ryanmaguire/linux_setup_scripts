# Install useful things.
yes | sudo apt-get install picard gnome-boxes openvpn network-manager-openvpn
yes | sudo apt-get install libcairo2-dev sagemath obs-studio handbrake
yes | sudo apt-get install binfmt-support qemu qemu-user-static debootstrap
sudo apt-get update

# Knot theory stuff.
yes | pip install snappy snappy_15_knots regina
