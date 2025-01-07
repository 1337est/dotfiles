#!/bin/bash
# update/upgrade
sudo pacman -Syu --noconfirm

# Outputs currently installed packages to the file
output_file="$HOME/installed_packages.txt"
pacman -Qqe > "$output_file"

echo "List of installed packages saved in $output_file"
echo "Invoke install_pacs.sh to install your packages"
