#!/usr/bin/env bash

###############################################################################
# install.sh
# Set up symlinks for all configuration files in this directory using `stow`.

###############################################################################
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

###############################################################################
# Unix-style configuration files

owndir="$(readlink -f "$(dirname "${BASH_SOURCE[0]}")")"

# Add configs here
declare -a configs=(
	alacritty
	bash
	broot
	direnv
	git
	gnupg
	i3
	i3status
	python
	starship
	vale
	vis
)

for config in "${configs[@]}"; do
	stow --dir="${owndir}" --target="${HOME}" "${config}"
done

###############################################################################
# Other configuration

# Zotero
# https://www.zotero.org/support/kb/profile_directory
# https://developer.mozilla.org/en-US/docs/Mozilla/Preferences/A_brief_guide_to_Mozilla_preferences#Preferences_files
# https://stackoverflow.com/a/54561526/3507119
readarray -d '' zotero_default_profiles < <(
	find "${HOME}/.zotero/zotero/" -type d -name '*.default' -print0
)
if [ ${#zotero_default_profiles[@]} -eq 1 ]; then
	stow --dir="${owndir}" --target="${zotero_default_profiles[0]}" "zotero"
else
	echo "FAIL: could not find Zotero default profile folder"
	exit 1
fi

# Thunderbird
readarray -d '' thunderbird_default_profiles < <(
	find "${HOME}/.thunderbird/" -type d -name '*.default' -print0
)
if [ ${#thunderbird_default_profiles[@]} -eq 1 ]; then
	stow --dir="${owndir}" --target="${thunderbird_default_profiles[0]}" "thunderbird"
else
	echo "FAIL: could not find Thunderbird default profile folder"
	exit 1
fi
