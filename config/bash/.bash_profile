#
# ~/.bash_profile
#

# https://stackoverflow.com/a/57884156/3507119
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
    fi
fi

# opam configuration
test -r /home/leo/.opam/opam-init/init.sh && . /home/leo/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true

export PYTHONSTARTUP=~/.config/python/startup
export GOPATH=~/.local/share/go
