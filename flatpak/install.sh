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

flatpak --user remote-add --if-not-exists \
	flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak --user --noninteractive update

flatpak --user --noninteractive install flathub com.discordapp.Discord
flatpak --user --noninteractive install flathub com.skype.Client
flatpak --user --noninteractive install flathub com.slack.Slack
flatpak --user --noninteractive install flathub com.spotify.Client
flatpak --user --noninteractive install flathub com.valvesoftware.Steam
flatpak --user --noninteractive install flathub us.zoom.Zoom
