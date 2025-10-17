#!/bin/bash
# setup_symlinks.sh
# Script to create symlinks from dotfiles to ~/.config

DOTFILES_DIR="$HOME/.config/dotfiles"
TARGET_DIR="$HOME/.config"

# List of dotfiles or folders to symlink
DOTFILES_ITEMS=(
    "hypr"
    "kitty"
    "waybar"
    "starship.toml"
)

echo "Creating symlinks from $DOTFILES_DIR to $TARGET_DIR"

for ITEM in "${DOTFILES_ITEMS[@]}"; do
    SRC="$DOTFILES_DIR/$ITEM"
    DEST="$TARGET_DIR/$ITEM"

    if [ -L "$DEST" ]; then
        echo "Symlink $DEST already exists, replacing..."
        rm "$DEST"
    elif [ -e "$DEST" ]; then
        echo "File or folder $DEST already exists and is not a symlink, skipping..."
        continue
    fi

    ln -s "$SRC" "$DEST"
    echo "Created symlink: $DEST -> $SRC"
done

echo "All done!"
