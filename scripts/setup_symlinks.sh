#!/bin/bash
# setup_symlinks.sh
# Creates symlinks from dotfiles repo to config/home locations.

set -e  # exit on error

# Get absolute path of the script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

# Define associative array: "source" -> "target destination"
declare -A SYMLINKS=(
    # ~/.config items
    ["hypr"]="$HOME/.config/hypr"
    ["kitty"]="$HOME/.config/kitty"
    ["waybar"]="$HOME/.config/waybar"
    ["starship.toml"]="$HOME/.config/starship.toml"

    # Home-level files
    [".bashrc"]="$HOME/.bashrc"
)

echo "Creating symlinks from $DOTFILES_DIR ..."

for ITEM in "${!SYMLINKS[@]}"; do
    SRC="$DOTFILES_DIR/$ITEM"
    DEST="${SYMLINKS[$ITEM]}"

    if [ ! -e "$SRC" ]; then
        echo "⚠️  Source $SRC does not exist, skipping."
        continue
    fi

    # If destination exists
    if [ -L "$DEST" ]; then
        echo "🔁 Symlink $DEST already exists, replacing..."
        rm "$DEST"
    elif [ -e "$DEST" ]; then
        echo "⚠️  $DEST exists and is not a symlink, skipping..."
        continue
    fi

    ln -s "$SRC" "$DEST"
    echo "✅ Created symlink: $DEST → $SRC"
done

echo "🎉 All symlinks created!"
