#!/usr/bin/env bash

###############################################################################
# format.sh
# Format Nix and Bash files in this directory using `nixfmt`.

###############################################################################
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

###############################################################################
# Format files
owndir="$(readlink -f "$(dirname "${BASH_SOURCE[0]}")")"
find "${owndir}" -type f -name '*.nix' -print0 | xargs -0 nixfmt
find "${owndir}" -type f -name '*.sh' -print0 | xargs -0 shfmt -w
