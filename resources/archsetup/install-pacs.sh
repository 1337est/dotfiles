#!/bin/bash
echo "#################################"
echo "   STARTING SYSTEM UPDATE        "
echo "#################################"

# Ensure everything is updated/upgraded
sudo pacman -Syu --noconfirm

# Define the input file name
input_file=~/installed_packages.txt

# Check if the input file exists
if [ ! -f "$input_file" ]; then
    echo "Error: $input_file not found."
    exit 1
fi

echo "#################################"
echo "   STARTING PACMAN INSALLATION   "
echo "#################################"

# Loop and read each line (package) from the input file and install it
while IFS= read -r package; do
    # Remove leading and trailing whitespace characters
    package=$(echo "$package" | xargs)
    # Install the package
    sudo pacman -S --noconfirm --needed "$package"
done < "$input_file"

echo "#################################"
echo "   PACMAN INSALLATION COMPLETE   "
echo "#################################"
