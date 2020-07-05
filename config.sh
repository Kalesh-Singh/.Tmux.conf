#!/bin/bash

# Add tat command to PATH
# sudo cat > /bin/tat <<EOF
# tmux new-session -A -s ${1:-temp}
# EOF

# sudo cat > /bin/tat <<EOF
# tmux new-session -A -s ${1:-temp}
# EOF

# sudo chmod +x /bin/tat

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
ln -s $(pwd)/tmux.conf ~/.tmux.conf &> /dev/null

echo $TMUX

#if [ -n "$TMUX" ]; then
    tmux source-file ~/.tmux.conf
    tmux display-message "~/.tmux.conf reloaded"
#fi

