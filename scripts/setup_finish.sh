# Things I run at the end of an installation.
sudo apt-get update
sudo apt-get --yes --fix-broken install && sudo apt-get --yes full-upgrade
sudo apt-get --yes --purge autoremove && sudo apt-get autoclean && sudo reboot
