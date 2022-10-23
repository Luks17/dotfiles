#!/bin/bash

./arch_apps_install.sh

systemctl enable fstrim.timer
systemctl enable NetworkManager
systemctl enable firewalld

echo "Enter your CPU (0 for amd, any number for intel): "
read cpu
if [ $cpu -eq 0 ]
then
	echo "Installing AMD Ucode"
	pacman -S amd-ucode
else
	echo "Installing Intel Ucode"
	pacman -S intel-ucode
fi
