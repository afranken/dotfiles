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

#Mac AppStore - list all installed apps
mas list > mas-list

#Brew - list all DIRECTLY installed apps (brew leaves does not list automatically installed dependencies)
brew leaves > brew-list

#Brew Cask - list all installed apps
brew cask list > brew-cask-list
