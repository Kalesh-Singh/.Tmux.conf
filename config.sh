#!/bin/bash

# Symlink the configuration to tmux's default search file
ln -s $(pwd)/tmux.conf ~/.tmux.conf
tmux source-file ~/.tmux.conf
tmux display-message "~/.tmux.conf reloaded"

