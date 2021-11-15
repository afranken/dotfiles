#!/bin/bash
###
# use "bash strict mode", @see http://redsymbol.net/articles/unofficial-bash-strict-mode/
# https://sipb.mit.edu/doc/safe-shell/
set -euf
if [ "${BASH_VERSINFO[0]}" -ge 3 ]; then
  set -o pipefail
fi
IFS=$'\n\t'
###
# use command debugging
#set -x

if [[ -z ${1-} ]]; then
  system_suffix=""
else
  system_suffix="_$1"
fi

base_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

#Mac AppStore - list all installed apps
mas list >"${base_dir}"/mas-list"${system_suffix}"

#Brew - list all DIRECTLY installed apps (brew leaves does not list automatically installed dependencies)
brew leaves >"${base_dir}"/brew-list"${system_suffix}"

#Brew Cask - list all installed apps
brew list --cask >"${base_dir}"/brew-cask-list"${system_suffix}"
