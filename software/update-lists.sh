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

base_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

#Mac AppStore - list all installed apps
mas list > "${base_dir}"/mas-list

#Brew - list all DIRECTLY installed apps (brew leaves does not list automatically installed dependencies)
brew leaves > "${base_dir}"/brew-list

#Brew Cask - list all installed apps
brew cask list > "${base_dir}"/brew-cask-list
