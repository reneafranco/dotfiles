#!/bin/bash

# Variables
REPO_URL="https://github.com/user/dotfiles.git"  # Replace with your repository URL
DOTFILES_DIR="$HOME/.dotfiles"
PROGRAMS_FILE="$DOTFILES_DIR/installe_programas.txt"

# Step 1: Clone the dotfiles repository into .dotfiles directory
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

echo "Setup completed."

