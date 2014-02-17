#!/bin/bash
if [ ! -f /usr/local/bin/brew ];
then
  ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
fi

sudo chown -R $USER:staff `brew --prefix`

## get access to updated versions of utilities provided by OSX
brew tap homebrew/dupes
