#!/usr/bin/env bash
source "$HOME/.config/dotfiles/paths.sh"
source "$DOTFILES_THEME_STATE/base16.sh"

if [ -n "$NVIM_THEME" ]; then
    mkdir -p "$DOTFILES_THEME_STATE" "$DOTFILES_DATA_HOME/nvim"
    printf '%s\n' "$NVIM_THEME" > "$DOTFILES_THEME_STATE/neovim"
    ln -sfn "$DOTFILES_THEME_STATE/neovim" "$DOTFILES_DATA_HOME/nvim/theme"

    for server in $(find "${XDG_RUNTIME_DIR:-/run/user/$(id -u)}" -maxdepth 1 -name "nvim.*.0" -type s 2>/dev/null); do
        nvim --server "$server" --remote-send "<C-\><C-n>:Theme ${NVIM_THEME}<CR><C-\><C-n>:restart<CR>" < /dev/null > /dev/null 2>&1 &
    done
fi
