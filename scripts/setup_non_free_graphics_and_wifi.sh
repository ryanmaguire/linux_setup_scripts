# Pop!_OS doesn't seem to need any of these. They're probably preinstalled.
# Debian does, but these are in the NON-FREE Debian repository.

# Old, for amdgpu.
sudo apt-get install --yes firmware-amd-graphics libgl1-mesa-dri libglx-mesa0
sudo apt-get install --yes mesa-vulkan-drivers xserver-xorg-video-all
