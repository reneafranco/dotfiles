#!/bin/bash

# Variables
REPO_URL="https://github.com/reneafranco/dotfiles.git"  # Replace with your repository URL
DOTFILES_DIR="$HOME/.dotfiles"
PROGRAMS_FILE="$DOTFILES_DIR/lista_programas_instalados.txt"
CONFIG_DIR="$HOME/.config"

# Step 1: Clone or update the dotfiles repository
if [ -d "$DOTFILES_DIR" ]; then
    echo "$DOTFILES_DIR already exists. Updating repository..."
    git -C "$DOTFILES_DIR" pull
else
    echo "Cloning repository into $DOTFILES_DIR..."
    git clone "$REPO_URL" "$DOTFILES_DIR"
fi

# Step 2: Create symbolic links
echo "Creating symbolic links..."
ln -sf "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"
ln -sf "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"

# Step 3: Install programs listed in installe_programas.txt
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

# Step 4: Backup .config directory
echo "Backing up .config directory..."
rsync -av --exclude '.git/' "$CONFIG_DIR" "$DOTFILES_DIR/"

echo "Setup completed."

