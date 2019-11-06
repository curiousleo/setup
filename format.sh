#!/usr/bin/env bash

###############################################################################
# format.sh
# Format all Nix and Bash files.

###############################################################################
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

###############################################################################
# Format files
owndir="$(readlink -f "$(dirname "${BASH_SOURCE[0]}")")"
find "${owndir}" -type f -name '*.nix' -print0 | xargs -0 nixpkgs-fmt
find "${owndir}" -type f -name '*.sh' -print0 | xargs -0 shfmt -w
