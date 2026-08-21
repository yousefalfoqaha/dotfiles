#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='\[\e[1;32m\]\u@\h\[\e[0m\]:\[\e[1;34m\]\w\[\e[0m\]\$ '

alias grep='grep --color=auto'

if [[ -r /usr/share/bash-completion/bash_completion ]]; then
  . /usr/share/bash-completion/bash_completion
fi

export PATH="$HOME/.local/share/mise/shims:$PATH"
export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/ssh-agent.socket"

alias ls='eza --color=always --group-directories-first'
alias ll='eza -la --color=always --group-directories-first'
alias tree='eza --tree'
alias cat='bat --style=plain' 

eval "$(mise activate bash)"
