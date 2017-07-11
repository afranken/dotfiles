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
  1password
  adobe-creative-cloud
  alfred
  cyberduck
  docker
  dropbox
  flash
  google-chrome
  google-drive
  intellij-idea
  intellij-idea-ce
  istat-menus
  #iterm2
  iterm2-beta
  java
  jd-gui
  #path-finder
  silverlight
  skype
  spotify
  textwrangler
  virtualbox
  virtualbox-extension-pack
  visual-studio-code
  visualvm
)

### INSTALL
brew cask install ${CASKS[@]}

### INSTALL maven (has dependency on java installed in this file)
brew install maven
