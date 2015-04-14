#!/usr/bin/env bash

# be sure to install general applications before running installation
/bin/bash brew-cask-install.sh

CASKS=(
  owncloud
  vagrant
  vmware-fusion
  chromium
  chefdk
)

### INSTALL
brew cask install ${CASKS[@]}
