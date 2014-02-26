#!/usr/bin/env bash

# be sure to bootstrap before running script
/bin/bash "$DOTFILES_PATH/brew/"brew-bootstrap.sh

brew update && brew upgrade && echo "update and upgrade done."