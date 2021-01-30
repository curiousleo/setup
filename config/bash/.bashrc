#
# ~/.bashrc
#

EDITOR=vim
VIEWER=bat

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
    PROMPT_COMMAND=""
  fi
}

#PROMPT_COMMAND=restore_prompt_after_nix_shell
export PS1="$PROMPT"

PATH="${HOME}/.local/bin/:${PATH}"

export FZF_DEFAULT_COMMAND='fd --hidden --type f'
export BAT_THEME='Monokai Extended Light'

#
# Git key bindings
# https://stackoverflow.com/a/37007733
#

is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

gb() {
  # Choose branch
  is_in_git_repo &&
    git branch -a -vv --color=always | grep -v '/HEAD\s' |
    fzf --height 40% --ansi --multi --tac | sed 's/^..//' | awk '{print $1}' |
    sed 's#^remotes/[^/]*/##'
}

gt() {
  # Choose tag
  is_in_git_repo &&
    git tag --sort -version:refname |
    fzf --height 40% --multi
}

gh() {
  # Choose hash
  is_in_git_repo &&
    git log --date=short --format="%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)" --graph |
    fzf --height 40% --ansi --no-sort --reverse --multi | grep -o '[a-f0-9]\{7,\}'
}

gr() {
  # Choose remote
  is_in_git_repo &&
    git remote -v | awk '{print $1 " " $2}' | uniq |
    fzf --height 40% --tac | awk '{print $1}'
}

bind '"\er": redraw-current-line'
bind '"\C-g\C-b": "$(gb)\e\C-e\er"'
bind '"\C-g\C-t": "$(gt)\e\C-e\er"'
bind '"\C-g\C-h": "$(gh)\e\C-e\er"'
bind '"\C-g\C-r": "$(gr)\e\C-e\er"'

#
# Initialise helpers
#

source "${HOME}/.config/broot/launcher/bash/br"
eval "$(zoxide init bash)"
eval "$(starship init bash)"
