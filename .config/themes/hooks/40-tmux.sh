#!/usr/bin/env bash
source "$HOME/.config/dotfiles/paths.sh"
source "$DOTFILES_THEME_STATE/base16.sh"

cat << EOF > "$DOTFILES_THEME_STATE/tmux"
set -g status-style "fg=$B04"
set -g window-status-style "fg=$B04"
set -g window-status-current-style "fg=$B05"
set -g pane-border-style "fg=$B02"
set -g pane-active-border-style "fg=$B0D"
set -g mode-style "bg=$B02,fg=$B05"
set -g message-style "bg=$B01,fg=$B05"
set -g message-command-style "bg=$B01,fg=$B05"
EOF

    tmux source-file "$HOME/.config/tmux/tmux.conf" 2>/dev/null || true
