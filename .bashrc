# ~/dotfiles/.bashrc

alias n='nvim'
alias ls='eza -lh --icons'
alias ll='eza -lha --icons --git'
alias tree='eza --tree --icons'

export EDITOR='nvim'
export VISUAL='nvim'

eval "$(starship init bash)"
