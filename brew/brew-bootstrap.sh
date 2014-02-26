#!/usr/bin/env bash
if [ ! -f /usr/local/bin/brew ];
then
  ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
fi

#set group if not already set
if [ ! -G `brew --prefix` ]; then
  sudo chown -R $USER:staff `brew --prefix`
fi

## get access to updated versions of utilities provided by OSX
brew tap homebrew/dupes
brew tap homebrew/homebrew-versions