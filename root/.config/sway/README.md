## GTK Theming

Run these once in the terminal on a fresh install:

```sh
# Globals
gsettings set org.gnome.desktop.interface text-scaling-factor 1.23
gsettings set org.gnome.desktop.interface font-name 'Inter Display 11'
gsettings set org.gnome.desktop.interface cursor-theme 'Adwaita'

# NemoFM
gsettings set org.nemo.preferences default-folder-viewer 'icon-view'
gsettings set org.nemo.icon-view default-zoom-level 'larger'
gsettings set org.nemo.preferences ignore-view-metadata true
```
