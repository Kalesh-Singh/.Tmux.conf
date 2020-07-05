#!/bin/bash

# Add tat function to .bashrc
if ! grep -q "tat()" "$HOME/.bashrc"; then 
cat >> ~/.bashrc << 'EOF'

# Function to create tmux sessions
tat() {
    path_name="$(basename "$PWD" | tr . -)"
    session_name=${1-$path_name}

      if [ -z "$TMUX" ]; then
        tmux new-session -As "$session_name"
      else
        if ! tmux has-session -t "=$session_name"; then
          (TMUX='' tmux new-session -Ad -s "$session_name")
        fi
        tmux switch-client -t "$session_name"
      fi
}
EOF

source ~/.bashrc
fi

# Symlink the configuration to tmux's default search file
TMUX_CONF=~/.tmux.conf
if [ -f  $TMUX_CONF ]; then
    rm $TMUX_CONF
fi
ln -s $(pwd)/tmux.conf $TMUX_CONF

# Reload .tmux.conf if alread in tmux
if [ -n "$TMUX" ]; then
    tmux source-file ~/.tmux.conf
    tmux display-message "~/.tmux.conf reloaded"
fi

