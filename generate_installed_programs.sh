#!/bin/bash

# Change to the ~/.dotfiles/ directory
cd ~/.dotfiles/ || exit

# Get the list of installed packages with pacman
pacman -Qq > lista_pacman.txt

# Get the list of installed packages with yay (AUR)
yay -Qq > lista_aur.txt

echo "List of installed programs with pacman generated in ~/.dotfiles/lista_pacman.txt"
echo "List of installed programs with yay generated in ~/.dotfiles/lista_aur.txt"

