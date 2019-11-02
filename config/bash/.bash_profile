#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# opam configuration
test -r /home/leo/.opam/opam-init/init.sh && . /home/leo/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true

export PYTHONSTARTUP=~/.config/python/startup
