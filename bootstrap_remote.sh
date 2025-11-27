#!/bin/bash

# Install kitty terminal if not already installed
if [ -f ~/.dotfiles/.terminfo/x/xterm-kitty.ti ]; then
   tic -x -o ~/.terminfo ~/.dotfiles/.terminfo/x/xterm-kitty.ti
fi




