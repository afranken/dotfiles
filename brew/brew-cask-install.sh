#!/usr/bin/env bash

# be sure to bootstrap before running installation
/bin/bash brew-cask-bootstrap.sh

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
  sourcetree
  visualvm
  virtualbox
  1password
  iterm2
  skype
  intellij-idea
  diffmerge
)

### INSTALL
brew cask install ${CASKS[@]}