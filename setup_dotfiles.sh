#!/bin/bash

# Define variables
DOTFILES_DIR="$HOME/.dotfiles"
REPO_URL="URL_DEL_REPOSITORIO_AQUI"  # Reemplaza "URL_DEL_REPOSITORIO_AQUI" con la URL real del repositorio

# Clone dotfiles repository
echo "Cloning dotfiles repository..."
git clone "$REPO_URL" "$DOTFILES_DIR" || { echo "Error: Could not clone dotfiles repository."; exit 1; }

# Step 3: Install programs listed in installe_programas.txt
PROGRAMS_FILE="$DOTFILES_DIR/installe_programas.txt"
if [ -f "$PROGRAMS_FILE" ]; then
    echo "Installing programs..."
    while IFS= read -r program; do
        if ! command -v "$program" &> /dev/null; then
            echo "Installing $program..."
            sudo apt-get install -y "$program"
        else
            echo "$program is already installed."
        fi
    done < "$PROGRAMS_FILE"
else
    echo "$PROGRAMS_FILE does not exist."
    exit 1
fi

echo "Setup completed."

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
for file in "${FILES_TO_LINK[@]}"; do
    src="$DOTFILES_DIR/$file"
    dest="$HOME/.config/$file"
    if [ -e "$src" ]; then
        if [ -e "$dest" ]; then
            echo "$dest already exists, removing..."
            rm -rf "$dest"
        fi
        echo "Creating symbolic link for $file..."
        ln -s "$src" "$dest"
    else
        echo "File $file does not exist in $DOTFILES_DIR."
    fi
done

