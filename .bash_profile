#
# ~/.bash_profile
#

export PATH="$HOME/.local/bin:$PATH"

[[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/dotfiles/paths.sh" ]] && . "${XDG_CONFIG_HOME:-$HOME/.config}/dotfiles/paths.sh"

[[ -f ~/.bashrc ]] && . ~/.bashrc

if [ -z "$WAYLAND_DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
    export XDG_SESSION_TYPE=wayland
    export XDG_SESSION_DESKTOP=sway
    export XDG_CURRENT_DESKTOP=sway
    export MOZ_ENABLE_WAYLAND=1
    
    exec sway --unsupported-gpu
fi
