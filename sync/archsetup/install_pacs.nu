#!/usr/bin/nu
print "#################################"
print "   STARTING SYSTEM UPDATE        "
print "#################################"

# Ensure everything is updated/upgraded
sudo pacman -Syu --noconfirm

# Define the input file name
let input_file = ($env.HOME | path join 'installed_packages.txt')

# Check if the input file exists
if not ($input_file | path exists) {
    print $"Error: ($input_file) not found."
    exit 1
}

print "#################################"
print "   STARTING PACMAN INSALLATION   "
print "#################################"

# TODO: fix loop error
# Loop and read each line (package) from the input file and install it
open $input_file | lines | each {|pkg|
    let package = $pkg | str trim
    if not ($package | str length == 0) {
        sudo pacman -S --noconfirm --needed $package
    }
}

print "#################################"
print "   PACMAN INSALLATION COMPLETE   "
print "#################################"
