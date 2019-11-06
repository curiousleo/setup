# If not running interactively, don't do anything
[[ $- != *i* ]] && return

EDITOR=vim

# Colourful `ls` by default
alias ls='ls --color=auto'

# Activate direnv
eval "$(direnv hook bash)"

# History configuration
HISTCONTROL=ignoreboth
HISTSIZE=10000
HISTFILESIZE=20000
shopt -s histappend

# Check windows size after each command
shopt -s checkwinsize

# Expand '**' to zero or more subdirecties
shopt -s globstar

# Completion
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  fi
fi

# Git prompt
GIT_PS1_SHOWDIRTYSTATE=1
if [ -f /usr/share/git/git-prompt.sh ]; then
  . /usr/share/git/git-prompt.sh
elif [ -f /usr/lib/git-core/git-sh-prompt ]; then
  . /usr/lib/git-core/git-sh-prompt
fi

if [ $(declare -f __git_ps1 > /dev/null ; echo $?) ]; then
  PROMPT='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
else
  PROMPT='[\u@\h \W]\$ '
fi

# Restore after nix-shell
# See https://github.com/NixOS/nix/issues/1268#issuecomment-449661822
function restore_prompt_after_nix_shell() {
  if [ "$PS1" != "$PROMPT" ]; then
    PS1=$PROMPT
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
  fi
}

PROMPT_COMMAND=restore_prompt_after_nix_shell
export PS1=$PROMPT

PATH="${HOME}/.local/bin/:${PATH}"
