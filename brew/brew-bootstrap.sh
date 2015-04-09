#!/usr/bin/env bash
#xcode-select --install

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
if [ ! -f ~/Cellar ];
then
  ln -s /usr/local/Cellar ~/Cellar
fi
