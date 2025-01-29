#!/usr/bin/nu
# update/upgrade
sudo pacman -Syu --noconfirm

# Outputs currently installed packages to the file
let output_file = ($env.HOME | path join 'installed_packages.txt')
pacman -Qqe | save --force $output_file

print $"List of installed packages saved in ($output_file)"
print "Invoke install_pacs.sh to install your packages"
