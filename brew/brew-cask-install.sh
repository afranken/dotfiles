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


# be sure to bootstrap before running installation
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
${DIR}/brew-cask-bootstrap.sh

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

CASKS=(
  alfred
  firefox
  google-chrome
  silverlight
  dropbox
  google-drive
  unrarx
  flash
  cyberduck
  istat-menus
  java
  java7
  jd-gui
  onyx
  path-finder
  visualvm
  1password
  iterm2
  skype
  intellij-idea-ce
  diffmerge
  spotify
)

### INSTALL
brew cask install ${CASKS[@]}

### INSTALL jvmtop, depends on Java Formula installed above:
brew install jvmtop
