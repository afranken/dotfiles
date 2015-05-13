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

## check whether XCode command line tools are already installed, otherwise install.
xcode-select -p &> /dev/null
if [ $? -ne 0 ]; then
  xcode-select --install
fi

if [ ! -f /usr/local/bin/brew ];
then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

#set group if not already set
if [ ! -G `brew --prefix` ]; then
  sudo chown -R $USER:staff `brew --prefix`
fi

## get access to updated versions of utilities provided by OSX
brew tap homebrew/dupes
brew tap homebrew/homebrew-versions

##link Cellar into User Home for easy access from various applications (e.g. for setting JDKs in IntelliJ Idea)
if [ ! -d ~/Cellar ];
then
  ln -s /usr/local/Cellar ~/Cellar
fi
