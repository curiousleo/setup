#!/usr/bin/env bash

###############################################################################
# install.sh
# Set up symlinks for all configuration files in this directory using `stow`.
###############################################################################

###############################################################################
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'
###############################################################################

owndir="$(readlink -f "$(dirname "${BASH_SOURCE[0]}")")"

# Add configs here
declare -a configs=(
    alacritty
    bash
    git
    i3
    i3status
    python
    vim
)

for config in "${configs[@]}"
do
    stow --dir="${owndir}" --target="${HOME}" "${config}"
done
