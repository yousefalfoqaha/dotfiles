#!/usr/bin/env bash
source "$HOME/.config/themes/current/base16.sh"

if [ -n "$NVIM_THEME" ]; then
    echo "$NVIM_THEME" > "$HOME/.local/share/nvim/theme"

    for server in $(find "${XDG_RUNTIME_DIR:-/run/user/$(id -u)}" -maxdepth 1 -name "nvim.*.0" -type s 2>/dev/null); do
        nvim --server "$server" --remote-send "<C-\><C-n>:Theme ${NVIM_THEME}<CR><C-\><C-n>:restart<CR>" 2>/dev/null &
    done
fi
