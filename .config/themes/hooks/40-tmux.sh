#!/usr/bin/env bash
source "$HOME/.config/themes/current/base16.sh"
CURRENT="$HOME/.config/themes/current"

cat << EOF > "$CURRENT/tmux"
set -g status-style "fg=$B04"
set -g window-status-style "fg=$B04"
set -g window-status-current-style "fg=$B0A,bold"
set -g pane-active-border-style "fg=$B0D"
set -g pane-border-style "fg=$B02"
set -g message-style "bg=$B0D,fg=$B00"
set -g message-command-style "bg=$B0D,fg=$B00"
EOF

tmux source-file "$HOME/.config/tmux/tmux.conf" 2>/dev/null || true

