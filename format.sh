#!/usr/bin/env bash

###############################################################################
# format.sh
# Format Nix files in this directory using `nixfmt`.

###############################################################################
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

###############################################################################
# Format Nix files

owndir="$(readlink -f "$(dirname "${BASH_SOURCE[0]}")")"
find "${owndir}" -type f -name '*.nix' -print0 | xargs -0 nixfmt