#!/bin/bash

stow -t "$HOME" xdg-home
if [ -d "$HOME/.config/Code - Insiders" ]; then
    stow -t "$HOME/.config/Code - Insiders" -d xdg-home/.config Code
fi
