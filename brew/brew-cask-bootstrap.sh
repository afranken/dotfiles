#!/usr/bin/env bash

# be sure to bootstrap before running installation
/bin/bash brew-bootstrap.sh

brew install caskroom/cask/brew-cask
brew tap caskroom/versions

##link Caskroom into User Home for easy access from various applications (e.g. for setting JDKs in IntelliJ Idea)
if [ ! -f ~/Caskroom ];
then
  ln -s /opt/homebrew-cask/Caskroom/ ~/Caskroom
fi
