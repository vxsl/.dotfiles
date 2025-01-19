#!/bin/bash

stow -t "$HOME" xdg-home
if [ -d "$HOME/.config/Code - Insiders" ]; then
    stow -t "$HOME/.config/Code - Insiders" -d xdg-home/.config Code
fi

for dir in */; do
    dir=${dir%/}  # Remove trailing slash
    if [[ $dir != "xdg-home" && $dir != "xdg-home-minimal" ]]; then
        stow -t "/$dir" "$dir"
    fi
done
