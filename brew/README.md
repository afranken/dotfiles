brew scripts
==========

this directory contains scripts for installing and configuring [homebrew](http://brew.sh/), and installation scripts with essential software.

"plain" brew packages:

* `brew-bootstrap.sh` : install and configure Homebrew
* `brew-install.sh` : install and configure brew packages

use [brew cask](https://github.com/phinze/homebrew-cask) to install applications

* `brew-cask-bootstrap.sh` : bootstrap brew cask configuration
* `brew-cask-install.sh` : install and configure essential applications
* `brew-cask-install-work.sh` : install and configure work applications
* `brew-cask-install-home.sh` : install and configure home applications

Applications installed by `brew cask` are automatically linked to the search scope of [Alfred](http://www.alfredapp.com/).