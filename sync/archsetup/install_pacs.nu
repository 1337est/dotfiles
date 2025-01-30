#!/usr/bin/nu
print "##################################"
print "      STARTING SYSTEM UPDATE      "
print "##################################"

# Ensure everything is updated/upgraded
sudo pacman -Syu --noconfirm

# Define the input file name
let input_file = ($env.HOME | path join 'installed_packages.txt')

# Check if the input file exists
if not ($input_file | path exists) {
    print $"Error: ($input_file) not found."
    exit 1
}

print "############################################"
print "   CHECKING FOR /usr/bin/yay INSTALLATION   "
print "############################################"

# Check if yay is installed
if not (which yay | is-empty) {
    print "yay is installed, continuing package installation..."
} else {
    print "Installing yay..."
    mkdirp ~/Code/aur
    cd ~/Code/aur
    sudo pacman -S --needed --noconfirm git base-devel
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    yay -Y --gendb
    yay -Syu --devel
    yay -Y --devel --save
}

print "##################################"
print "   STARTING PACKAGE INSALLATION   "
print "##################################"

# Loop and read each line (package) from the input file and install it
open $input_file | lines | each {|pkg| # lines returns a list
    # check if package exists
    yay -S --noconfirm --needed $pkg
}

print "##################################"
print "   PACKAGE INSALLATION COMPLETE   "
print "##################################"
