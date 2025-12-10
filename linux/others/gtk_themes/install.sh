#!/usr/bin/env bash

echo "WARNING: this script may not work for all GTK4/libadwaita apps"

# === Variables ===
GTK_THEME="Yaru-dark"
ICON_THEME="Yaru"

# === Create folders ===
mkdir -p $HOME/.config/gtk-3.0
mkdir -p $HOME/.config/gtk-4.0

# === GTK 3 Settings ===
cat > $HOME/.config/gtk-3.0/settings.ini << EOF
[Settings]
gtk-theme-name = $GTK_THEME
gtk-icon-theme-name = $ICON_THEME
gtk-application-prefer-dark-theme = 1
EOF

# === GTK 4 Settings ===
cat > $HOME/.config/gtk-4.0/settings.ini << EOF
[Settings]
gtk-theme-name = $GTK_THEME
gtk-icon-theme-name = $ICON_THEME
gtk-application-prefer-dark-theme = 1
EOF

# === Gnome Settings ===
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

# === Environment variable for apps launched from this session ===
export GTK_THEME="$GTK_THEME:dark"

echo "GTK3 & GTK4 dark theme applied for your session."
echo "Some libadwaita apps may still show light mode."
