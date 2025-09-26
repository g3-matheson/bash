#!/bin/bash

SWAP_STATE_FILE="$HOME/.bash/caps-esc-swap-setting"

if [ -f "$SWAP_STATE_FILE" ]; then
gsettings reset org.gnome.desktop.input-sources xkb-options
rm "$SWAP_STATE_FILE"
echo "Caps Lock <=> Esc back to default"
else
gsettings set org.gnome.desktop.input-sources xkb-options "['caps:swapescape']"
touch "$SWAP_STATE_FILE"
echo "Caps Lock <=> Esc swapped"
fi