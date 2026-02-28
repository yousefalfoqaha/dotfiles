alias n='nvim'
alias fd='fdfind'
alias ls='eza --icons'
alias ll='eza -lh --icons'
alias la='eza -lha --icons'
alias tree='eza --tree --icons'

eval "$(starship init bash)"

if [ -z "$SSH_AUTH_SOCK" ]; then
  eval $(ssh-agent -s) > /dev/null
  ssh-add ~/.ssh/id_ed25519 2>/dev/null
fi
