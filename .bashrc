#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\[\e[1;32m\]\u@\h\[\e[0m\] \[\e[1;34m\]\W\[\e[0m\]]\$ '

alias grep='grep --color=auto'

if [[ -r /usr/share/bash-completion/bash_completion ]]; then
  . /usr/share/bash-completion/bash_completion
fi

export PATH="$HOME/.local/share/mise/shims:$PATH"

alias ls='eza --color=always --group-directories-first'
alias ll='eza -la --color=always --group-directories-first'
alias tree='eza --tree'
alias cat='bat --style=plain' 

if [ -z "$SSH_AUTH_SOCK" ] || ! kill -0 "$SSH_AGENT_PID" 2>/dev/null; then
    eval "$(ssh-agent -s > /dev/null)"
fi

eval "$(zoxide init bash)"
eval "$(mise activate bash)"
eval "$(fzf --bash)"
