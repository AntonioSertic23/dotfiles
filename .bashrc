#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias ll='ls -la'
alias grep='grep --color=auto'
alias update='sudo pacman -Syu'

#PS1='[\u@\h \W]\$ '
#PS1='\[\e[1;32m\]\u@\h \[\e[1;34m\]\w \$\[\e[0m\]'

eval "$(starship init bash)"

export EDITOR="code --wait"

if [ -f /usr/share/bash-completion/bash_completion ]; then
  . /usr/share/bash-completion/bash_completion
fi
