#!/bin/bash

# Define variables
DOTFILES_DIR="$HOME/.dotfiles"
REPO_URL="https://github.com/reneafranco/dotfiles.git"  # Reemplaza "URL_DEL_REPOSITORIO_AQUI" con la URL real del repositorio

# Check if ~/.dotfiles directory exists
if [ -d "$DOTFILES_DIR" ]; then
    echo "$DOTFILES_DIR already exists. Skipping cloning."
else
    echo "Cloning dotfiles repository..."
    git clone "$REPO_URL" "$HOME/dotfiles" || { echo "Error: Could not clone dotfiles repository."; exit 1; }
    mv "$HOME/dotfiles" "$DOTFILES_DIR"
fi

# Install yay
if ! command -v yay &> /dev/null; then
    echo "Installing yay..."
    sudo pacman -S --needed base-devel git
    git clone https://aur.archlinux.org/yay.git
    cd yay || { echo "Error: Could not change to yay directory."; exit 1; }
    makepkg -si
    cd ..
    rm -rf yay
else
    echo "yay is already installed."
fi

# Function to install programs from a file using a specific package manager
install_programs() {
    local file=$1
    local installer=$2
    if [ -f "$file" ]; then
        echo "Installing programs from $file using $installer..."
        while IFS= read -r program; do
            if [ -d "$HOME/.config/$program" ]; then
                echo "Removing existing directory $HOME/.config/$program..."
                rm -rf "$HOME/.config/$program"
            fi
            if ! command -v "$program" &> /dev/null; then
                echo "Installing $program..."
                sudo "$installer" -S --noconfirm "$program"
            else
                echo "$program is already installed."
            fi
            if [ -d "$HOME/.config/$program" ]; then
                echo "Removing existing directory $HOME/.config/$program after installation..."
                rm -rf "$HOME/.config/$program"
            fi
        done < "$file"
    else
        echo "$file does not exist."
        exit 1
    fi
}

# Install programs listed in install_pacman.txt and install_yay.txt
PACMAN_PROGRAMS_FILE="$DOTFILES_DIR/install_pacman.txt"
YAY_PROGRAMS_FILE="$DOTFILES_DIR/install_yay.txt"

# Install pacman programs
install_programs "$PACMAN_PROGRAMS_FILE" "pacman"

# Install yay programs
install_programs "$YAY_PROGRAMS_FILE" "yay"

echo "Setup completed."

# Install SDKMAN
echo "Installing SDKMAN..."
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"

if sdk version &> /dev/null; then
    echo "SDKMAN installed successfully."
else
    echo "Error: SDKMAN installation failed."
    exit 1
fi

# Create symbolic links for the specified files
FILES_TO_LINK=(
    alacritty
    fonts
    gtk-2.0
    i3
    i3blocks
    neofetch
    nitrogen
    nvim
    pulse
    systemd
    yay
    zsh
    generate_installed_programs.sh
    lista_programas_instalados.txt
    README.md
    setup_dotfiles.sh
)

echo "Creating symbolic links..."

# Create symbolic links in ~/.config
for file in "${FILES_TO_LINK[@]}"; do
    src="$DOTFILES_DIR/$file"
    dest="$HOME/.config/$file"
    if [ -e "$src" ]; then
        if [ -e "$dest" ]; then
            echo "$dest already exists, removing..."
            rm -rf "$dest"
        fi
        echo "Creating symbolic link for $file in ~/.config..."
        ln -s "$src" "$dest"
    else
        echo "File $file does not exist in $DOTFILES_DIR."
    fi
done

# Create symbolic link for sdkman in ~/.sdkman
SDKMAN_DIR="sdkman"
src="$DOTFILES_DIR/$SDKMAN_DIR"
dest="$HOME/.sdkman"
if [ -e "$src" ]; then
    if [ -e "$dest" ]; then
        echo "$dest already exists, removing..."
        rm -rf "$dest"
    fi
    echo "Creating symbolic link for $SDKMAN_DIR in ~/.sdkman..."
    ln -s "$src" "$dest"
else
    echo "Directory $SDKMAN_DIR does not exist in $DOTFILES_DIR."
fi

# Check and remove existing files in home directory
HOME_FILES=(
    .zshrc
    .bashrc
    .bash_profile
)

for file in "${HOME_FILES[@]}"; do
    dest="$HOME/$file"
    if [ -e "$dest" ]; then
        echo "$dest already exists, removing..."
        rm -rf "$dest"
    fi
done

# Create symbolic links in ~/
for file in "${HOME_FILES[@]}"; do
    src="$DOTFILES_DIR/$file"
    dest="$HOME/$file"
    if [ -e "$src" ]; then
        echo "Creating symbolic link for $file in ~..."
        ln -s "$src" "$dest"
    else
        echo "File $file does not exist in $DOTFILES_DIR."
    fi
done

