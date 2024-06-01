#!/bin/bash

# Change to the ~/.dotfiles/ directory
cd ~/.dotfiles/ || exit

# Get the list of installed packages with pacman
pacman -Qq > lista_pacman.txt

# Get the list of installed packages with yay (AUR)
yay -Qq > lista_aur.txt

# Concatenate both lists and remove duplicates
cat lista_pacman.txt lista_aur.txt | sort -u > lista_programas_instalados.txt

# Clean up temporary files
rm lista_pacman.txt lista_aur.txt

echo "List of installed programs generated in ~/.dotfiles/lista_programas_instalados.txt"

