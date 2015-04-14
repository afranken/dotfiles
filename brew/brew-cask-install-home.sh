#!/usr/bin/env bash

# be sure to install general applications before running installation
/bin/bash brew-cask-install.sh

CASKS=(
  jdownloader
  macpar-deluxe
  openoffice
  picasa
  vlc
  comicbooklover
  comicbookloversync
  truecrypt
)

### INSTALL
brew cask install ${CASKS[@]}
