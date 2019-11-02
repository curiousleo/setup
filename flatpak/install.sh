#!/usr/bin/env bash

###############################################################################
# install.sh
# Set up Flatpak applications.

###############################################################################
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

###############################################################################
# Flatpak

flatpak remote-add --if-not-exists \
    flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak update

flatpak install flathub com.valvesoftware.Steam
