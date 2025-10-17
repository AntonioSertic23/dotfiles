# 🖥️ My Hyprland Dotfiles

This repository contains my personal configuration files for **Hyprland**, **Waybar**, **Kitty**, and related tools on **Arch Linux**.

## 📂 Contents

### 🪟 Hyprland

- `hypr/hyprland.conf` – main Hyprland configuration
- `hypr/hyprpaper.conf` – wallpaper settings for Hyprpaper
- `hypr/evangelion_background.png` – wallpaper image used by Hyprpaper

### 🧭 Waybar

- `waybar/config.jsonc` – main Waybar configuration file
- `waybar/style.css` – CSS styling for Waybar
- `waybar/power_menu.xml` – custom power menu layout

### 🐱 Kitty

- `kitty/kitty.conf` – main Kitty terminal configuration
- `kitty/kitty-themes/` – directory containing cloned Kitty themes

## 💡 Purpose

I use this repository to back up and synchronize my **Hyprland** setup across different devices, keeping all my customizations, visuals, and terminal configurations consistent.

## ⚙️ Installation

Clone the repository:

```bash
git clone git@github.com:AntonioSertic23/dotfiles.git ~/.config
```

Clone Kitty themes:

```bash
git clone git@github.com:dexpota/kitty-themes.git ~/.config/kitty/kitty-themes
```

🎨 Change Kitty Theme

To apply a specific theme, open your kitty.conf and include a theme file, for example:

```bash
include ./kitty-themes/themes/OneDark.conf
```

You can browse available themes in the kitty-themes directory and switch them anytime.
